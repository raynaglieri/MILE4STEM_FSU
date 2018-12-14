// variables whose value can be changed during the execution of the script
key trainee = NULL_KEY;      // the key for the TA being trained
key facilitator = NULL_KEY;
                             // the person who push the start button is the TA                            
integer auto_facil = TRUE;  // TRUE: automatic mode, FALSE: manual mode
integer base_NPCID = -200;   // No use in this file

// some utility variables
integer debug_level = 0;  // debug_level to control messages
string state_name;         // name of the current state
integer state_id;          // id of the state   
                           // 0 - default;
                           // 1 - 

integer internal_state;    // working storage to store the status within a state

// Utility variables
integer reminder_interval = 120; // interval to send a reminder chat message to 
                                // tell the trainee what to do, or where is the session.
integer dialog_box_interact_interval = 120;
                           
//DO NOT MODIFY
// these are the constants used for all scripts for the chemistry lab

integer facil_state_control_channel = 10101;  // chat channel for human control shared by all scripts
integer facil_para_control_channel = 10102;
integer facil_action_control_channel = 10103;

integer button_to_facil_channel = 11501;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11009; // chat channel for feedbacks from the dialog box

string d0_msg1 = "Now you are going to teach a lab on Series and Parallel Circuits and Kirchoff's rules to the students. What would you do first? You have 1 minute to prepare and then start teaching.";
list   d0_button1 = ["Okay"];
string d0_msg2 = "Empty";
list   d0_button2 = ["Okay"];
// Message for the dialog and textboxes in the conversation
string d1_msg1 = "Do you want to continue to the students' experiments / lab part?";
string d1_msg2 = "Great, now the students have started conducting their experiments";
string d1_msg3 = "OK, you may leave the lab now";
list   d1_button1 = ["Yes", "No"];
list   d1_button2 = ["Okay"];

string d2_msg1 = "Students are working in groups. Look at the media boards to see which half of the classroom is working on Series and which one on Parallel Circuits";
list   d2_button1 = ["Okay"];
string d2_msg2 = "Empty";
list   d2_button2 = ["Okay"];

string d3_msg1 = ", what do you think are some ways to monitor students' progress with their experiments?";
list   d3_button1 = [];
string d3_msg2 = "Great, you can try it.";
list   d3_button2 = ["Okay"];

string d4_msg1 = ", did you notice the 2 questions asked by students were very similar? Sometimes you have to repeat the same information or the same announcement to the class if learners are not familiar with the things you are referring to";
list   d4_button1 = [];
string d4_msg2 = "";
list   d4_button2 = [];

string d5_msg1 = "You might want to check which group students are at and refer them to the  examples you have provided on two boards in front of the class during your introduction";
list   d5_button1 = ["Okay"];
string d5_msg2 = "Empty";
list   d5_button2 = ["Okay"];

string d6_msg1 = "You shouldn't give students a direct response.";
list   d6_button1 = ["Okay"];
string d6_msg2 = "Empty";
list   d6_button2 = ["Okay"];

string d7_msg1 = "Great strategy! Try not to give a direct confirmation to students";
list   d7_button1 = ["Okay"];
string d7_msg2 = "You might want to try telling a joke or making some intentionally funny movement and asking if students noticed it to attract everybody’s attention";
list   d7_button2 = ["Okay"];

string d8_msg1 = "Do you want to continue to the Kirchoff's rules part?";
string d8_msg2 = "Great, now all the students are working together.";
string d8_msg3 = "OK, you may leave the lab now.";
list   d8_button1 = ["Yes", "No"];
list   d8_button2 = ["Okay"];

string d9_msg1 = "You might want to ask which loop the resistors belong to and refer students to the rules you have explained during the introduction.";
list   d9_button1 = ["Okay"];
string d9_msg2 = "Empty";
list   d9_button2 = ["Okay"];

string d10_msg1 = "You might want to refer students to the rules you have explained during the introduction or to ask them which side of the resistor is positive relative to the other end and to talk about polarity of the current.";
list   d10_button1 = ["Okay"];
string d10_msg2 = "Empty";
list   d10_button2 = ["Okay"];

string d11_msg1 = "This lab session will be over in 15 minute!";
list   d11_button1 = ["Okay"];
string d11_msg2 = "Empty";
list   d11_button2 = ["Okay"];

string d12_msg1 = "Great, now the lab session is over. How do you feel about teaching this lab?";
list   d12_button1 = [];
string d12_msg2 = "Empty";
list   d12_button2 = ["Okay"];

string d13_msg1 = "Is there anything you would do differently if you teach this lab again and what?";
list   d13_button1 = [];
string d13_msg2 = "Empty";
list   d13_button2 = ["Okay"];

string d14_msg1 = "Congratulations, you have completed all lab tasks!";
list   d14_button1 = ["Okay"];
string d14_msg2 = "Empty";
list   d14_button2 = ["Okay"];

//out of order
string d15_msg1 = "Okay, please start.";
list   d15_button1 = ["Okay"];
string d15_msg2 = "You may want to start with the lab topic now";
list   d15_button2 = ["Okay"];

string d16_msg1 = "Yes. Students have to finish their reports during the lab.";
list   d16_button1 = ["Okay"];
string d16_msg2 = "";
list   d16_button2 = ["Okay"];

string d17_msg1 = "Remember. Students have to finish their reports during the lab. If you didn't explain and didn't enforce time managment during the lab, you will be responsible for students' incomplete work." ;
list   d17_button1 = ["Okay"];
string d17_msg2 = "";
list   d17_button2 = ["Okay"];

string d18_msg1 = "You might want to use the steps from the notecard you've got before";
list   d18_button1 = ["Okay"];
string d18_msg2 = "";
list   d18_button2 = ["Okay"];

string d19_msg1 = "You might want to check which group students are at and refer them to the  examples you have provided on two boards in front of the class during your introduction.";
list   d19_button1 = ["Okay"];
string d19_msg2 = "";
list   d19_button2 = ["Okay"];

string dw1_msg1 = "Empty";
list   dw1_button1 = ["Okay"];
string dw1_msg2 = "Empty";
list   dw1_button2 = ["Okay"];

string dw2_msg1 = "Imagine you are leading a lab session. What would you do to check out each group's progress with their experiment? Will you stay in the front or walk around the lab to check up on the students?";
list   dw2_button1 = [];
string dw2_msg2 = "Great, you can try it.";
list   dw2_button2 = ["Okay"];

string dw3_msg1 = "You might want to ask why students are chatting during the lecture";
list   dw3_button1 = ["Okay"];
string dw3_msg2 = "Empty";
list   dw3_button2 = ["Okay"];


string dw4_msg1 = "You might want to change an instructional sequence or repeat some complex topics, depending on students’ understanding.";
list   dw4_button1 = ["Okay"];
string dw4_msg2 = "Empty";
list   dw4_button2 = ["Okay"];

string dw5_msg1 = "Depending on the learner you might want to use a disciplinary approach or explain the relation of the lecture topic to their potential upcoming internship or try to bargain your way out giving out one of the midterm questions (rewards)";
list   dw5_button1 = ["Okay"];
string dw5_msg2 = "Empty";
list   dw5_button2 = ["Okay"];

string dw6_msg1 = "You need to understand where your learners are at.";
list   dw6_button1 = ["Okay"];
string dw6_msg2 = "Empty";
list   dw6_button2 = ["Okay"];

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
    state Idle;
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
        } else if (msg == "-d8"){     
            llSetTimerEvent(0);    
            state D8;    
        } else if (msg == "-d9"){     
            llSetTimerEvent(0);    
            state D9;    
        } else if (msg == "-d10"){     
            llSetTimerEvent(0);    
            state D10;    
        }else if (msg == "-d11"){     
            llSetTimerEvent(0);    
            state D11;    
        }else if (msg == "-d12"){     
            llSetTimerEvent(0);    
            state D12;    
        }else if (msg == "-d13"){     
            llSetTimerEvent(0);    
            state D13;    
        }else if (msg == "-d14"){     
            llSetTimerEvent(0);    
            state D14;    
        }else if (msg == "-d15"){     
            llSetTimerEvent(0);    
            state D15;    
        }else if (msg == "-d16"){     
            llSetTimerEvent(0);    
            state D16;    
        }else if (msg == "-d17"){     
            llSetTimerEvent(0);    
            state D17;    
        }else if (msg == "-d18"){     
            llSetTimerEvent(0);    
            state D18;    
        }else if (msg == "-d19"){     
            llSetTimerEvent(0);    
            state D19;    
        }else if(msg == "-nc1"){
            state NC1;
        }else if(msg == "-nc2"){
            state NC2;
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

send_response_to_facil(string trainee_response)
{
    if(facilitator != NULL_KEY)
        llInstantMessage(facilitator,"Trainee response: " + trainee_response); 
}

send_promt_to_facil(string trainee_prompt)
{
    if(facilitator != NULL_KEY)
        llInstantMessage(facilitator,"Text Box Prompt: " + trainee_prompt); 
}

dialog_dialog_with_timer(string msg1, list button1, string msg2, list button2, integer t)
{
  llSetTimerEvent(t);
  if (internal_state == 0) {
    if(facilitator != NULL_KEY)
        llInstantMessage(facilitator,"Text Box Prompt: " + msg1);   
    if (button1 == [])
        llTextBox(trainee, msg1, local_dialog_channel); 
    else llDialog(trainee, msg1, button1, local_dialog_channel);    
  } else if (internal_state == 1) {
        if(facilitator != NULL_KEY)
            llInstantMessage(facilitator,"Text Box Prompt: " + msg2);   
        if (button2 == []) 
            llTextBox(trainee, msg2, local_dialog_channel);
        else llDialog(trainee, msg2, button2, local_dialog_channel);
  }
}

common_state_entry(string n, string s, list l, integer t)
{
    internal_state = 0;
    state_name = n;
    if(facilitator != NULL_KEY)
        llInstantMessage(facilitator,"Text Box Prompt: " + s);   
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
        llSay(0, "Physics session default; push press the computer to begin.");
        llListen(button_to_facil_channel, "", NULL_KEY, "");
        register_common_channel_timer(reminder_interval);
    }   
        
    touch_start(integer num_detected)
    {
        key kk;   // display a dialog box to whoever touch the script
                  // may not be the TA
        kk = llDetectedKey(0);
        llSetTimerEvent(reminder_interval);
        llDialog(kk, "Default state; waiting for labto start.", 
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
            list key_package = llParseString2List(msg, [":"], []);
            trainee = llList2String(key_package, 0);  // here the green button passes the trainee ID to facil
            facilitator = llList2String(key_package, 1);
            llDialog(trainee, "Now you are going to lead a lab to the students. Click start when you are ready.", ["Start"] , local_dialog_channel);   
        } 
        else 
        {
            process_common_listen_port_msg(c, n, ID, msg);
        }            
    } 
}

state Idle 
{
    
    state_entry()
    {
        state_name = "idle";
        if(debug_level)
            llSay(0, "In manual facilitator guided mode.");
        register_common_channel_timer(reminder_interval*3);
    } 
    
    touch_start(integer num_detected)
    {
        key kk;   // display a dialog box to whoever touch the script
                  // may not be the TA
        kk = llDetectedKey(0);
        llSetTimerEvent(reminder_interval*3);        
        if (kk == trainee) 
        {
            llDialog(kk, "Do you really want to reset the training session to auto mode?", 
                     ["Yes", "No" ] , 
                     local_dialog_channel);
        } else llSay(0, "Sorry, only the TA trainee can change the mode of this training session.");
        
        llSetTimerEvent(reminder_interval*3);
    }  
    
    timer() 
    {
        if(debug_level)
            llSay(0, "in idle state");
        llSetTimerEvent(reminder_interval*3);
    }
        
    listen(integer c, string n, key ID, string msg)
    {
        if (c == local_dialog_channel) 
        {
            if (msg == "Yes") 
            {
                change_to_auto_mode();
            }
        } else process_common_listen_port_msg(c, n, ID, msg);
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
            send_response_to_facil(msg);
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
           send_response_to_facil(msg);
           if(msg == "Yes")
           {
               internal_state = 1;
               send_promt_to_facil(d1_msg2);
               llDialog(trainee, d1_msg2, d1_button2, local_dialog_channel);
               //state Idle;
           } 
           else if (msg == "No") 
           {
               llSetTimerEvent(0);
               state Idle;
           } 
           else if (msg == "Okay") 
           {
               llSetTimerEvent(0);
               state Idle;
           }
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
           send_response_to_facil(msg);
           if(msg == "Yes"){
               internal_state = 1;
               state Idle;
               llDialog(trainee, d2_msg2, d2_button2, local_dialog_channel);
           } else if (msg == "No") {
               llSetTimerEvent(0);
               state Idle;
           } else if (msg == "Okay") {
               llSetTimerEvent(0);
               state Idle;
           }
        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D2W
{
    state_entry()
    {
        common_state_entry("d2w", dw2_msg1, dw2_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw2_msg1, dw2_button1,
                                 dw2_msg2, dw2_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(dw2_msg1, dw2_button1,
                                 dw2_msg2, dw2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
           send_response_to_facil(msg);
           if(msg && internal_state != 1)
           {
               internal_state = 1;
                send_promt_to_facil(dw2_msg2);
               llDialog(trainee, dw2_msg2, dw2_button2, local_dialog_channel);
           } 
           else if (msg == "Okay") 
           {
               llSetTimerEvent(0);
               state Idle;
           } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D3
{
    state_entry()
    {
        common_state_entry("d3", llKey2Name(trainee) + d3_msg1, d3_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(llKey2Name(trainee) + d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(llKey2Name(trainee) + d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
           send_response_to_facil(msg);
           if(msg && internal_state != 1)
           {
               internal_state = 1;
                send_promt_to_facil(d3_msg2);
               llDialog(trainee, d3_msg2, d3_button2, local_dialog_channel);
           } 
           else if (msg == "Okay") 
           {
               llSetTimerEvent(0);
               state Idle;
           } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D4
{
    state_entry()
    {
        common_state_entry("d4", llKey2Name(trainee) + d4_msg1, d4_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(llKey2Name(trainee) + d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(llKey2Name(trainee) + d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
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
        common_state_entry("d5", d5_msg1, d5_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
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
        common_state_entry("d6", d6_msg1, d6_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d6_msg1, d6_button1,
                                 d6_msg2, d6_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d6_msg1, d6_button1,
                                 d6_msg2, d6_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
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
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D8
{
    state_entry()
    {
        common_state_entry("d8", d8_msg1, d8_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d8_msg1, d8_button1,
                                 d8_msg2, d8_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d8_msg1, d8_button1,
                                 d8_msg2, d8_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
           send_response_to_facil(msg);
           if(msg == "Yes")
           {
               internal_state = 1;
               send_promt_to_facil(d8_msg2);
               llDialog(trainee, d8_msg2, d8_button2, local_dialog_channel);
           } 
           else if (msg == "No") 
           {
               internal_state = 1;
               send_promt_to_facil(d8_msg3);
               llDialog(trainee, d8_msg3, d8_button2, local_dialog_channel);
           } 
           else if (msg == "Okay") 
           {
               llSetTimerEvent(0);
               state Idle;
           }
        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D9
{
    state_entry()
    {
        common_state_entry("d9", d9_msg1, d9_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d9_msg1, d9_button1,
                                 d9_msg2, d9_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d9_msg1, d9_button1,
                                 d9_msg2, d9_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D10
{
    state_entry()
    {
        common_state_entry("d10", d10_msg1, d10_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d10_msg1, d10_button1,
                                 d10_msg2, d10_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d10_msg1, d10_button1,
                                 d10_msg2, d10_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D11
{
    state_entry()
    {
        common_state_entry("d11", d11_msg1, d11_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d11_msg1, d11_button1,
                                 d11_msg2, d11_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d11_msg1, d11_button1,
                                 d11_msg2, d11_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D12
{
    state_entry()
    {
        common_state_entry("d12", d12_msg1, d12_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d12_msg1, d12_button1,
                                 d12_msg2, d12_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d12_msg1, d12_button1,
                                 d12_msg2, d12_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg)
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D13
{
    state_entry()
    {
        common_state_entry("d13", d13_msg1, d13_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d13_msg1, d13_button1,
                                 d13_msg2, d13_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d13_msg1, d13_button1,
                                 d13_msg2, d13_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg)
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D14
{
    state_entry()
    {
        common_state_entry("d14", d14_msg1, d14_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d14_msg1, d14_button1,
                                 d14_msg2, d14_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d14_msg1, d14_button1,
                                 d14_msg2, d14_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D15
{
    state_entry()
    {
        common_state_entry("d15", d15_msg1, d15_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d15_msg1, d15_button1,
                                 d15_msg2, d15_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        internal_state = 1;
        dialog_dialog_with_timer(d15_msg1, d15_button1,
                                 d15_msg2, d15_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D16
{
    state_entry()
    {
        common_state_entry("d16", d16_msg1, d16_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d16_msg1, d16_button1,
                                 d16_msg2, d16_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d16_msg1, d16_button1,
                                 d16_msg2, d16_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D17
{
    state_entry()
    {
        common_state_entry("d17", d17_msg1, d17_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d17_msg1, d17_button1,
                                 d17_msg2, d17_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d17_msg1, d17_button1,
                                 d17_msg2, d17_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D18
{
    state_entry()
    {
        common_state_entry("d18", d18_msg1, d18_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d18_msg1, d18_button1,
                                 d18_msg2, d18_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d18_msg1, d18_button1,
                                 d18_msg2, d18_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state D19
{
    state_entry()
    {
        common_state_entry("d19", d19_msg1, d19_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d19_msg1, d19_button1,
                                 d19_msg2, d19_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d19_msg1, d19_button1,
                                 d19_msg2, d19_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
            send_response_to_facil(msg);
            if(msg == "Okay")
            {
                state Idle;
            } else state Idle;      

        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}



state NC1
{
    state_entry()
    {
        llGiveInventory(trainee, "wiresandfuses");
        register_common_channel_timer(reminder_interval);
    }    

    touch_start(integer num_detected) 
    {
        llSay(0, "State: NC1");
    }
  
    timer()
    {
        if(debug_level)
            llSay(0, "State: NC1");
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg (c, n, ID, msg);         
    } 
}

state NC2
{
    state_entry()
    {
        llGiveInventory(trainee, "correctanswer");
        register_common_channel_timer(reminder_interval);
    }    

    touch_start(integer num_detected) 
    {
        llSay(0, "State: NC2");
    }
  
    timer()
    {
        if(debug_level)
            llSay(0, "State: NC2");
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg (c, n, ID, msg);         
    } 
}