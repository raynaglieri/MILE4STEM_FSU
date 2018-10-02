// change history:
//   September 2017: created by Raymond Naglieri in October 2017 to implement Zhaihuan's 
//      chemistry scenario
//   10/21/2017: change spawn_npc to three routines, the original spawn_npc, 
//               create_npc (does nothing if npc has been created), and
//               remove_npc (does nothing if npc has been created) -XY
//   10/21/2017: fixed channel to talk to NPC -- these channel should be 
//               separated from the facil channels --XY
//   10/21/2017: add features to para processing -- XY
//   10/21/2017: add trainee key -- XY
//   10/25/2017: fixed no question audio --RN
//   10/25/2017: removed a variety of old un-used variables. --RN
//   10/26/2017: removed calls to lab items using the interact_with_lab_channel.
//               commands are now in the backdoor script. --RN
//   10/26/2017: fixed bug involving the -reset command when an NPC was not idle. 
//               NPC will no longer automatically respawn. --RN            
//   10/26/2017: added auto_leave function to simplify leave_npc_s3() --RN
//   01/25/2018: added new keywords and modified s2r to match updated design.


// NPC Variables
integer tc = 0; 
key npc;         // the key for the NPC 
key TA_trainee;
integer myid = 0;  // myid 0 from 7
integer num_npcs = 8;  // total number of npcs in this lab.
string NPC_mood;
string my_behavior;
integer recently_engaged = FALSE;
float randomnum;
string myname; 
string lower_firstname;
string lower_lastname;
integer attentionspan;
string currentquestion = "no_question";
string currentanimation = "no_animation";
string currentdirective = "_:_";
list npc_0_path = ["<0.0,10.0,0.0>" , "<10.0,0.0,0.0>"];
list npc_1_path = ["<0.0,5.0,0.0>" , "<-12.0,0.0,0.0>", "<0.0,6.0,0.0>"];
list npc_2_path = ["<0.0,5.0,0.0>", "<-3.0,0.0,0.0>", "<0.0,5.0,0.0>", "<-10.0,0.0,0.0>", "<0.0,5.0,0.0>"];
list npc_3_path = ["<0.0,5.0,0.0>", "<-2.0,0.0,0.0>", "<0.0,8.0,0.0>", "<-10.0,0.0,0.0>", "<0.0,5.0,0.0>"];
list npc_4_path = ["<0.0,-7.0,0.0>", "<6.0,0.0,0.0>", "<0.0,-12.0,0.0>"];
list npc_5_path = ["<0.0,-5.0,0.0>", "<3.0,0.0,0.0>", "<0.0,-10.0,0.0>"];
list npc_6_path = ["<0.0,-6.0,0.0>", "<6.0,0.0,0.0>", "<0.0,-4.0,0.0>"];
list npc_7_path = ["<4.0,0.0,0.0>", "<0.0,-8.0,0.0>"];

//also add dynamic path wait times

list firstname = ["John", "Michael", "Mary", "Robert", "Linda", "Thomas",
                   "Susan", "Karen", 
                   "Sarah", "David", 
                   "Joey", "Kimberly", "Mark", "Paul", "Jessica", "Cynthia", 
                   "Angela", "Goerge", "Rebecca", "Amanda", "Steven", "Kevin", 
                   "Christine"];
                   
list lastname = ["Smith", "Johnson", "Williams", "Brown", "Jones", 
                  "Miller", "Davis", "Anderson", "Taylor", "Moore",
                  "White", "Lee", "Harris", "Lewis", "Young", 
                  "Gonzalez", "Wang", "Nelson", "Allen", "Baker",
                  "Green", "Kumar", "Campbell", "Sanchez"];   
                  
list moods = ["bored" , "engaged"];   

list lab_key_words = ["follow", "understand the purpose", "observe", "results"];   
list spill_key_words = ["absorb"];
list spill_spec_key_words = ["vinegar", "baking soda", "cold water", "neutralize"];

                            
// NPC Animations                  
list animation_L = ["avatar_impatient", "avatar_angry_fingerwag", "avatar_express_bored",
                     "avatar_brush", "avatar_express_repulsed", "avatar_laugh_short" ];
list animation_LL = ["avatar_angry_tantrum", "avatar_fist_pump", "avatar_stretch",
                     "conversation1-f", 
                      "conversation1", "avatar_express_repulsed","avatar_express_bored",
                      "avatar_laugh_short"];
list animation_LLL = ["avatar_sleep"];  

string string_ani; 

//other globals
integer NPC_ACTION_TAKEN = FALSE;
integer ignore_count = 0;
float   SCAN_RANGE = 10.0;
float   SCAN_INTERVAL = 1.0;
integer switch = 0;
key user;
string prev_msg; 
integer attention_span = 30;
integer reminder_interval = 180;
integer repeat_interval = 20;


//DO NOT MODIFY
// these are the constants used for all scripts for the chemistry lab

integer npc_state_control_base_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;

integer npc_state_control_channel;  // chat channel for human control shared by all scripts
integer npc_para_control_channel;   // para control
integer npc_action_control_channel; // action control chaneel = base_channel + myid;

integer alert_message_channel = 0;
integer green_button_channel = 11500;   // chat channel from green button to npc, to start the lab
integer fire_alarm_channel = 101;
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11001; // chat channel for feedbacks from the dialog box
integer interact_with_lab_channel = 101; // for interactive items in lab

// integer npc_state_control_channel = 10100; // channel for facilitator to control npcs

// some utility variables
integer debug_level = 10;  // debug_level to control messages
string state_name;         // name of the current state
integer state_id;          // id of the state   
integer internal_state;    // working storage to store the status within a state

//helper functions
reset_all() 
{  // resets all globals    
    NPC_mood = "default";
    ignore_count = 0;
    recently_engaged = FALSE;
    NPC_ACTION_TAKEN = FALSE;
    prev_msg = ""; 
    attention_span = 30; 
    string currentquestion = "no_question";
}

string enviro_fact() 
{ //simple random gen
    if(recently_engaged) 
    {
        osNpcSay(npc, 0, "paying attention...");
        randomnum = 1 + (integer)(llFrand(7 - 1 + 1));
    } 
    else 
    {
        osNpcSay(npc, 0, "not paying attention...");
        randomnum = 2 + (integer)(llFrand(15 - 5 + 1));
    }     

    if (randomnum < 5 ) 
    {
        return "ask_question";
    }
        
    return "do_nothing";
} 

backdoor_reset() 
{   // delete npc and reset script
    remove_npc();
    llResetScript();
    return;   
}  

ask_question() 
{   // standard ask question animation sequence  
    llSleep(5);
    llPlaySound("question", 5.0);
    osNpcStopAnimation(npc, currentanimation);
    currentanimation = "raisingahand";
    osNpcPlayAnimation(npc, currentanimation);
    osNpcSay(npc, "Excuse me.");
    return;   
} 

// check is name is in checkname string
// use substring to make it more flexible
integer name_called(string checkname)
{
    string lower_msg = llToLower(checkname);
    if ((llSubStringIndex(lower_msg, lower_firstname) != -1) ||
        (llSubStringIndex(lower_msg, lower_lastname) != -1))    
    {
        return TRUE;
    }
    return FALSE;
} 

integer keyword_match(string msg, key ID, list q_key_words) 
{ // matches keywords in string message, return 1 if found
    string lower_msg = llToLower(msg); 
    integer i = 0;
    string key_word;       
    for(i = 0; i < llGetListLength(q_key_words); i++) 
    {
        key_word = llList2String(q_key_words, i);
        integer index = llSubStringIndex(lower_msg, key_word);
        if(ID != npc)
        {
            if(index == -1) 
            {
                llSay(PUBLIC_CHANNEL,"TEST was not found in the string.");
                llSay(0, key_word);
                osNpcSay(npc, "I don't understand.");     
            } 
            else 
            {  
                llSay(PUBLIC_CHANNEL,"TEST was found in the string.");
                llSay(0, key_word);
                return 1;        
            }
        }    
    }
    return 0;   
}    

integer keyword_match_xy(string msg, list q_key_words) 
{   // matches keywords in string message, return 1 if found
    string lower_msg = llToLower(msg); 
    integer i;
    string key_word;       
    for(i = 0; i < llGetListLength(q_key_words); i++) 
    {
        key_word = llList2String(q_key_words, i);
        if (llSubStringIndex(lower_msg, key_word) != -1) return 1;
    }
    return 0;   
}    


integer spawn_npc() 
{ // spawn procedure for NPC
    if (tc == 0) 
    {    
        npc = osNpcCreate(llList2String(firstname, myid), llList2String(lastname, myid),llGetPos(),"app");
        myname = llKey2Name(npc);
        lower_firstname  = llToLower(llList2String(firstname, myid));
        lower_lastname = llToLower(llList2String(lastname, myid));
        osNpcSay(npc, 0, myname);
        osNpcSit(npc,llGetKey(),OS_NPC_SIT_NOW);
        tc = 1;
        return 1;
    } 
    else 
    { 
        reset_all();
        tc = 0;
        osNpcRemove(npc);
        return 0;     
    }
} 

// this routine only create npc, if npc is already there, do nothing.
integer create_npc() 
{ // spawn procedure for NPC
    if (tc == 0) 
    {    
        npc = osNpcCreate(llList2String(firstname, myid), llList2String(lastname, myid),llGetPos(),"app");
        myname = llKey2Name(npc);
        lower_firstname  = llToLower(llList2String(firstname, myid));
        lower_lastname = llToLower(llList2String(lastname, myid));
        osNpcSay(npc, 0, myname);
        osNpcSit(npc,llGetKey(),OS_NPC_SIT_NOW);
        tc = 1;
        return 1;
    } 
    return 0;
} 

// this routine only delete npc, if npc is not there, do nothing.
integer remove_npc() 
{ // spawn procedure for NPC

    if (tc == 1)
    { 
        reset_all();
        tc = 0;
        osNpcRemove(npc);
        return 1;     
    }
    return 0;
} 


//parse directions given by auto_faciliate or a person 
npc_state_handler(string transferstate)
{   
    currentdirective = transferstate;
    list tmplist = llParseString2List(transferstate, [":"], []);
    string activescenario = llList2String(tmplist, 0);
    string directive  = llList2String(tmplist, 1);

    if(activescenario == "S1")
    {
        if(directive == "0" && myid == 0)
        {
            currentquestion = "Hi, we have a question. We dipped the pH paper into the lime juice, but why our color doesn’t match any of those on the pH chart?";
            state S1Q;
        } 
        else if(directive == "0" && myid == 1 || myid == 2 || myid == 4 || myid == 7)
        {
            osNpcStand(npc);
            currentanimation = "adding_acid";
            osNpcPlayAnimation(npc, currentanimation);
        }
        else if (directive == "3" && myid == 3)
        {
            currentquestion = "I think we need your help. We followed all the procedures, but the color we got doesn’t match any of those in the pH chart. Do you know why?";
            state S1Q;
        } 
        else if(directive == "5" && myid == 5) 
        {
            currentquestion = "Can you take a look at our pH paper? We couldn’t find our color in the pH chart.";
            state S1Q;
        }
        else if (directive == "6" && myid == 6)
        {
            currentquestion = "I don't think we can finish everything in 15 minutes. What should we do?";
            state S1Q;
        } 
        else 
        {
            state Idle;
        }
    }
    else if (activescenario == "S2")
    {
        if(myid == 2)
        {
            currentquestion = "I spilled the acid! What should I do?";
            state S2Spill;
        }
        else 
        {
            state Idle;
        }
        
    }
    else if (activescenario == "S3")
    {

        if(directive == "0" && myid == 0)
        {
            state S3;
        } 
        else if (directive == "1")
        {
            leave_npc_s3();
        }
        else
        {
            state Idle;
        }    
    }
}
auto_leave(list path, integer longest_wait) // add "dynamic" wait times
{   
    osNpcStand(npc);
    rotation rot = osNpcGetRot(npc); 
    integer i;
    for(i = 0; i < llGetListLength(path); i++)
    {
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + (vector)llList2String(path, i)*rot,OS_NPC_NO_FLY);
        llSleep(longest_wait);
    }
}

leave_npc_s3()
{ 
    
    if(myid == 0)
    {
        auto_leave(npc_0_path, 5);
    }
    else if(myid == 1)
    {   
        llSleep(6.0); // so NPCs do not collide. 
        auto_leave(npc_1_path, 6); 
    }
    else if(myid == 2)
    {
        llSleep(10.0);
        auto_leave(npc_2_path, 4); 
    }
    else if(myid == 3)
    {
        llSleep(14.0);
        auto_leave(npc_3_path, 4);
    }
    else if(myid == 4)
    {
        llSleep(12.0);
        auto_leave(npc_4_path, 2);
    }
    else if(myid == 5)
    {
        llSleep(8.0);
        auto_leave(npc_5_path, 2);
    }
    else if(myid == 6)
    {
        llSleep(4.0);
        auto_leave(npc_6_path, 2);
    }
    else if(myid == 7)
    {
        llSleep(2.0);
        auto_leave(npc_7_path, 6);
    } 

    reset_all();
    state Idle;  
} 

register_common_channel()
{
    llListen(npc_state_control_channel, "", NULL_KEY, "");
    llListen(npc_para_control_channel, "", NULL_KEY, "");
    llListen(npc_action_control_channel, "", NULL_KEY, "");
} 

remove_common_channel()
{
    llListenRemove(npc_state_control_channel);
    llListenRemove(npc_para_control_channel);
    llListenRemove(npc_action_control_channel);
}

register_common_channel_timer(integer t)
{
    llListen(npc_state_control_channel, "", NULL_KEY, "");
    llListen(npc_para_control_channel, "", NULL_KEY, "");
    llListen(npc_action_control_channel, "", NULL_KEY, "");
    llSetTimerEvent(t);
}

process_common_listen_port_msg(integer c, string n, key ID, string msg)
{
    if (c == npc_state_control_channel) { // change state include restart

        if(currentanimation != "adding_acid")
        {
            osNpcStopAnimation(npc, currentanimation);
        }

        if (msg == "-repeat") {
            //gotostate(state_id);
        } 
        else if (msg == "-reset")
        {        
            backdoor_reset();     
        } 
        
        else if ((msg == "-s1") || (msg == "S1:0")) 
        {
            llSetTimerEvent(0);    
            npc_state_handler("S1:0");      
        } 
        else if ((msg == "S1:3")) 
        {
            llSetTimerEvent(0);    
            npc_state_handler("S1:3");      
        } 
        else if ((msg == "S1:5")) 
        {
            llSetTimerEvent(0);    
            npc_state_handler("S1:5");      
        } 
        else if ((msg == "S1:6")) 
        {
            llSetTimerEvent(0);    
            npc_state_handler("S1:6");      
        } 
        else if (msg == "-s2") 
        {
            llSetTimerEvent(0);
            npc_state_handler("S2:0");           
        }  
        else if (msg == "-s3") 
        {
            llSetTimerEvent(0);
            npc_state_handler("S3:0");           
        }
        else if (msg == "-s3leave")
        {   
            osNpcStopAnimation(npc ,"adding_acid");
            npc_state_handler("S3:1");
        }
        else
        {
            if (debug_level >= 10) llSay(0, "unknown_command");
        } 

    } 
    else if (c == npc_para_control_channel) 
    { // change script parameters
        list tmplist = llParseString2List(msg, [" "], []);
        string ss = llList2String(tmplist, 0);
        integer val = llList2Integer(tmplist, 1);
        if (ss == "@Querydebug_level") 
        {
            osNpcSay(npc, "debuy_level = " + debug_level);
        }
        else if (ss == "@Querystate") 
        {
            osNpcSay(npc, "state = " + state_name);
        } 
        else if (ss == "@Queryreminder_interval") 
        {
            osNpcSay(npc, "reminder_interval = " + reminder_interval);
        } 
        else if (ss == "@Queryrepeat_interval") 
        {
            osNpcSay(npc, "repeat_interval = " + repeat_interval);
        } 
        else if (ss == "@Querymyid") {
            osNpcSay(npc, "myid = " + myid);
        }
        else if (ss == "@Setdebug_level") 
        {
            debug_level = val;
        } 
        else if  (ss == "@Setreminder_interval") 
        {
            reminder_interval = val;
        } 
        else if  (ss == "@Setrepeat_interval") 
        {
            repeat_interval = val;
        } 
        else if (ss == "@Setmyid") {
            myid = val;
            spawn_npc(); // keep
            spawn_npc();
            reset_all();
            remove_common_channel();
            npc_state_control_channel = npc_state_control_base_channel + myid;
            npc_para_control_channel = npc_para_control_base_channel + myid;
            npc_action_control_channel = npc_action_control_base_channel + myid;
            register_common_channel_timer(reminder_interval);
            state Idle;
        }
        else if (ss == "@Resetscript") 
        {
            llResetScript();
        }
    } 
    else if (c == npc_action_control_channel) 
    { // perform action when needed
      // npc_state_handler(msg);
      // to be added, 
    } 
    else 
    {
        // do nothing
    }
}  

default 
{
    state_entry() 
    {
        state_name = "default";
        NPC_mood = "default";
        npc_state_control_channel = npc_state_control_base_channel + myid;
        npc_para_control_channel = npc_para_control_base_channel + myid;
        npc_action_control_channel = npc_action_control_base_channel + myid;
        llListen(green_button_channel, "", NULL_KEY, "");
    }
    
    touch_start( integer num) 
    {
        spawn_npc();
        state Idle;  
    }
    
    listen(integer channel, string name, key id, string message) 
    {
        if(channel == green_button_channel) // talk between channels was causing an inital unwanted re-spawn.
        {                                   //need to find exactly what is causing it.
            spawn_npc(); 
            state Idle; 
        }
 
    }      
}

// when an npc is not engaged in a scenario
state Idle 
{
    state_entry()
    {
        state_name = "Idle";
        register_common_channel_timer(reminder_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        backdoor_reset();
    }
  
    timer()
    {
        osNpcSay(npc, "Idle for " + reminder_interval + " seconds, ready to take command."); //send message to alert_user
        llSetTimerEvent(reminder_interval);
    }  

    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(reminder_interval);       
        process_common_listen_port_msg(c, n, ID, msg);
    }
}   

////////////////////////S1////////////////////////

//npc raises hand and waits for their name to be called
state S1Q 
{
    state_entry()
    {
        state_name = "S1Q";
        register_common_channel_timer(repeat_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        ask_question();
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {
        ask_question();
        llSetTimerEvent(repeat_interval);
    }
    
    listen(integer c, string n, key ID, string msg) 
    {   
        if ((c == PUBLIC_CHANNEL) && (ID != npc))
        {
            if(name_called(msg))
            {
                llSetTimerEvent(repeat_interval);
                if (debug_level > 10) llSay(0,"name_detected");
                osNpcStopAnimation(npc, currentanimation);
                llSetTimerEvent(0);
                state S1R;
            }
        } 
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }    
    }   
} 

// npc waits for a response that matches the keywords
state S1R 
{
    state_entry()
    {
        internal_state = 0;
        state_name = "S1R";
        register_common_channel_timer(repeat_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        osNpcSay(npc, currentquestion);
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {
        // llSay(alert_message_channel, "S1R: An NPC is waiting for you to answer their question.");
        if (internal_state < 5) {
            osNpcSay(npc, "I am sorry, I have not heard the answer.");
            osNpcSay(npc, currentquestion);
            llSetTimerEvent(repeat_interval);
            internal_state ++;
        } else {
             state S1Q;
        }
    }
    
    listen(integer c, string n, key ID, string msg) 
    {
        
        if ((c == PUBLIC_CHANNEL) && (ID!=npc))
        {
            if(keyword_match_xy(msg, lab_key_words))
            {
                llSetTimerEvent(repeat_interval);
                reset_all();
                // llSay(facil_action_control_channel, currentdirective); // not supported.
                // let auto_facil know the current question has been completed
                osNpcSay(npc, "Great. Thank you.");
                if (myid == 0) 
                {
                    llSay(npc_state_control_base_channel+3, "S1:3");
                }
                else if (myid == 3)
                {
                    llSay(npc_state_control_base_channel+5, "S1:5");
                }
                else if (myid == 5)
                {
                    llSay(npc_state_control_base_channel+6, "S1:6");
                }

                state Idle;
            } 
        } 
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }    
    }  
}

// ////////////////////////S2////////////////////////

state S2Spill 
{
    state_entry()
    {
        internal_state = 0;
        state_name = "S2Spill";
        register_common_channel_timer(repeat_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        ask_question();
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {
        ask_question();
        llSetTimerEvent(repeat_interval);
    }

    
    listen(integer c, string n, key ID, string msg) 
    {

        if ((c == PUBLIC_CHANNEL) && (ID != npc))
        {
            if(name_called(msg))
            {
                llSetTimerEvent(repeat_interval);
                if (debug_level >= 10) llSay(0,"name_detected");
                state S2R;
            }
        } 
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }    
    }   
} 

state S2R 
{
    state_entry()
    {
        state_name = "S2R";
        register_common_channel_timer(reminder_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        osNpcSay(npc, currentquestion);
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() {
        if (internal_state < 5) {
            osNpcSay(npc, "I am sorry, I have not heard the answer.");
            osNpcSay(npc, currentquestion);
            llSetTimerEvent(repeat_interval);
            internal_state ++;
        } else {
             state S1Q;
        }
    }
    
    listen(integer c, string n, key ID, string msg) 
    {
        if ((c == PUBLIC_CHANNEL) && (ID !=npc))
        {

            if(keyword_match_xy(msg, spill_spec_key_words))
            {
                llSetTimerEvent(repeat_interval);
                reset_all();
                // llSay(facil_action_control_channel, currentdirective); // no automatic facil yet
                osNpcSay(npc, "Thanks! I'll try that.");
                state Idle;
            }

            if(keyword_match_xy(msg, spill_key_words))
            {
                llSetTimerEvent(repeat_interval);
                reset_all();
                // llSay(facil_action_control_channel, currentdirective); // no automatic facil yet
                osNpcSay(npc, "How do I do that?");
            }
        }  
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }    
    }  
}

// ////////////////////////S3////////////////////////

state S3
{
    state_entry()
    {
        state_name = "S3";
        register_common_channel_timer(repeat_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        rotation rot = osNpcGetRot(npc);  
        osNpcStand(npc);
        llSleep(2.0);        
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <2.0,0.0,0.0>*rot,OS_NPC_NO_FLY); //direction based on other lab
        llSleep(2.0);
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <0.0,4.0,0.0>*rot,OS_NPC_NO_FLY);
        llSleep(3.0);
        ask_question();
        osNpcSay(npc, "Fire! Hurry!");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {
        ask_question();
        osNpcSay(npc, "Fair! Hurry!");
        llSetTimerEvent(repeat_interval);
    }
    
    listen(integer c, string n, key ID, string msg) 
    {
        if ((c == PUBLIC_CHANNEL) && (ID != npc))
        {
            if(name_called(msg))
            {    
                if (debug_level > 10) llSay(0,"name_detected");
                llSetTimerEvent(0);
                state S3R;
            }
        } 
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }           
    }        
} 

state S3R
{
    state_entry()
    {
        state_name = "S3R";
        register_common_channel_timer(repeat_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        osNpcSay(npc, "There is a fire! What should we do?");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {
        osNpcSay(npc, "I am sorry. There is a fire! What should we do?");
        llSetTimerEvent(repeat_interval);
    }
    
    listen(integer c, string n, key ID, string msg) 
    {
        if ((c == PUBLIC_CHANNEL) && (ID != npc))
        {
            string lower_msg = llToLower(msg);

            if(llSubStringIndex(lower_msg, "alarm") != -1) 
            {     
                osNpcSay(npc, "Okay Im on it!");
                llSay(fire_alarm_channel, "-alarm-on");
                NPC_ACTION_TAKEN = TRUE;  
            }    
                    
            if (llSubStringIndex(lower_msg, "911") != -1) 
            { 
                osNpcSay(npc, "I'll Call 911.");
                llSleep(2.0);
                osNpcSay(npc, "Hi 911, We have a fire in the chemistry lab...");
                NPC_ACTION_TAKEN = TRUE;
            }     
               
            if (llSubStringIndex(lower_msg, "leave") != -1) 
            {
                osNpcSay(npc, "Okay we'll exit the classroom");
                llSay(backdoor_channel, "-npcs3left");
                NPC_ACTION_TAKEN = TRUE;
            } 
            
            if(NPC_ACTION_TAKEN)
            {    
                reset_all();
                state Idle;    
            }      
            state S3R;
        } 
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }    
    }         
} 



