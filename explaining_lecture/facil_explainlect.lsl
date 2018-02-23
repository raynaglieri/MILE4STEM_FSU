// change history:
//   2/21/18: created by Raymond Naglieri 


// variables whose value can be changed during the execution of the script
key trainee = NULL_KEY;      // the key for the TA being trained
                             // the person who push the start button is the TA                            
integer auto_facil = TRUE;  // TRUE: automatic mode, FALSE: manual mode
integer base_NPCID = -200;   // No use in this file

// some utility variables
integer debug_level = 10;  // debug_level to control messages
string state_name;         // name of the current state
integer state_id;          // id of the state   
                           // 0 - default;
                           // 1 - 

integer internal_state = 0;    // working storage to store the status within a state

// Utility variables
integer reminder_interval = 120; // interval to send a reminder chat message to 
                                // tell the trainee what to do, or where is the session.
integer dialog_box_interact_interval = 15;
                           
//DO NOT MODIFY
// these are the constants used for all scripts for the chemistry lab

integer facil_state_control_channel = 10101;  // chat channel for human control shared by all scripts
integer facil_para_control_channel = 10102;
integer facil_action_control_channel = 10103;

integer button_to_facil_channel = 11500;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11001; // chat channel for feedbacks from the dialog box

// Message for the dialog and textboxes in the conversation
string d0_msg1 = "Announce the group game.";
list   d0_button1 = ["Okay"];
string d0_msg2 = "Empty";
list   d0_button2 = ["Okay"];
// Message for the dialog and textboxes in the conversation
string d1_msg1 = "Present an example metaphor";
list   d1_button1 = ["Okay"];
string d1_msg2 = "Empty";
list   d1_button2 = ["Okay"];

string d2_msg1 = "Choose the winning group!";
list   d2_button1 = ["Okay"];
string d2_msg2 = "Empty";
list   d2_button2 = ["Okay"];

string d3_msg1 = "You might want to explain why the winning group's metaphor is good";
list   d3_button1 = [];
string d3_msg2 = "Empty";
list   d3_button2 = ["Okay"];

string d4_msg1 = "There are a few ways to promote deep conceptual understanding of the learning material: explaining with metaphor is one of them, the other method is explaining using cases or case studies. Please, describe your case now.";
list   d4_button1 = [];
string d4_msg2 = "Explaining using cases or case studies is another way to promote deep conceptual understanding of the learning material. Please describe your case now.";
list   d4_button2 = [];

string d5_msg1 = "Do not forget to analyze and compare similarities and differences using the case as an example. Link the case to lecture content.";
list   d5_button1 = [];
string d5_msg2 = "It's important you link the case to the lecture content";
list   d5_button2 = ["Okay"];

string d6_msg1 = "Yet another way to promote deep conceptual understanding is to use media boards, physical objects and simulations. Please, proceed with the explanation of the concept using prepared material. Don’t forget to point out key processes and concepts in the simulation.";
list   d6_button1 = [];
string d6_msg2 = "Use physical object or simulation";
list   d6_button2 = ["Okay"];

string d7_msg1 = "Finally, all that you have done in this scenario could be considered an explanation using an alternative representation of the same information.";
list   d7_button1 = ["Okay"];
string d7_msg2 = "Empty";
list   d7_button2 = ["Okay"];

list group_game = ["group", "game", "up", "educational", "play", "competition"];

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
            if(found_count >=match_amount)
                return 1;
        }       
    }
    return 0;   
}

//reset the changeable variables to the original mode
reset_glob(){
    auto_facil = TRUE;
    trainee = NULL_KEY; 
    base_NPCID = -200;
    debug_level = 0;
    state_name = "";
    state_id = -1;
    llSay(0, "facil restart a new training section ......");
}

// goto a state based on the id number
// this function is not completed at this time.
gotostate(integer id)
{
  llSetTimerEvent(0); // turn off timer
  if (id == 0) state default;
  else {
  }
}

change_to_auto_mode()
{
    llSay(0, "Change from manual facilitator guided mode to automatic mode.\n");
    state_name = "default";
    state_id = 0;
    auto_facil = TRUE;
    state Facil_Hub;
}

// common port to state, parameter, and action
register_common_channel()
{
    llListen(facil_state_control_channel, "", NULL_KEY, "");
    llListen(facil_para_control_channel, "", NULL_KEY, "");
    llListen(local_dialog_channel, "", NULL_KEY, "");
}

register_common_channel_timer(integer t)
{
    llListen(facil_state_control_channel, "", NULL_KEY, "");
    llListen(facil_para_control_channel, "", NULL_KEY, "");
    llListen(local_dialog_channel, "", NULL_KEY, "");
    llListen(PUBLIC_CHANNEL, "", NULL_KEY, "");
    llSetTimerEvent(t);
}

// process common listen port messages
process_common_listen_port_msg(integer c, string n, key ID, string msg)
{
    list tmplist;
    string ss;
    integer val;
    key k;
    if (c == facil_state_control_channel) {  // change state include restart
        if (msg == "-repeat") {
            gotostate(state_id);
        } if ((msg  == "-is") || (msg == "-reset") || (msg == "-restart") ||
           (msg == "completerestart")) {    
            reset_glob();
            llSetTimerEvent(0);
            state default;        
        } else if (msg == "-d0"){     
            llSetTimerEvent(0);  
            state D0;    
        } else if (msg == "-d1"){     
            llSetTimerEvent(0);  
            state D1;    
        } else if (msg == "-d2"){     
            llSetTimerEvent(0);  
            state D2;    
        } else if (msg == "-d2!"){     
            llSetTimerEvent(0);    
            state D2W;    
        } else if (msg == "-d3"){     
            llSetTimerEvent(0);    
            state D3;    
        } else if (msg == "-d3!"){     
            llSetTimerEvent(0);    
            state D3W;    
        } else if (msg == "-d4"){     
            llSetTimerEvent(0);    
            state D4;    
        } else if (msg == "-d5"){     
            llSetTimerEvent(0);    
            state D5;    
        } else if (msg == "-d5!"){     
            llSetTimerEvent(0);    
            state D5W;    
        } else if (msg == "-d6"){     
            llSetTimerEvent(0); 
            state D6;    
        } else if (msg == "-d7"){     
            llSetTimerEvent(0);    
            state D7;    
        } else if ((msg == "-auto") && (state_name == "idle")) {
          change_to_auto_mode();
        }               
    } else if (c == facil_para_control_channel) { // change script parameters
        tmplist = llParseString2List(msg, [" "], []);
        ss = llList2String(tmplist, 0);
        val = llList2Integer(tmplist, 1);
        if (ss == "@Querydebug_level") {
            llSay(0, "debuy_level = " + debug_level);
        } else if (ss == "@Querystate") {
            llSay(0, "state = " + state_name);
        } else if (ss == "@Queryreminder_interval") {
            llSay(0, "reminder_interval = " + reminder_interval);
        } else if (ss == "@Setdebug_level") {
            debug_level = val;
        } else if  (ss == "@Setreminder_interval") {
            reminder_interval = val;
        } else if (ss == "@resetscript") 
        {
            llResetScript();
        }
    } else if (c == facil_action_control_channel) { // perform action when needed
         // to be added
    } else {
        // do nothing
    }
}

// common functions for states
// prompt trainee with dialog box or text box


dialog_dialog_with_timer(string msg1, list button1, string msg2, list button2, integer t)
{
  llSetTimerEvent(t);
  if (internal_state == 0) {
    if (button1 == [])
          llTextBox(trainee, msg1, local_dialog_channel);
    else llDialog(trainee, msg1, button1, local_dialog_channel);
  } else if (internal_state == 1) {
    if (button2 == []) 
        llTextBox(trainee, msg2, local_dialog_channel);
    else llDialog(trainee, msg2, button2, local_dialog_channel);
  }
}

common_state_entry(string n, string s, list l, integer t)
{
   internal_state = 0;
   state_name = n;
   if (l == [])
     llTextBox(trainee, s, local_dialog_channel);
   else llDialog(trainee, s, l, local_dialog_channel);
   register_common_channel_timer(t);
}

default
{
    state_entry()
    {
        internal_state = 0;
        state_name = "default";
        llSay(0, "Lecture session default; push press the computer to begin.");
        llListen(button_to_facil_channel, "", NULL_KEY, "");
        register_common_channel_timer(reminder_interval);
    }   
        
    touch_start(integer num_detected)
    {
        key kk;   // display a dialog box to whoever touch the script
                  // may not be the TA
        kk = llDetectedKey(0);
        llSetTimerEvent(reminder_interval);
        llDialog(kk, "Default state; waiting for lecture to start.", 
                 ["Okay"], 
                 local_dialog_channel);
        llSetTimerEvent(reminder_interval);
    }  
    
    timer() 
    {
        llSay(0, "in default state; push the computer to start.");
        llSetTimerEvent(reminder_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(reminder_interval); // some activity, do not send reminder just yet
        if (c == local_dialog_channel) 
        {
            if (msg == "Okay")
            {      
                state default;
            } 
            else if (msg == "Start")
            {
               state Idle;
            }  
            else 
            {
                if (debug_level > 0) 
                    llSay(0, "default state: received unknown feedback from dialog box, ignore");
            }             
        } 
        else if (c == button_to_facil_channel) 
        {                   // sent from the green button
            trainee = msg;  // here the green button passes the trainee ID to facil
            llDialog(trainee, "Now you are going to teach a Lecture to the students. Start by suggesting a group game. Click start when you are ready.", 
                     ["Start"] , local_dialog_channel);   
        } 
        else 
        {
            process_common_listen_port_msg(c, n, ID, msg);
        }            
    } 
}

state Idle 
{    
    state_entry(){
        state_name = "idle";
        llSay(0, "in idle state.");
        register_common_channel_timer(reminder_interval*3);
    } 
    
    touch_start(integer num_detected){
         llSay(0, "in idle state");
    }  
    
    timer() {
        llSay(0, "in idle state");
        llSetTimerEvent(reminder_interval*3);
    }
        
    listen(integer c, string n, key ID, string msg){
      process_common_listen_port_msg(c, n, ID, msg);
    }   
} 

state D0
{
    state_entry()
    {
        common_state_entry("d0", d0_msg1, d0_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d0_msg1, d0_button1,
                                 d0_msg2, d0_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d0_msg1, d0_button1,
                                 d0_msg2, d0_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D1
{
    state_entry()
    {
        common_state_entry("d1", d1_msg1, d1_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D2
{
    state_entry()
    {
        common_state_entry("d2", d2_msg1, d2_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d2_msg1, d2_button1,
                                 d2_msg2, d2_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d2_msg1, d2_button1,
                                 d2_msg2, d2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D3
{
    state_entry()
    {
        common_state_entry("d3", d3_msg1, d3_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}


state D4
{
    state_entry()
    {
        common_state_entry("d4",d4_msg1, d4_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        internal_state = 1;
        dialog_dialog_with_timer(d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg)
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D5
{
    state_entry()
    {
        common_state_entry("d5",d5_msg1, d5_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        internal_state = 1;
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg)
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D6
{
    state_entry()
    {
        common_state_entry("d6",d6_msg1, d6_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d6_msg1, d6_button1,
                                 d6_msg2, d6_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        internal_state = 1;
        dialog_dialog_with_timer(d6_msg1, d6_button1,
                                 d6_msg2, d6_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg)
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D7
{
    state_entry()
    {
        common_state_entry("d7", d7_msg1, d7_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

//////Intro//////
// state Wait_for_group
// { 
//     state_entry()
//     { 
//         common_state_entry("wfg", d1_msg1, d1_button1, dialog_box_interact_interval);
//     }
    
//     touch_start(integer num_detected) 
//     {  
//         dialog_dialog_with_timer(d1_msg1, d1_button1, dialog_box_interact_interval);
//     }
  
//     timer()
//     {
//        llSay(0, "NPCs must break up into two groups and compete in providing a good metaphor of your choice.");
//     }
    
//     listen(integer c, string n, key ID, string msg) 
//     {
//         llSetTimerEvent(dialog_box_interact_interval);  
//         if (c == local_dialog_channel)
//         {
//            if (msg == "Okay") 
//            {
//                 llSetTimerEvent(30);   
//            }
//         } 
//         else if (c == PUBLIC_CHANNEL)
//         {
//             if(keyword_match_multi(msg, group_game, 2))
//             {
//                 llSetTimerEvent(0);
//                 llSay(backdoor_channel,"-npcgroup");
//                 state Wait_for_Example;
//             } 
//         }
//         else {
//             process_common_listen_port_msg(c, n, ID, msg);
//         }
//     } 
// }

// state Wait_for_Example
// { 
//     state_entry()
//     {
//         common_state_entry("wfe", d2_msg1, d2_button1, dialog_box_interact_interval);

//     }  

//     touch_start(integer num_detected) 
//     {
//         dialog_dialog_with_timer(d2_msg1, d2_button1, dialog_box_interact_interval); 
//     }
  
//     timer()
//     {
//         dialog_dialog_with_timer(d2_msg1, d2_button1, dialog_box_interact_interval);
//     }
    
//     listen(integer c, string n, key ID, string msg)
//     {
//         llSetTimerEvent(dialog_box_interact_interval);
//         if (c == local_dialog_channel)
//         {
//             if (msg == "Okay") 
//             {
//                 llSetTimerEvent(30); 
//             } 
        
//         } 
//         else if (c == PUBLIC_CHANNEL)
//         {
//             if (msg == "-ok")
//             {
//                 llSetTimerEvent(0);
//                 llSay(backdoor_channel,"-npcgs");
//                 llSay(backdoor_channel,"-npcgs");
//                 state Wait_for_win;
//             }
//         } else process_common_listen_port_msg (c, n, ID, msg);         
//     }   
// }

// state Wait_for_win
// {
//     state_entry()
//     {
//         common_state_entry("wfw", d3_msg1, d3_button1, dialog_box_interact_interval);
//     }  

//     touch_start(integer num_detected) 
//     {
//         dialog_dialog_with_timer(d3_msg1, d3_button1, dialog_box_interact_interval); 
//     }
  
//     timer()
//     {
//         dialog_dialog_with_timer(d3_msg1, d3_button1, dialog_box_interact_interval);
//     }
    
//     listen(integer c, string n, key ID, string msg)
//     {
//         llSetTimerEvent(dialog_box_interact_interval);
//         if (c == local_dialog_channel){
//             if (msg == "Okay") {
//                 llSetTimerEvent(30); 
//             }    
//         } else process_common_listen_port_msg (c, n, ID, msg);         
//     }  
// } 

// state Metaphor_follow_up
// { 
//     state_entry()
//     {
//         state_name = "mfu";
//         register_common_channel_timer(15);
//     }  

//     touch_start(integer num_detected) 
//     {
//         llSay(0, "waiting for feedback .");
//     }
  
//     timer()
//     {   

//         if(internal_state > 0)
//         {
//             internal_state++;
//             dialog_dialog_with_timer(d4_msg2, d4_button2, dialog_box_interact_interval);
//         }
//         else 
//         {
//             internal_state++;
//             dialog_dialog_with_timer(d4_msg1, d4_button1, dialog_box_interact_interval);
//         }
//     }
    
//     listen(integer c, string n, key ID, string msg)
//     {
//         llSetTimerEvent(dialog_box_interact_interval);
//         if (c == local_dialog_channel)
//         {
//             if (msg == "Okay") 
//             {
//                 if(internal_state <= 1)
//                     llSetTimerEvent(30); 
//                 else
//                 {
//                     internal_state = 0;
//                     state Analyze_compare;  
//                 }  
//             }
//         } 
//         else if (c == PUBLIC_CHANNEL)
//         {
//             if (msg == "-case")
//             {
//                 llSetTimerEvent(0);
//                 internal_state = 0;
//                 state Analyze_compare;
//             }
//         } else process_common_listen_port_msg (c, n, ID, msg);         
//     }   
// }

// state Analyze_compare
// { 
//     state_entry()
//     {
//         state_name = "ac";
//         register_common_channel_timer(15);
//     }  

//     touch_start(integer num_detected) 
//     {
//         llSay(0,"waiting for feedback.");
//     }
  
//     timer()
//     {   
//         if(internal_state > 0)
//         {
//             internal_state++;
//             dialog_dialog_with_timer(d5_msg2, d5_button2, dialog_box_interact_interval);
//         } 
//         else
//         { 
//             internal_state++;
//             dialog_dialog_with_timer(d5_msg1, d5_button1, dialog_box_interact_interval);
//         }
//     }
    
//     listen(integer c, string n, key ID, string msg)
//     {
//         llSetTimerEvent(dialog_box_interact_interval);
//         if (c == local_dialog_channel)
//         {
//             if (msg == "Okay") 
//             {
//                 if(internal_state <= 1)
//                     llSetTimerEvent(30); 
//                 else
//                 {
//                     internal_state = 0;
//                     state Conceptual_understanding;  
//                 }
//             }   
//         } 
//         else if (c == PUBLIC_CHANNEL)
//         {
//             if (msg == "-temp")
//             {
//                 llSetTimerEvent(0);
//                 internal_state = 0;
//                 state Conceptual_understanding;
//             }
//         } else process_common_listen_port_msg (c, n, ID, msg);         
//     }   
// }

// state Conceptual_understanding
// { 
//     state_entry()
//     {
//         state_name = "cu";
//         register_common_channel_timer(20);
//     }  

//     touch_start(integer num_detected) 
//     {
//         llSay(0,"waiting for feedback.");
//     }
  
//     timer()
//     {
//         dialog_dialog_with_timer(d6_msg1, d6_button1, dialog_box_interact_interval);
//     }
    
//     listen(integer c, string n, key ID, string msg)
//     {
//         llSetTimerEvent(dialog_box_interact_interval);
//         if (c == local_dialog_channel)
//         {
//             if (msg == "Okay") 
//             {
//                 llSetTimerEvent(0);
//                 state Alternative_rep;
//             } 
        
//         } 
//         else if (c == PUBLIC_CHANNEL)
//         {
//             if (msg == "-temp")
//             {
//                 llSetTimerEvent(0);
//                 state Alternative_rep;
//             }
//         } else process_common_listen_port_msg (c, n, ID, msg);         
//     }   
// }

// state Alternative_rep
// { 
//     state_entry()
//     {
//         state_name = "ap";
//         register_common_channel_timer(20);
//     }  

//     touch_start(integer num_detected) 
//     {
//         llSay(0,"waiting for feedback.");
//     }
  
//     timer()
//     {
//         dialog_dialog_with_timer(d7_msg1, d7_button1, dialog_box_interact_interval);
//     }
    
//     listen(integer c, string n, key ID, string msg)
//     {
//         llSetTimerEvent(dialog_box_interact_interval);
//         if (c == local_dialog_channel)
//         {
//             if (msg == "Okay") 
//             {
//                 llSetTimerEvent(0);
//                 state Idle;
//             } 
        
//         } 
//         else if (c == PUBLIC_CHANNEL)
//         {
//             if (msg == "-temp")
//             {
//                 llSetTimerEvent(0);
//                 state Idle;
//             }
//         } else process_common_listen_port_msg (c, n, ID, msg);         
//     }   
// }
       