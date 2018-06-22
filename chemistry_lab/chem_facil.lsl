//  CREATED BY: Raymond Naglieri on 06/01/2018 
// DESCRIPTION: Facilitator pop-up control. 
//         LOG: 06/01/2018 - Updated for chemistry lab.
//              06/14/2018 - Added descriptions for Faciltator instant messaging.
//

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
integer dialog_box_interact_interval = 60;
                           
//DO NOT MODIFY
// these are the constants used for all scripts for the chemistry lab

integer facil_state_control_channel = 10101;  // chat channel for human control shared by all scripts
integer facil_para_control_channel = 10102;
integer facil_action_control_channel = 10103;

integer button_to_facil_channel = 11501;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11001; // chat channel for feedbacks from the dialog box

// Message for the dialog and textboxes in the conversation
string d1_msg1 = "The students are conducting experiments. Now it’s your time to monitor their progress";
list   d1_button1 = ["Okay"];
string d1_msg2 = "Empty";
list   d1_button2 = ["Okay"];

string dw1_msg1 = "Empty";
list   dw1_button1 = ["Okay"];
string dw1_msg2 = "Empty";
list   dw1_button2 = ["Okay"];

string d2_msg1 = "Imagine you are leading a lab session. What would you do to check out each group's progress with their experiment? Will you stay in the front or walk around the lab to check up on the students?";
list   d2_button1 = ["Okay"];
string d2_msg2 = "Empty";
list   d2_button2 = ["Okay"];

string d3_msg1 = ", what do you think are some ways to monitor students' progress with their experiments?";
list   d3_button1 = ["Okay"];
string d3_msg2 = "Empty";
list   d3_button2 = ["Okay"];

string d4_msg1 = "Great, you can try it.";
list   d4_button1 = ["Okay"];
string d4_msg2 = "Empty";
list   d4_button2 = ["Okay"];

string d5_msg1 = "A common way to monitor a lab is you walk around and go to each table to see how students are doing or if they have questions.";
list   d5_button1 = ["Okay"];
string d5_msg2 = "Empty";
list   d5_button2 = ["Okay"];

string d6_msg1 = "Maybe I can help you with this. First, help the students to find out if they followed all the steps of the experiment procedures correctly. Then you may help them understand the purpose of doing a lab, for example, is to observe and understand what happens.";
list   d6_button1 = ["Okay"];
string d6_msg2 = "Empty";
list   d6_button2 = ["Okay"];

string d7_msg1 = ", did you notice the 3 questions asked by students were very similar? What would you do if more students have the same question?";
list   d7_button1 = ["Okay"];
string d7_msg2 = "Empty";
list   d7_button2 = ["Okay"];

string d8_msg1 = " You may also think about making an announcement to the whole class about this point because this may be a common question for all students. Talking to the whole class will help more students pay attention to it and it also saves your time answering it repeatedly.";
list   d8_button1 = ["Okay"];
string d8_msg2 = "Empty";
list   d8_button2 = ["Okay"];

string d9_msg1 = "Great! It's definitely a good strategy to help more students pay attention to this point. It also keep you from answering the same question repeatedly.";
list   d9_button1 = ["Okay"];
string d9_msg2 = "Empty";
list   d9_button2 = ["Okay"];

string d10_msg1 = "Great job! What you did not only helps other students who may have concerns, but also saves your time for answering more similar questions.";
list   d10_button1 = ["Okay"];
string d10_msg2 = "You might want to suggest an alternative learning activity to a student, for example, having a handout from the table.";
list   d10_button2 = ["Okay"];

string d11_msg1 = "If you teach this lab again, what would you do to prevent students similar situation happen again?";
list   d11_button1 = [];
string d11_msg2 = "Empty";
list   d11_button2 = ["Okay"];

string d12_msg1 = "You may also think about pointing this out to the whole class when you explain or demonstrate the procedures at the beginning of the lab.";
list   d12_button1 = ["Okay"];
string d12_msg2 = "Empty";
list   d12_button2 = ["Okay"];

string d13_msg1 = "Right, pointing this point out ahead of time is a great way to get students pay attention to it.";
list   d13_button1 = ["Okay"];
string d13_msg2 = "Empty";
list   d13_button2 = ["Okay"];

string d14_msg1 = "Great, now the lab session is over. Is there anything you would do differently if you teach this lab again? What would you do differently to make sure all students complete on time?";
list   d14_button1 = [];
string d14_msg2 = "Empty";
list   d14_button2 = ["Okay"];

string d15_msg1 = "What would you do differently to make sure all students complete on time?";
list   d15_button1 = [];
string d15_msg2 = "Empty";
list   d15_button2 = ["Okay"];

string d16_msg1 = "Do you want to continue with lab emergency challenge?";
list   d16_button1 = ["Yes", "No"];
string d16_msg2 = "Empty";
list   d16_button2 = ["Okay"];

string d17_msg1 = "Great! Your students are doing the Acids and Bases lab now. Help them as needed.";
list   d17_button1 = ["Okay"];
string d17_msg2 = "Empty";
list   d17_button2 = ["Okay"];

string d18_msg1 = "OK, you may leave the lab now.";
list   d18_button1 = ["Okay"];
string d18_msg2 = "Empty";
list   d18_button2 = ["Okay"];

string d19_msg1 = "Great! Let's get started!";
list   d19_button1 = ["Okay"];
string d19_msg2 = "Empty";
list   d19_button2 = ["Okay"];

string d20_msg1 = "Do you want to try a more challenging lab emergency task?";
list   d20_button1 = ["Yes", "No"];
string d20_msg2 = "Empty";
list   d20_button2 = ["Okay"];

string d21_msg1 = "Great! Now the fire is out. Good job!";
list   d21_button1 = ["Okay"];
string d21_msg2 = "Empty";
list   d21_button2 = ["Okay"];

string d22_msg1 = "Congratulations, you have completed all lab tasks!";
list   d22_button1 = ["Okay"];
string d22_msg2 = "Empty";
list   d22_button2 = ["Okay"];



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
        } else if (msg == "-d1"){     
            llSetTimerEvent(0);  
            state D1;    
        } else if (msg == "-d1!"){     
            llSetTimerEvent(0);    
            state D1W;    
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
        } else if (msg == "-d4!"){     
            llSetTimerEvent(0);    
            state D4W;    
        } else if (msg == "-d5"){     
            llSetTimerEvent(0);    
            state D5;    
        } else if (msg == "-d5!"){     
            llSetTimerEvent(0);    
            state D5W;    
        } else if (msg == "-d6"){     
            llSetTimerEvent(0); 
            state D6;    
        } else if (msg == "-d6!"){     
            llSetTimerEvent(0);    
            state D6W;    
        } else if (msg == "-d7"){     
            llSetTimerEvent(0);    
            state D7;    
        } else if (msg == "-d7!"){     
            llSetTimerEvent(0);    
            state D7W;    
        } else if (msg == "-d8"){     
            llSetTimerEvent(0);    
            state D8;    
        } else if (msg == "-d8!"){     
            llSetTimerEvent(0);    
            state D8W;    
        } else if (msg == "-d9"){     
            llSetTimerEvent(0);    
            state D9;    
        } else if (msg == "-d9!"){     
            llSetTimerEvent(0);    
            state D9W;    
        } else if (msg == "-d10"){     
            llSetTimerEvent(0);    
            state D10;    
        } else if (msg == "-d10!"){     
            llSetTimerEvent(0);    
            state D10W;       
        } else if (msg == "-d11"){     
            llSetTimerEvent(0);    
            state D11;    
        } else if (msg == "-d11!"){     
            llSetTimerEvent(0);    
            state D11W;    
        } else if (msg == "-d12"){     
            llSetTimerEvent(0);    
            state D12;    
        } else if (msg == "-d12!"){     
            llSetTimerEvent(0);    
            state D12W;    
        } else if (msg == "-d13"){     
            llSetTimerEvent(0);    
            state D13;    
        } else if (msg == "-d13!"){     
            llSetTimerEvent(0);    
            state D13W;    
        } else if (msg == "-d14"){     
            llSetTimerEvent(0);    
            state D14;    
        } else if (msg == "-d14!"){     
            llSetTimerEvent(0);    
            state D14W;    
        } else if (msg == "-d15"){     
            llSetTimerEvent(0);    
            state D15;    
        } else if (msg == "-d16"){     
            llSetTimerEvent(0);    
            state D16;    
        } else if (msg == "-d17"){     
            llSetTimerEvent(0);    
            state D17;    
        } else if (msg == "-d18"){     
            llSetTimerEvent(0);    
            state D18;    
        } else if (msg == "-d19"){     
            llSetTimerEvent(0);    
            state D19;    
        } else if (msg == "-d20"){     
            llSetTimerEvent(0);    
            state D20;    
        } else if (msg == "-d21"){     
            llSetTimerEvent(0);    
            state D21;    
        } else if (msg == "-d22"){     
            llSetTimerEvent(0);    
            state D22;    
        } else if(msg == "-nc1"){
            state NC1;
        } else if(msg == "-nc2"){
            state NC2;
        } else if(msg == "-nc3"){
            state NC3;
        } else if(msg == "-nc4"){
            state NC4;
        } else if (msg == "-if"){     
            llSetTimerEvent(0);
            state Intro_fin;           
        } else if (msg == "-fhub") {
            llSetTimerEvent(0);
            state Facil_Hub;
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
                if (debug_level) 
                    llSay(0, "default state: received unknown feedback from dialog box, ignore");
            }             
        } 
        else if (c == button_to_facil_channel) 
        {                   // sent from the green button
            list key_package = llParseString2List(msg, [":"], []);
            trainee = llList2String(key_package, 0);  // here the green button passes the trainee ID to facil
            facilitator = llList2String(key_package, 1);
            llDialog(trainee, "Now you are going to teach a Lecture to the students. Click start when you are ready.", ["Start"] , local_dialog_channel);   
        } 
        else 
        {
            process_common_listen_port_msg(c, n, ID, msg);
        }            
    } 
}

state Facil_Hub {

    state_entry(){      
        llSay(0, "Lab guide stopped. Please state control channel to choose the training state (e.g. -repeat, -restart). See the facilitator guide.");
        register_common_channel_timer(reminder_interval);
    } 
    
    touch_start(integer num_detected) {
        llSay(0, "Please use the state control channel to choose the state of the guide (e.g -repeat, -restart). See the facilitator guide.");
        llSetTimerEvent(reminder_interval);
    }
    
    timer()
    {
       llSay(0, "Lab guide stopped. Please use the state control channel to choose the state of the guide(e.g. -repeat, -restart). See facilitator guide for details");
       llSetTimerEvent(reminder_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        process_common_listen_port_msg(c, n, ID, msg);    
    }    
}   
state Idle {
    
    state_entry(){
        state_name = "idle";
        if (debug_level) 
            llSay(0, "In manual facilitator guided mode.");
        register_common_channel_timer(reminder_interval*3);
    } 
    
    touch_start(integer num_detected){
        key kk;   // display a dialog box to whoever touch the script
                  // may not be the TA
        kk = llDetectedKey(0);
        llSetTimerEvent(reminder_interval*3);        
        if (kk == trainee) {
            llDialog(kk, "Do you really want to reset the training session to auto mode?", 
                     ["Yes", "No" ] , 
                     local_dialog_channel);
        } else llSay(0, "Sorry, only the TA trainee can change the mode of this training session.");
        
        llSetTimerEvent(reminder_interval*3);
    }  
    
    timer() {
        if (debug_level) 
            llSay(0, "in idle state");
        llSetTimerEvent(reminder_interval*3);
    }
        
    listen(integer c, string n, key ID, string msg){
        if (c == local_dialog_channel) {
            if (msg == "Yes") {
                change_to_auto_mode();
            }
        } else process_common_listen_port_msg(c, n, ID, msg);
    }   
}


//////Intro//////
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
        //internal_state = 1;
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D1W
{
    state_entry()
    {
        common_state_entry("d1w", d1_msg1, d1_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d2_msg1, d2_button1,
                                 d2_msg2, d2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg);   
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D2W
{
    state_entry()
    {
        common_state_entry("d2w", d2_msg2, d2_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d2_msg2, d2_button2,
                                 d2_msg2, d2_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d2_msg2, d2_button2,
                                 d2_msg2, d2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D3
{
    state_entry()
    {

        common_state_entry("d3",  (string)llKey2Name(trainee) + d3_msg1, d3_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer( (string)llKey2Name(trainee) + d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer( llKey2Name(trainee) + d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D3W
{
    state_entry()
    {
        common_state_entry("d3w", d3_msg2, d3_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d3_msg2, d3_button2,
                                 d3_msg2, d3_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d3_msg2, d3_button2,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }  
}

state D4
{
    state_entry()
    {
        common_state_entry("d4", d4_msg1, d4_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D4W
{
    state_entry()
    {
        common_state_entry("d4w", d4_msg2, d4_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d4_msg2, d4_button2,
                                 d4_msg2, d4_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d4_msg2, d4_button2,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D5W
{
    state_entry()
    {
        common_state_entry("d5w", d5_msg2, d5_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d5_msg2, d5_button2,
                                 d5_msg2, d5_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d5_msg2, d5_button2,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d6_msg1, d6_button1,
                                 d6_msg2, d6_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D6W
{
    state_entry()
    {
        common_state_entry("d6w", d6_msg2, d6_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d6_msg2, d6_button2,
                                 d6_msg2, d6_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d6_msg2, d6_button2,
                                 d6_msg2, d6_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D7
{
    state_entry()
    {
        common_state_entry("d7",  llKey2Name(trainee) + d7_msg1, d7_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer( llKey2Name(trainee) + d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer( llKey2Name(trainee) + d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D7W
{
    state_entry()
    {
        common_state_entry("d7w", d7_msg2, d7_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d7_msg2, d7_button2,
                                 d7_msg2, d7_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d7_msg2, d7_button2,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d8_msg1, d8_button1,
                                 d8_msg2, d8_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D8W
{
    state_entry()
    {
        common_state_entry("d8w", d8_msg2, d8_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d8_msg2, d8_button2,
                                 d1_msg2, d1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d8_msg2, d8_button2,
                                 d8_msg2, d8_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d9_msg1, d9_button1,
                                 d9_msg2, d9_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D9W
{
    state_entry()
    {
        common_state_entry("d9w", d9_msg2, d9_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d9_msg2, d9_button2,
                                 d9_msg2, d9_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d9_msg2, d9_button2,
                                 d9_msg2, d9_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d10_msg1, d10_button1,
                                 d10_msg2, d10_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D10W
{
    state_entry()
    {
        common_state_entry("d10w", d10_msg2, d10_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d10_msg2, d10_button2,
                                 d10_msg2, d10_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d10_msg2, d10_button2,
                                 d10_msg2, d10_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d11_msg1, d11_button1,
                                 d11_msg2, d11_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg) 
            {
               if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D11W
{
    state_entry()
    {
        common_state_entry("d11w", d11_msg2, d11_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d11_msg2, d11_button2,
                                 d11_msg2, d11_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d11_msg2, d11_button2,
                                 d11_msg2, d11_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d12_msg1, d12_button1,
                                 d12_msg2, d12_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D12W
{
    state_entry()
    {
        common_state_entry("d12w", d12_msg2, d12_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d12_msg2, d12_button2,
                                 d12_msg2, d12_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d12_msg2, d12_button2,
                                 d12_msg2, d12_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d13_msg1, d13_button1,
                                 d13_msg2, d13_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D13W
{
    state_entry()
    {
        common_state_entry("d13w", d13_msg2, d13_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d13_msg2, d13_button2,
                                 d13_msg2, d13_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d13_msg2, d13_button2,
                                 d13_msg2, d13_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d14_msg1, d14_button1,
                                 d14_msg2, d14_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg) 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D14W
{
    state_entry()
    {
        common_state_entry("d14w", d14_msg2, d14_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d14_msg2, d14_button2,
                                 d14_msg2, d14_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d14_msg2, d14_button2,
                                 d14_msg2, d14_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d15_msg1, d15_button1,
                                 d15_msg2, d15_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg) 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d16_msg1, d16_button1,
                                 d16_msg2, d16_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Yes" || msg == "No") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d17_msg1, d17_button1,
                                 d17_msg2, d17_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d18_msg1, d18_button1,
                                 d18_msg2, d18_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d19_msg1, d19_button1,
                                 d19_msg2, d19_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D20
{
    state_entry()
    {
        common_state_entry("d20", d20_msg1, d20_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d20_msg1, d20_button1,
                                 d20_msg2, d20_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d20_msg1, d20_button1,
                                 d20_msg2, d20_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Yes" || msg == "No") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D21
{
    state_entry()
    {
        common_state_entry("d21", d21_msg1, d21_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d21_msg1, d21_button1,
                                 d21_msg2, d21_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d21_msg1, d21_button1,
                                 d21_msg2, d21_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D22
{
    state_entry()
    {
        common_state_entry("d22", d22_msg1, d22_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d22_msg1, d22_button1,
                                 d22_msg2, d22_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d22_msg1, d22_button1,
                                 d22_msg2, d22_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                if(facilitator != NULL_KEY)
                    llInstantMessage(facilitator,"Trainee response: " + msg); 
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state NC1
{
    state_entry()
    {
        llGiveInventory(trainee, "student_questions");
        register_common_channel_timer(reminder_interval);
        state Idle;
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
        llGiveInventory(trainee, "acid_spills");
        register_common_channel_timer(reminder_interval);
        state Idle;
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

state NC3
{
    state_entry()
    {
        llGiveInventory(trainee, "lab_fire");
        register_common_channel_timer(reminder_interval);
        state Idle;
    }    

    touch_start(integer num_detected) 
    {
        llSay(0, "State: NC3");
    }
  
    timer()
    {
        if(debug_level)
            llSay(0, "State: NC3");
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        process_common_listen_port_msg (c, n, ID, msg);         
    } 
} 