// change history:
//   September 2017: created by Raymond Naglieri in October 2017 
//   December 2017: Wait2Speak and Wait2SpeakList functionality done. 
//         2/15/17: added debug level
//         2/28/18: completed AnimationHandle

// Notes:
//  1. Please use the currentanimation variable when playing an animation.

// NPC Variables
integer tc = 0; 
key npc;         // the key for the NPC 
key TA_trainee;
integer myid = 0;  // myid 0 from 7
integer mygroup = 1;
integer num_npcs = 8;  // total number of npcs in this lab.
string mymood;
string my_behavior;
integer recently_engaged = FALSE;
float randomnum;
string myname; 
string lower_firstname;
string lower_lastname;
integer attentionspan;
integer wait_time = 5;
integer wait_talk = 1;
string to_say = "NULL";
string currentquestion = "no_question";
string currentanimation = "no_animation";
string currentsound = "no_sound";
string currentdirective = "_:_";
list npc_0_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_1_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_2_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_3_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_4_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_5_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_6_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];
list npc_7_path = ["<0.0,-0.5,0.0>" , "<-2.0,0.0,0.0>"];

list npc_0_path_ret = ["<-2.0,0.0,0.0>" , "<0.0,-0.5,0.0>"];
list npc_1_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];
list npc_2_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];
list npc_3_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];
list npc_4_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];
list npc_5_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];
list npc_6_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];
list npc_7_path_ret = ["<2.0,0.0,0.0>" , "<0.0,0.5,0.0>"];

list group_one = ["group1", "group 1", "groupone", "group one", "first group", "firstgroup"];
list group_two = ["group2", "group 2", "grouptwo", "group two", "second group", "secondgroup"];

list group_one_metaphors = ["metaphor1", "metaphor2", "metaphor3", "metaphor4"];
list group_two_metaphors = ["metaphor1", "metaphor2", "metaphor3", "metaphor4"];

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

list group_one_members = ["john", "michael", "mary", "robert", "smith", "johnson", "williams", "brown"];
list group_two_members = ["linda", "thomas", "susan", "karen", "jones", "miller", "davis", "anderson"]; 
                  
list moods = ["bored" , "neutral" , "engaged"];   
list state_privilege = ["Idle:1", "GroupThink:1"]; // can be called from 1(bored and above) - 3(engaged only) 

                            
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
key chair;
string prev_msg; 
integer attention_span = 30;
integer reminder_interval = 180;
integer repeat_interval = 20;
///
list pending_convo;
integer pending_convo_count = 0;
integer pending_convo_loc = 0;
string cur_sentence;
integer list_wait = 1;
list sentence_and_time;
integer speak_with_question = 0;

list pending_actions; 

integer perform_for_time = 0;
integer perform_for_iter = 0;
integer perform_iter_remaining = 0;



integer perform_amount = 0;
integer DEFAULT_AMOUNT = 100;



//DO NOT MODIFY
// these are the constants used for all scripts for the lecture
integer facil_state_control_channel = 10101;

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
integer debug_level = 0;  // debug_level to control messages
string state_name;         // name of the current state
integer state_id;          // id of the state   
integer internal_state;    // working storage to store the status within a state

//helper functions
reset_all() 
{  // resets all globals    
    mymood = "neutral";
    ignore_count = 0;
    recently_engaged = FALSE;
    NPC_ACTION_TAKEN = FALSE;
    prev_msg = ""; 
    attention_span = 30; 
    string currentquestion = "no_question";
    perform_for_time = 0;
    perform_for_iter = 0;
    perform_iter_remaining = 0;
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

provide_metaphor() //rewrite
{
    integer index = 0;
    if(random_integer(0,7) <= 4)
    {    
        if (mygroup == 1)
        {
            index = random_integer(0, llGetListLength(group_one_metaphors));
            osNpcSay(npc, llList2String(group_one_metaphors, index));
        } 
        else
        {
            index = random_integer(0, llGetListLength(group_two_metaphors));
            osNpcSay(npc, llList2String(group_two_metaphors, index));
        }       
    }      
}

random_mood()
{
    mymood = llList2String(moods,random_integer(0,2));
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
                if(debug_level)
                {
                    if(debug_level)
                        llSay(0, key_word);
                }
                osNpcSay(npc, "I don't understand.");     
            } 
            else 
            {  
                if(debug_level)
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

integer keyword_match_multi(string msg, list q_key_words, integer match_amount) 
{   // matches keywords in string message, return 1 if found
    string lower_msg = llToLower(msg); 
    integer i;
    string key_word;   
    integer found_count = 0;     

    for(i = 0; i < llGetListLength(q_key_words); i++) 
    {
        key_word = llList2String(q_key_words, i);
        if (llSubStringIndex(lower_msg, key_word) != -1)
        {
            found_count++;
            if(found_count >=3)
                return 1;
        }       
    }
    return 0;   
}

integer random_integer(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
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
npc_state_handler(string transferstate, integer c, string n, key ID, string msg)
{   
    currentdirective = transferstate;
    list tmplist = llParseString2List(transferstate, [":"], []);
    string activescenario = llList2String(tmplist, 0);
    string directive  = llList2String(tmplist, 1);

    if(activescenario == "G")
    {
        if(directive == "0")
        {
            leave_npc_group();
            state GroupThink;
        }  
        else if(directive == "1")
        {
            provide_metaphor();
        } 
        else if(directive == "2")
        {
            return_npc_group();
        }
    } 
    else if(activescenario == "S")
    {
        if(directive == "1")
        {
            random_mood();
            if(debug_level)
                llSay(0,mymood);
            state Quiz;
        } 
        else if(directive == "2")
        {
            state Quiz;
        }

    }
    else if(activescenario == "H")
    {   
        integer subgoalint;
        list actlist = llParseString2List(directive, ["-"], []);
        directive = llList2String(actlist, 0);
        subgoalint  = llList2Integer(actlist, 1);
        wait_time = subgoalint;

        if(directive == "1")
        {
            state Wait;
        }
        else if (directive == "2")
        {
            state Wait2Speak; 
        }  
        else if(directive == "3")
        {
            state WaitIteration;
        }
        else if(directive == "4")
        {
            state WaitIndef;
        }
    }
    else if(activescenario == "A")
    {
        if(directive == "1")
        {
            currentquestion = "You are speaking too fast.";
            speak_with_question = 1;
            currentsound = "You_are_talking_too_fast";
            state Ask;
        } 
        else if (directive == "2")
        {
            currentquestion = "I don't understand your example.";
            state Ask;
        } 
        else if(directive == "3") 
        {
            currentquestion = "Thank you for the lecture!";
            state Ask;
        }
    } 
    else if (activescenario == "M")
    {
        if(directive == "1")
        {
            currentanimation = "avatar_express_wink";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 3;
        } 
        else if (directive == "2")
        {
            currentanimation = "avatar_express_sad";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 3;
        } 
        else if(directive == "3") 
        {
            currentanimation = "Defensive";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 3;
        }
        else if(directive == "4") 
        {
            currentanimation = "avatar_no_unhappy";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 3;
        }
        else if(directive == "5") 
        {
            currentanimation = "avatar_no_unhappy";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 3;
        }
        else if(directive == "6") 
        {
            currentanimation = "avatar_express_wink";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 200;
        }
        else if(directive == "7") 
        {
            currentanimation = "avatar_express_sad";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 200;
        }
        else if(directive == "8") 
        {
            currentanimation = "avatar_express_sad";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 3;
        }
        else if(directive == "9") 
        {
            currentanimation = "adding_acid";
            wait_time = 25;
            perform_for_time = 1;
            perform_for_iter = 0;
            perform_iter_remaining = 0;
        }

        osNpcPlayAnimation(npc, currentanimation);
        state AnimationHandle;
    }
    else if (activescenario == "T")
    {
        if(directive == "1")
        {
            currentanimation = "adding_acid";
            wait_time = 25;
            perform_for_time = 1;
            perform_for_iter = 0;
            perform_iter_remaining = 0;
        }
        else if(directive == "2")
        {
            currentanimation = "Okay_nodding";
            wait_time = 5;
            perform_for_time = 1;
            perform_for_iter = 1;
            perform_iter_remaining = 5;
        }
        else if(directive == "3")
        {
            currentanimation = "Okay_nodding";
        }
        else if(directive == "4")
        {
            currentanimation = "Okay_nodding";
        }

        osNpcPlayAnimation(npc, currentanimation);
        state AnimationHandle;
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

leave_npc_group()
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

return_npc_group()
{ 
    if(myid == 0)
    {
        auto_leave(npc_0_path_ret, 5);
    }
    else if(myid == 1)
    {   
        llSleep(6.0); // so NPCs do not collide. 
        auto_leave(npc_1_path_ret, 6); 
    }
    else if(myid == 2)
    {
        llSleep(10.0);
        auto_leave(npc_2_path_ret, 4); 
    }
    else if(myid == 3)
    {
        llSleep(14.0);
        auto_leave(npc_3_path_ret, 4);
    }
    else if(myid == 4)
    {
        llSleep(12.0);
        auto_leave(npc_4_path_ret, 2);
    }
    else if(myid == 5)
    {
        llSleep(8.0);
        auto_leave(npc_5_path_ret, 2);
    }
    else if(myid == 6)
    {
        llSleep(4.0);
        auto_leave(npc_6_path_ret, 2);
    }
    else if(myid == 7)
    {
        llSleep(2.0);
        auto_leave(npc_7_path_ret, 6);
    } 
    osNpcSit(npc,llGetKey(),OS_NPC_SIT_NOW);
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
    if (c == npc_state_control_channel) 
    { // change state include restart

        if (msg == "-repeat") 
        {
            //not yet supported
        } 
        else if (msg == "-reset")
        {        
            backdoor_reset();     
        } 
        else if (msg == "-group")
        {   
            npc_state_handler("G:0", c, n, ID, msg);
        }
        else if (msg == "-groupspeak")
        {   
            npc_state_handler("G:1", c, n, ID, msg);
        }
        else if (msg == "-groupreturn")
        {
            npc_state_handler("G:2", c, n, ID, msg);
        }
        else if (msg == "-showmood")
        {   
            npc_state_handler("S:1", c, n, ID, msg);
        }
        else if(msg == "-quiz")
        {
            npc_state_handler("S:2", c, n, ID, msg);
        }
        else if(msg == "-npcwait")
        {
            npc_state_handler("H:1-20", c, n, ID, msg);
        }
        else if(msg == "-npcwaititer")
        {
            npc_state_handler("H:3-10", c, n, ID, msg);
        }
        else if(msg == "-npcwaitindef")
        {
            npc_state_handler("H:4-10", c, n, ID, msg);
        }
        else if(msg == "-npcask")
        {
            npc_state_handler("A:1", c, n, ID, msg);
        }
        else if(msg == "-npcask2")
        {
            npc_state_handler("A:2", c, n, ID, msg);
        }
        else if(msg == "-npcask3")
        {
            npc_state_handler("A:3", c, n, ID, msg);
        }
        else if(msg == "-npcmove1")
        {
            npc_state_handler("M:1", c, n, ID, msg);
        }
        else if(msg == "-npcmove2")
        {
            npc_state_handler("M:2", c, n, ID, msg);
        }
        else if(msg == "-npcmove3")
        {
            npc_state_handler("M:3", c, n, ID, msg);
        }
        else if(msg == "-npcmove4")
        {
            npc_state_handler("M:4", c, n, ID, msg);
        }    
        else if(msg == "-npcmove5")
        {
            npc_state_handler("M:5", c, n, ID, msg);
        }  
        else if(msg == "-npcmove6")
        {
            npc_state_handler("M:6", c, n, ID, msg);
        } 
        else if(msg == "-npcmove7")
        {
            npc_state_handler("M:7", c, n, ID, msg);
        } 
        else if(msg == "-npcmove8")
        {
            npc_state_handler("M:8", c, n, ID, msg);
        }
        else if(msg == "-npcmove9")
        {
            npc_state_handler("M:9", c, n, ID, msg);
        }
        else if(msg == "-testcmdanim1")
        {
            npc_state_handler("T:1", c, n, ID, msg);
        }
        else if(msg == "-testcmdanim2")
        {
            npc_state_handler("T:2", c, n, ID, msg);
        }
        else if(msg == "-stopanim_idle")
        {
            osNpcStopAnimation(npc, currentanimation);
            state Idle;
        }
        else
        {
            if (debug_level) llSay(0, "unknown_command");
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
        else if (ss == "@Setmyid") 
        {
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
        else if (ss == "@Setwait_talk")
        {
            wait_talk = (integer)val;
        }
        else if(ss == "@SetAsk")
        {
            currentquestion = ss;
        }
        else if (ss == "@Resetscript") 
        {
            llResetScript();
        }
    } 
    else if (c == npc_action_control_channel) 
    { // perform action when needed
        list tmplist = llParseString2List(msg, ["-"], []);
        string action_spec = llList2String(tmplist, 0);
        string action = llList2String(tmplist, 1);
        if (action_spec == "@Speak") 
        {
            to_say = action;
            state Wait2Speak;
        } 
        else if(action_spec == "@SpeakList")
        {
            pending_convo = llParseString2List(action, ["::"],[]);
            pending_convo_count = llGetListLength(pending_convo);
            state Wait2SpeakList;
        }
        else if (action_spec == "@SpeakAnim")
        {
            pending_actions = llParseString2List(action, ["::"],[]);
            state DelayAction;
        }
        
        else if (action_spec == "@Hand_up")
        {   
            
            osNpcStopAnimation(npc, currentanimation);
            currentanimation = "raisingahand";
            osNpcPlayAnimation(npc, currentanimation);
        }
        else if (action_spec == "@Stop_ani")
        {
            osNpcStopAnimation(npc, currentanimation);
        } 
        else if(action_spec == "@Perform")
        {
            osNpcStopAnimation(npc, currentanimation);
            currentanimation = action;
            osNpcPlayAnimation(npc, currentanimation);
        }
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
        mymood = "neutral";
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
        if(debug_level)
            llSay(0,"Idle");
        state_name = "Idle";
        register_common_channel_timer(reminder_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        backdoor_reset();
    }
  
    timer()
    {
        if(debug_level)
            osNpcSay(npc, "Idle for " + reminder_interval + " seconds, ready to take command."); //send message to alert_user
        llSetTimerEvent(reminder_interval);
    }  

    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(reminder_interval);       
        process_common_listen_port_msg(c, n, ID, msg);
    }
}   

// ////////////////////////GroupThink//////////////////////// //

state GroupThink
{
    state_entry()
    {
        state_name = "GroupThink";
        register_common_channel_timer(reminder_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        //llSay(0, "");
    }
    
    listen(integer c, string n, key ID, string msg) 
    {
        if ((c == PUBLIC_CHANNEL) && (ID !=npc))
        {   
            string lower = llToLower(msg);
            if (llSubStringIndex(lower,  "group") != -1)
            {
                if(keyword_match_xy(msg, group_one) || keyword_match_xy(msg, group_one_members))
                {      
                    llSetTimerEvent(repeat_interval);
                    reset_all();
                    if(mygroup == 1)
                    {
                        osNpcSay(npc, "We did it!");
                        if(myid == 0)
                        {
                            llSay(facil_state_control_channel, "-mfu");
                        }
                    }
                    state Idle;
                }
                else if(keyword_match_xy(msg, group_two) || keyword_match_xy(msg, group_two_members))
                {
                    llSetTimerEvent(repeat_interval);
                    reset_all();
                    if(mygroup == 2)
                    {
                        osNpcSay(npc, "We did it!");
                        if(myid == 7)
                        {
                            llSay(facil_state_control_channel, "-mfu");
                        }
                    }
                    state Idle;
                } 
            } 
        } 
        else
        {
            llSetTimerEvent(repeat_interval);
            process_common_listen_port_msg(c, n, ID, msg);     
        }    
    }  
}

// ////////////////////////Show_focus//////////////////////// //
state Show_focus
{
    state_entry()
    {
        register_common_channel_timer(reminder_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
        if(mymood == "bored")
        {
            osNpcPlayAnimation(npc, "avatar_impatient");
        }
        else
        {
            if(debug_level)
                llSay(0, "not bored");
            //osNpcPlayAnimation(npc, "avatar_impatient");
        }  
    }

    listen(integer c, string n, key ID, string msg) 
    {
        if(c == PUBLIC_CHANNEL)
        {
            if(keyword_match_xy(msg, ["quiz"]))
            {
                if(debug_level)
                    llSay(0, "Quiz");
                osNpcStopAnimation(npc, "avatar_impatient");
                state Quiz;
            }
        }
        else
        {
            process_common_listen_port_msg(c, n, ID, msg);    
        }
        
    }

}

state Quiz
{
    state_entry()
    {
        register_common_channel_timer(reminder_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    }  

    listen(integer c, string n, key ID, string msg)
    {
        if(c == PUBLIC_CHANNEL)
        {
            if(name_called(msg)) 
            {
                if(mymood == "bored")
                {
                    osNpcSay(npc, "I have no idea.");
                }
                else
                {
                    if(random_integer(0,1))
                    {
                        osNpcSay(npc, "True.");
                    } 
                    else
                    {
                       osNpcSay(npc, "False."); 
                    }     
                }  
            }
        }
        else
        {
            process_common_listen_port_msg(c, n, ID, msg);
        }
        
    }
}

state Ask
{
    state_entry()
    {
        ask_question();
        register_common_channel_timer(wait_time);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {
        ask_question();
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        if(c == PUBLIC_CHANNEL)
        {
            if(name_called(msg)) 
            {
                osNpcStopAnimation(npc, currentanimation);
                osNpcSay(npc, currentquestion);
                if(speak_with_question)
                {
                    llPlaySound(currentsound, 3.0);
                    speak_with_question = 0;
                }
                state Idle;
            }
        }  else process_common_listen_port_msg(c, n, ID, msg);   
    }


}

state Wait
{
    state_entry()
    {
        if(debug_level)
            llSay(0,(string)wait_time);
        register_common_channel_timer(wait_time);
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        osNpcStopAnimation(npc, currentanimation);
        state Idle;
    }

    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg(c, n, ID, msg);   
    }
    
}

state AnimationHandle
{
    state_entry()
    {
        if(debug_level)
            llSay(0,(string)wait_time);
        if(perform_for_time)
            register_common_channel_timer(wait_time);
        else
            register_common_channel();
    }

    touch_start(integer num_detected)
    {
        backdoor_reset();
    }

    timer()
    {
        if(perform_for_iter)
        {
            if(perform_iter_remaining > 0)
            {
                llSay(0, (string)perform_iter_remaining);
                osNpcStopAnimation(npc, currentanimation);
                osNpcPlayAnimation(npc, currentanimation);
                perform_iter_remaining--;
            }
            else
            {
                osNpcStopAnimation(npc, currentanimation);
                state Idle;
            }
        }    
        else
        {
            osNpcStopAnimation(npc, currentanimation);
            state Idle;        
        }
    }

    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg(c, n, ID, msg);   
    }
}

// state Wait
// {
//     state_entry()
//     {
//         if(debug_level)
//             llSay(0,(string)wait_time);
//         register_common_channel_timer(wait_time);
//     }

//     touch_start(integer num_detected)
//     { 
//         backdoor_reset();
//     }

//     timer() 
//     {
//         osNpcStopAnimation(npc, currentanimation);
//         state Idle;
//     }

//     listen(integer c, string n, key ID, string msg)
//     {
//         process_common_listen_port_msg(c, n, ID, msg);   
//     }
    
// }

// state WaitIteration
// {
//     state_entry()
//     {
//         perform_amount = DEFAULT_AMOUNT;
//         if(debug_level)
//             llSay(0,(string)wait_time);
//         register_common_channel_timer(wait_time);
//     }

//     touch_start(integer num_detected)
//     { 
//         backdoor_reset();
//     }

//     timer() 
//     {
//         if(perform_amount > 0)
//         {
//             osNpcStopAnimation(npc, currentanimation);
//             osNpcPlayAnimation(npc, currentanimation);
//         }
//         else
//         {
//             osNpcStopAnimation(npc, currentanimation);
//             state Idle;   
//         }
//         perform_amount--;
//     }

//     listen(integer c, string n, key ID, string msg)
//     {
//         process_common_listen_port_msg(c, n, ID, msg);   
//     }
    
// }

// state WaitIndef
// {
//     state_entry()
//     {
//         if(debug_level)
//             llSay(0,(string)wait_time);
//         register_common_channel_timer(wait_time);
//     }

//     touch_start(integer num_detected)
//     { 
//         backdoor_reset();
//     }

//     timer() 
//     {
//         osNpcStopAnimation(npc, currentanimation);
//         osNpcPlayAnimation(npc,currentanimation);
//         llSetTimerEvent(wait_time);
//     }

//     listen(integer c, string n, key ID, string msg)
//     {
//         process_common_listen_port_msg(c, n, ID, msg);   
//     }
    
// }


state DelayAction
{
    state_entry()
    {
    
        register_common_channel_timer((integer)llList2String(pending_actions, 3));
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        osNpcStopAnimation(npc, currentanimation);
        state SpeakAnimation;
    }

    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg(c, n, ID, msg);   
    }
}

state SpeakAnimation
{
    state_entry()
    {
        perform_amount = DEFAULT_AMOUNT;
        currentanimation = llList2String(pending_actions, 1);
        if(debug_level)
            llSay(0, llList2String(pending_actions, 1));
        osNpcPlayAnimation(npc, currentanimation);
        osNpcSay(npc, llList2String(pending_actions, 0));
        if(debug_level)
            llSay(0, llList2String(pending_actions, 2));
        register_common_channel_timer((integer)llList2String(pending_actions, 2));
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        if(perform_amount > 0)
        {
            osNpcStopAnimation(npc, currentanimation);
            osNpcPlayAnimation(npc, currentanimation);
        }
        else
        {
            osNpcStopAnimation(npc, currentanimation);
            state Idle;   
        }
        perform_amount--;

    }

    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg(c, n, ID, msg);   
    }
    
}

state Wait2Speak
{
    state_entry()
    {
        if(debug_level)
            llSay(0,(string)wait_talk);
        register_common_channel_timer(wait_talk);
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        osNpcSay(npc, to_say);
        wait_talk = 1;
        state Idle;
    }

    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg(c, n, ID, msg);   
    }
    
}

state Wait2SpeakList
{
    state_entry()
    {
        sentence_and_time = llParseString2List(llList2String(pending_convo, pending_convo_loc), ["#"],[]);
        if(debug_level)
            llSay(0, llList2String(pending_convo, pending_convo_loc));
        cur_sentence = llList2String(sentence_and_time, 0);
        list_wait = llList2Integer(sentence_and_time, 1);
        if(debug_level)
            llSay(0,(string)list_wait);
        register_common_channel_timer(list_wait);
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        osNpcSay(npc, cur_sentence);
        pending_convo_loc++;
        pending_convo_count --;
        if(pending_convo_count == 0)
        {
            pending_convo_loc = 0;
            pending_convo_count = 0;
            sentence_and_time = [];
            pending_convo = [];
            list_wait = 1;

            state Idle;
        }
        sentence_and_time = llParseString2List(llList2String(pending_convo, pending_convo_loc), ["#"],[]);
        if(debug_level)
            llSay(0, llList2String(pending_convo, pending_convo_loc));
        cur_sentence = llList2String(sentence_and_time, 0);
        list_wait = llList2Integer(sentence_and_time, 1);
        llSetTimerEvent(list_wait);
    }

    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg(c, n, ID, msg);   
    }
    
}
