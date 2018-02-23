// change history:
//   October 2017:   created by Raymond Naglieri in October 2017 
//   December 2017:  Wait2Speak and Wait2SpeakList functionality done. 
//   January 2018:   added A5-10 and R3-7;
//                   ask_question() added to timer event in: State Ask 
//                   added random animation to idle state;
//        2/1/18:    added auto_facil support.  
//        2/8/18:    added initial audio respose feature.


// Notes:
//  1. Please use the currentanimation variable when playing an animation.

//master keyword :"$%&", add override. 


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
string correct_response = "";
string gen_response = "";
string say_this = "";
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

list group_one_metaphors = ["Pile of books", "Pile of plates", "Birds", "Several apples", "Guitar", "Piece of rope", "Pitcher of lemonade" , "Milk truck"];
list group_two_metaphors = ["Knot",  "Piece of rope", "Set of glasses", "Glasses and newspaper", "Message in the bottle", "Board games", "File cabinet"];

list keywords_current = []; // active keywords


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

list lab_animations = ["writing_at_desk", "Well"];
list npc1_lab_sounds = ["NPC1a", "NPC1b", "NPC1c"];
list npc2_lab_sounds = ["NPC2a", "NPC2b"];
list npc3_lab_sounds = ["NPC3a", "NPC3b", "NPC3c"];
list npc4_lab_sounds = ["NPC4a", "NPC4b"];
list npc5_lab_sounds = ["NPC5a", "NPC5b"];
list npc6_lab_sounds = ["NPC6-1", "NPC6-2", "NPC6-3"];
list npc7_lab_sounds = ["NPC7-1", "NPC7-2"];
list npc8_lab_sounds = ["NPC8-1", "NPC8-2"];

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
integer speak_interval = 5;
///
list pending_convo;
integer pending_convo_count = 0;
integer pending_convo_loc = 0;
string cur_sentence;
integer list_wait = 1;
list sentence_and_time;
integer keyword_match_amount = 0; 
integer speak_with_question = 0;
integer speak_with_response = 0;
integer speech_delay = 0;
integer signal_npc_reponse = 0;
list signal_offsets = [];
integer resp_signal_offset = 0;
integer signal_response_num = 0;
integer exit_on_incorrect = 0;
key ignore_this_npc = NULL_KEY;
list pending_actions; 
integer signal_action_complete = 0;



//DO NOT MODIFY
// these are the constants used for all scripts
integer facil_state_control_channel = 10101;
integer auto_facil_control_channel = 10102;

integer npc_state_control_base_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer npc_to_npc_signal_base_channel = 34000;

integer npc_state_control_channel;  // chat channel for human control shared by all scripts
integer npc_para_control_channel;   // para control
integer npc_action_control_channel; // action control chaneel = base_channel + myid;
integer npc_to_npc_signal;

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

random_lab_anim()
{
    osNpcStopAnimation(npc, currentanimation);
    list random_anims = llListRandomize(lab_animations, 1);
    currentanimation = llList2String(random_anims, 0);
    osNpcPlayAnimation(npc, currentanimation);
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

set_ask_settings(integer swq, integer snr, list so, integer srn, integer kma, integer eoi, integer sac)
{
    speak_with_question = swq;
    signal_npc_reponse = snr;
    signal_offsets = so;
    signal_response_num = srn;
    keyword_match_amount = kma;
    exit_on_incorrect = eoi;
    signal_action_complete = sac;
}

set_response_settings(integer sqr, integer sd, integer rso, string st)
{

    speak_with_response = sqr;
    speech_delay = sd;
    resp_signal_offset = rso;
    say_this = st;
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
                osNpcSay(npc, "I don't understand.");     
            } 
            else 
            {  
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
    if (keyword_match_amount == 0)
    {
        return 1;
    }
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
            if(found_count >=match_amount)
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
        if(debug_level)
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
        if(debug_level)
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

    if(activescenario == "S")
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

        if(directive == "1")
        {
            subgoalint  = llList2Integer(actlist, 1);
            wait_time = subgoalint;
            state Wait;
        }
        else if (directive == "2")
        {
            state Wait2Speak; 
        }  
    }
    else if(activescenario == "A") // settings (integer swq, integer snr, list so, integer srn, integer kma, integer eoi, integer sac)
    {
        if(directive == "1" && (myid == 2 || myid == 0))
        {
            currentquestion = "Excuse me. What would be an example of a metaphor?";
            keywords_current = [];
            correct_response = "Thanks.";
            gen_response = "I still don't get it.";
            say_this = "";
            set_ask_settings(0, 0, [], 0, 0, 0, 1);
        }  
        else if(directive == "2" && (myid == 5 || myid == 1 || myid == 0))
        {
            currentquestion = "Why did they win? Explain why their metaphor is better!";
            keywords_current = [];
            correct_response = "Thanks.";
            gen_response = "I still don't get it.";
            say_this = "";
            set_ask_settings(0, 0, [], 0, 0, 0, 1);
        }  
        state Ask;    
    }
    else if(activescenario == "R")
    {
        if(directive == "1" && myid == 3) 
        {
            correct_response = "Yes, it's the same but the resistors have different resistance.";
            gen_response = ""; 
            set_response_settings(1, 5 , 1, llList2String(npc4_lab_sounds, 0));
        }

        state Respond2NpcQuestion;
    }
    else if (activescenario == "G")
    {
        if(directive == "1")
        {
            //llSay(0,"Group Action");
        }

        state GroupThink;
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
    llListen(npc_to_npc_signal, "", NULL_KEY, "");
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
    llListen(npc_to_npc_signal, "", NULL_KEY, "");
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
            npc_state_handler("G:1", c, n, ID, msg);
        }
        else if(msg == "-npcask")
        {
            npc_state_handler("A:1", c, n, ID, msg);
        }
        else if(msg == "-npcask2")
        {
            npc_state_handler("A:2", c, n, ID, msg);
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
        else if (action_spec = "@Rotate")
        {
            string lower_action = llToLower(action);
            rotation rot_npc = osNpcGetRot(npc); 
            vector xyz_angles = <0,0.0,0>;
            vector angles_in_radians = xyz_angles*DEG_TO_RAD;
            rotation rot_xyzq = llEuler2Rot(angles_in_radians); 
            if (lower_action == "north" || lower_action == "n")
            {
                xyz_angles = <0,0,90.0>;

            }
            else if (lower_action == "south" || lower_action == "s")
            {
                 xyz_angles = <0,0,180.0>;

            }
            else if (lower_action == "east" || lower_action == "e")
            {
                 xyz_angles = <0,0,270.0>;

            }
            else if (lower_action == "west" || lower_action == "w")
            {
                 xyz_angles = <0,0,360.0>;

            }
            else 
            {
                if(debug_level)
                    llSay(0, "Invalid @Rotate command: Not a valid direction.");
                return;
            }


            angles_in_radians = xyz_angles*DEG_TO_RAD;
            rot_xyzq = llEuler2Rot(angles_in_radians); 
            osNpcSetRot(npc, rot_xyzq);
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
        npc_to_npc_signal = npc_to_npc_signal_base_channel + myid;
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
        random_lab_anim();
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
        random_lab_anim();
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
                    llTriggerSound(say_this, 3.0);
                    speak_with_question = 0;
                }
                if(signal_npc_reponse)
                {
                    integer i = 0;
                    for(i = 0; i < llGetListLength(signal_offsets); i++)
                    {
                        if(signal_response_num = 1)
                            llSay(npc_to_npc_signal_base_channel + llList2Integer(signal_offsets, i),"@signal-c"); 
                        else
                            llSay(npc_to_npc_signal_base_channel + llList2Integer(signal_offsets, i),"@signal-w");
                    }        

                    state WaitSignal;    
                }

                state Respond;
            }
        }  else process_common_listen_port_msg(c, n, ID, msg);   
    }
} 


state WaitSignal
{
    state_entry()
    {
        register_common_channel_timer(wait_time);
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(c == npc_to_npc_signal)
        {
            ignore_this_npc = ID;
            state Respond;
        } else process_common_listen_port_msg(c, n, ID, msg);   
    }
}

state Respond
{
    state_entry()
    {
        //ask_question();
        register_common_channel_timer(wait_time);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(c == PUBLIC_CHANNEL)
        {
            if(msg)
            {
                if(keyword_match_multi(msg, keywords_current, keyword_match_amount) && ID != npc) 
                {
                    osNpcSay(npc, correct_response);
                    if(signal_action_complete)
                    {
                        llSay(auto_facil_control_channel, "-ac");
                    }
                    state Idle;  
                }
                else 
                {
                    if(signal_npc_reponse && ID != ignore_this_npc && ID != npc)
                    {
                        osNpcSay(npc, gen_response);
                        if(exit_on_incorrect)
                        {
                            if(signal_action_complete)
                            {
                                llSay(auto_facil_control_channel, "-ac");
                            }
                            state Idle;
                        }
                    }
                    else if (ID != npc)
                    {
                        osNpcSay(npc, gen_response);
                        if(exit_on_incorrect)
                        {
                            if(signal_action_complete)
                            {
                                llSay(auto_facil_control_channel, "-ac");
                            }
                            state Idle;
                        }
                    }
                }    
            }
        }  else process_common_listen_port_msg(c, n, ID, msg);   
    }

    // state_exit()
    // {
    //     llSay(0, "test");
    //     llSay(auto_facil_control_channel, "-ac");
    // }
}

state Respond2NpcQuestion
{
    state_entry()
    {
        //llSetTimerEvent(1000.0);
        register_common_channel();
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer()
    {

        if(speak_with_response)
            llTriggerSound(say_this, 3.0);       
        osNpcSay(npc, to_say);
        llSay(npc_to_npc_signal_base_channel+resp_signal_offset, "@done");
        state Idle;
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(c == npc_to_npc_signal)
        {
            if (ID != npc)
            {
                if(msg == "@signal-c")
                {

                    to_say = correct_response; 
                }
                else 
                {
                    to_say = gen_response;   
                }

                llSetTimerEvent(5.0);
            }
        } else process_common_listen_port_msg(c, n, ID, msg);   
    }
}

state GroupThink
{
    state_entry()
    {
        state_name = "GroupThink";
        register_common_channel_timer(speak_interval);
        llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    { 
        backdoor_reset();
    }

    timer() 
    {
        provide_metaphor();
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