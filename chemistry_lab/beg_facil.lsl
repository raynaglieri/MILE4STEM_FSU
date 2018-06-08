//  CREATED BY: Raymond Naglieri on 06/01/2018 
// DESCRIPTION: Facilitator beg pop-up control. 
//         LOG: 06/06/2018 - Updated for chemistry lab.
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
integer dialog_box_interact_interval = 15;
                           
//DO NOT MODIFY
// these are the constants used for all scripts for the chemistry lab

integer facil_beg_guide_channel = 10101;  // chat channel for human control shared by all scripts
integer facil_para_control_channel = 10102;
integer facil_action_control_channel = 10103;

integer button_to_facil_channel = 11500;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11001; // chat channel for feedbacks from the dialog box


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

integer internal_state;    // working storage to store the status within a state

// Utility variables
integer reminder_interval = 120; // interval to send a reminder chat message to 
                                // tell the trainee what to do, or where is the session.
integer dialog_box_interact_interval = 60;
                           
//DO NOT MODIFY
// these are the constants used for all scripts for the chemistry lab

// chat channel for human control shared by all scripts

integer facil_beg_guide_channel = 10104

integer button_to_facil_channel = 11500;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11002; // chat channel for feedbacks from the dialog box

// Message for the dialog and textboxes in the conversation
string d1_msg1 = "Did you talk about learning objectives? Please click on Yes or No.";
list   d1_button1 = ["Yes", "No"];
string d1_msg2 = "Great! Keep in mind that informing students learning objectives help them better understand why they are doing this lab. Click Okey to continue.";
list   d1_button2 = ["Okay"];

string d1_s1_msg1 = "A learning objective informs students what they are expected to achieve after the instruction. Can you think of 1-2 objective for this lab session? When you are done, click Submit to continue.";
list   d1_s1_button1 = [];
string d1_s1_msg2 = "Great! Keep in mind that informing students learning objectives help them better understand why they are doing this lab. Click Okay to continue.";
list   d1_s1_button2 = ["Okay"];

string d2_msg1 = "Did you give a brief review of the lab’s background? Click Yes or No to continue.";
list   d2_button1 = ["Yes", "No"];
string d2_msg2 = "Great! An overview would stimulate what students already know. Click Okey to continue";
list   d2_button2 = ["Okay"];

string d2_s1_msg1 = "Can you briefly describe the background of this lab? You may use the lab manual (in your resource library) if you want to. When you are done, click Submit to continue.";
list   d2_s1_button1 = [];
string d2_s1_msg2 = "Great! An overview would stimulate what students already know. Click Okay to continue.";
list   d2_s1_button2 = ["Okay"];

string d2_s2_msg1 = "How would you demonstrate the experiment procedures? When you are done, click Submit to continue.";
list   d2_s2_button1 = [];
string d2_s2_msg2 = "";
list   d2_s2_button2 = [];

string d2_s3_msg1 = "Can you use the simulated experiment and give a demo? When you are done, click Submit to continue.";
list   d2_s3_button1 = [];
string d2_s3_msg2 = "";
list   d2_s3_button2 = [];

string d3_msg1 = "Did you emphasize the key points? Click Yes or No to continue.";
list   d3_button1 = ["Yes", "No"];
string d3_msg2 = "Wonderful! This helps students recall and pay attention to the important steps of the experiment. Click OKay to continue.";
list   d3_button2 = ["Okay"];

string d3_s1_msg1 = "Can you think of some key points? When you are done, click Submit to continue.";
list   d3_s1_button1 = [];
string d3_s1_msg2 = "Wonderful! This helps students recall and pay attention to the important steps of the experiment. Click Okay to continue.";
list   d3_s1_button2 = ["Okay"];

string d4_msg1 = "What about common mistakes? Did you mention any? Click Yes or No to continue.";
list   d4_button1 = ["Yes", "No"];
string d4_msg2 = "Awesome! Pointing out these points would also raise students attention and keep them away from these issues. Click Okay to continue.";
list   d4_button2 = ["Okay"];

string d5_msg1 = "Do you know what they are? Where to get such information? Click Yes or No to continue.";
list   d5_button1 = ["Yes", "No"];
string d5_msg2 = "Great! What would you  do to find it out? When you are done, click Submit to continue";
list   d5_button2 = [];

string d5_s1_msg1 = "Knowing common problems not only help you prepare but also may keep students away from them";
list   d5_s1_button1 = ["Okay"];
string d5_s1_msg2 = "";
list   d5_s1_button2 = [];

string d6_msg1 = "Okay, is this your first time teaching this lab? Click Yes or No to continue.";
list   d6_button1 = ["Yes", "No"];
string d6_msg2 = "Okay, talk to your TA supervisor or fellow TAs who have experience teaching this lab. Click Okay to continue.";
list   d6_button2 = ["Okay"];
string d6_msg3 = "You can go back to your previous students lab reports and see what they were their common mistakes. Or, talk to your TA supervisor or fellow TAs who have experience teaching this lab. Click Okay to continue.";
list   d6_button3 = ["Okay"];

string d7_msg1 = "Do you have instructions give to students before they start their experiments? Click Yes or No to continue.";
list   d7_button1 = ["Yes", "No"];
string d7_msg2 = "Great! What would the instructions be about? When you are done, click Submit to continue.";
list   d7_button2 = [];

string d7_s1_msg1 = "What about lab safety rules? Click Submit when you are done.";
list   d7_s1_button1 = [];
string d7_s1_msg2 = "";
list   d7_s1_button2 = [];

string fin_msg1 = "You are now ready. Click Okay to proceed to the lab.";
list   fin_button1 = ["Okay"];
string fin_msg2 = "";
list   fin_button2 = [];

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
    llListen(facil_beg_guide_channel, "", NULL_KEY, "");
    llListen(local_dialog_channel, "", NULL_KEY, "");
}

register_common_channel_timer(integer t)
{
    llListen(facil_beg_guide_channel, "", NULL_KEY, "");
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
    if (c == facil_beg_guide_channel) {  // change state include restart
        if (msg == "-repeat") {
            gotostate(state_id);
        } if ((msg  == "-is") || (msg == "-reset") || (msg == "-restart") ||
           (msg == "completerestart")) {        
            reset_glob();
            llSetTimerEvent(0);
            state default;        
        } else if (msg == "-id1"){     
               llSetTimerEvent(0);    
            state Intro_d1;    
        } else if (msg == "-id1s1"){
            llSetTimerEvent(0);        
            state Intro_d1_s1;    
        }  else if (msg == "-id2"){     
            llSetTimerEvent(0);
            state Intro_d2;    
        }  else if (msg == "-id2s1"){     
            llSetTimerEvent(0); 
            state Intro_d2_s1;    
        }  else if (msg == "-id2s2"){     
            llSetTimerEvent(0);
            state Intro_d2_s2;    
        }  else if (msg == "-id2s3"){  
            llSetTimerEvent(0);        
            state Intro_d2_s3;    
        }  else if (msg == "-id3"){     
            llSetTimerEvent(0);
            state Intro_d3;    
        }  else if (msg == "-id3s1"){     
            llSetTimerEvent(0);
            state Intro_d3_s1;    
        } else if (msg == "-id4"){     
            llSetTimerEvent(0);
            state Intro_d4;    
        } else if (msg == "-id5"){     
            llSetTimerEvent(0);
            state Intro_d5;    
        } else if (msg == "-id5s1"){     
            llSetTimerEvent(0);
            state Intro_d5_s1;    
        } else if (msg == "-id6"){     
            llSetTimerEvent(0);
            state Intro_d6;    
        } else if (msg == "-id7"){    
            llSetTimerEvent(0);
            state Intro_d7;    
        } else if (msg == "-id7s1"){    
            llSetTimerEvent(0);
            state Intro_d7_s1;    
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
    llInstantMessage(facilitator, msg1);   
    if (button1 == [])
        llTextBox(trainee, msg1, local_dialog_channel); 
    else llDialog(trainee, msg1, button1, local_dialog_channel);    
  } else if (internal_state == 1) {
        llInstantMessage(facilitator, msg2);   
    if (button2 == []) 
        llTextBox(trainee, msg2, local_dialog_channel);

    else llDialog(trainee, msg2, button2, local_dialog_channel);
  }
}

common_state_entry(string n, string s, list l, integer t)
{
    internal_state = 0;
    state_name = n;
    llInstantMessage(facilitator, s);   
     if (l == [])
        llTextBox(trainee, s, local_dialog_channel);
    else llDialog(trainee, s, l, local_dialog_channel);
    register_common_channel_timer(t);

// default state:
//   prepare to start the lab: allow people to change session mode:
//      manual: guided by a facilitator
//      automatic: follow Zhaihuan's logic

default{
  
    state_entry(){
        llListen(facil_beg_guide_channel, "", NULL_KEY, "");
    }   
            
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(reminder_interval); // some activity, do not send reminder just yet
        if (c == local_dialog_channel) {
            if (msg == "Yes") {
                state Intro_d1;
            } else if (msg == "No") {
                llSetTimerEvent(0); // turn off timer
                llSay(0, "Ok, the facilitator will guide you through the scenario.");
                state Idle; 
            } else {
                if (debug_level > 0) 
                    llSay(0, "default state: received unknown feedback from dialog box, ignore");
            }             
        } else if (c == button_to_facil_channel) {  // sent from the green button
            trainee = msg;  // here the green button passes the trainee ID to facil
            llDialog(trainee, "Now you are going to teach a lab on Acids and Bases to the students. Do you want to go through the basic lab guide?", 
                     ["Yes", "No"] , local_dialog_channel);               
        } else {
            process_common_listen_port_msg(c, n, ID, msg);
        }            
    } 
}



// this is when the session in a recovery mode, waiting to go to certain state.
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
state Intro_d1{
 
    state_entry(){ 
        common_state_entry("d1", d1_msg1, d1_button1, dialog_box_interact_interval);
    }
    
    touch_start(integer num_detected) {  
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d1_msg1, d1_button1,
                                 d1_msg2, d1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg) {
        llSetTimerEvent(20);    
        if (c == local_dialog_channel){
           if(msg == "Yes"){
                internal_state = 1;
                llDialog(trainee, d1_msg2, d1_button2, local_dialog_channel);
           } else if (msg == "No") {
                llSetTimerEvent(0);
                state Intro_d1_s1;
           } else if (msg == "Okay") {
               llSetTimerEvent(0);
               state Intro_d2;
           }
        } else {
            process_common_listen_port_msg(c, n, ID, msg);
        }
    } 
}

state Intro_d1_s1{
 
    state_entry(){
        common_state_entry("d1s1", d1_s1_msg1, d1_s1_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d1_s1_msg1, d1_s1_button1,
                                 d1_s1_msg2, d1_s1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        dialog_dialog_with_timer(d1_s1_msg1, d1_s1_button1,
                                 d1_s1_msg2, d1_s1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel){
            if (msg == "Okay") {
                llSetTimerEvent(0);
                state Intro_d2;
            } else {
                internal_state = 1;
                llDialog(trainee, d1_s1_msg2, d1_s1_button2, local_dialog_channel);
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    } 
    
}

state Intro_d2{
 
    state_entry(){
        common_state_entry("d2", d2_msg1, d2_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d2_msg1, d2_button1,
                                 d2_msg2, d2_button2, dialog_box_interact_interval);
    }
  
    timer(){
        dialog_dialog_with_timer(d2_msg1, d2_button1,
                                 d2_msg2, d2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
           if(msg == "Yes"){
               internal_state = 1;
               llDialog(trainee, d2_msg2, d2_button2, local_dialog_channel);
           } else if (msg == "No") {
               llSetTimerEvent(0);
               state Intro_d2_s1;
           } else if (msg == "Okay") {
               llSetTimerEvent(0);
               state Intro_d2_s2;
           }
        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
} 

state Intro_d2_s1{
 
    state_entry(){
        common_state_entry("d2s1", d2_s1_msg1, d2_s1_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d2_s1_msg1, d2_s1_button1,
                                 d2_s1_msg2, d2_s1_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d2_s1_msg1, d2_s1_button1,
                                 d2_s1_msg2, d2_s1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);
       if (c == local_dialog_channel){
             if (msg == "Okay") {
                 llSetTimerEvent(0);
                 state Intro_d2_s2;
             } else {
                 internal_state = 1;             
                 llDialog(trainee, d2_s1_msg2, d2_s1_button2 , local_dialog_channel);
             }
        } else process_common_listen_port_msg (c, n, ID, msg);
    } 
    
}

state Intro_d2_s2{
 
    state_entry(){
        common_state_entry("d2s2", d2_s2_msg1, d2_s2_button1, dialog_box_interact_interval);
    }  
    touch_start(integer num_detected) {
       llSetTimerEvent(dialog_box_interact_interval);
       llTextBox(trainee, d2_s2_msg1, local_dialog_channel);
    }
  
    timer()
    {
        llTextBox(trainee, d2_s2_msg1, local_dialog_channel);
        llSetTimerEvent(dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){  
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel){
             llSetTimerEvent(0);
             state Intro_d2_s3;
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d2_s3{
 
    state_entry(){
        common_state_entry("d2s3", d2_s3_msg1, d2_s3_button1, dialog_box_interact_interval);
    }  
    touch_start(integer num_detected) {
        llSetTimerEvent(dialog_box_interact_interval);
        llTextBox(trainee, d2_s3_msg1, local_dialog_channel);
    }
  
    timer()
    {
        llSetTimerEvent(dialog_box_interact_interval);
        llTextBox(trainee, d2_s3_msg1, local_dialog_channel);
        llSetTimerEvent(dialog_box_interact_interval);
    }    
    listen(integer c, string n, key ID, string msg){
        
        if (c == local_dialog_channel){
             llSetTimerEvent(0);
             state Intro_d3;
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d3{
 
    state_entry(){
        common_state_entry("d3", d3_msg1, d3_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
  
    timer(){
        dialog_dialog_with_timer(d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);        
        if (c == local_dialog_channel){
        
           if(msg == "Yes"){
                internal_state = 1;
                llDialog(trainee, d3_msg2, d3_button2 , local_dialog_channel);   
           } else if (msg == "No") {
                llSetTimerEvent(0);
                state Intro_d3_s1;
           } else if (msg == "Okay") {
               llSetTimerEvent(0);
               state Intro_d4;
           }
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}  

state Intro_d3_s1{
 
    state_entry(){
        common_state_entry("d3s1", d3_s1_msg1, d3_s1_button1, dialog_box_interact_interval);
    }  
    
    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d3_s1_msg1, d3_s1_button1,
                                 d3_s1_msg2, d3_s1_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d3_s1_msg1, d3_s1_button1,
                                 d3_s1_msg2, d3_s1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg){
         llSetTimerEvent(dialog_box_interact_interval);
       if (c == local_dialog_channel){
             if (msg == "Okay") {
                 llSetTimerEvent(0);
                 state Intro_d4;
             } else {
                 internal_state = 1;
                 llDialog(trainee, d3_s1_msg2, d3_s1_button2, local_dialog_channel);
            }      
        } else process_common_listen_port_msg (c, n, ID, msg); 
    } 
}

state Intro_d4{
 
    state_entry(){
        common_state_entry("d4", d4_msg1, d4_button1, dialog_box_interact_interval);
    }
    
     touch_start(integer num_detected) {
        dialog_dialog_with_timer(d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }
  
    timer()
    {
        dialog_dialog_with_timer(d4_msg1, d4_button1,
                                 d4_msg2, d4_button2, dialog_box_interact_interval);
    }   
    
    listen(integer c, string n, key ID, string msg){  
         llSetTimerEvent(dialog_box_interact_interval);
      if (c == local_dialog_channel){
           if(msg == "Yes"){
               internal_state = 1;
               llDialog(trainee, d4_msg2, d4_button2 , local_dialog_channel);   
           } else if (msg == "No") {
                llSetTimerEvent(0);
                state Intro_d5; 
           } else if (msg == "Okay") {
               llSetTimerEvent(0);
               state Intro_d7;
           }
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d5{
 
    state_entry(){
        common_state_entry("d5", d5_msg1, d5_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }
  
    timer() {
        dialog_dialog_with_timer(d5_msg1, d5_button1,
                                 d5_msg2, d5_button2, dialog_box_interact_interval);
    }   
    
    listen(integer c, string n, key ID, string msg){
         llSetTimerEvent(dialog_box_interact_interval);       
        if (c == local_dialog_channel){
           if(msg == "Yes"){
               internal_state = 1;
               llTextBox(trainee, d5_msg2, local_dialog_channel);        
           } else if (msg == "No") {
                llSetTimerEvent(0);
                state Intro_d6;
           } else {
                llSetTimerEvent(0);
                state Intro_d5_s1;
           }
        }  else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d5_s1{
 
    state_entry(){
        common_state_entry("d5s1", d5_s1_msg1, d5_s1_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) {
        llSetTimerEvent(dialog_box_interact_interval);
        llDialog(trainee, d5_s1_msg1, d5_s1_button1, local_dialog_channel);
    }
  
    timer()
    {
        llDialog(trainee, d5_s1_msg1, d5_s1_button1 , local_dialog_channel);
        llSetTimerEvent(dialog_box_interact_interval);
    }    
    
    listen(integer c, string n, key ID, string msg){
        
        if (c == local_dialog_channel){
             llSetTimerEvent(0);
             state Intro_d7;        
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d6 {
 
    state_entry(){
        common_state_entry("d6", d6_msg1, d6_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) {
        llSetTimerEvent(dialog_box_interact_interval);
        if (internal_state == 0) 
            llDialog(trainee, d6_msg1, ["Yes", "No"] , local_dialog_channel);
        else if (internal_state == 1)    
            llDialog(trainee, d6_msg2, ["Okay"] , local_dialog_channel);  
        else if (internal_state == 2)
             llDialog(trainee, d6_msg3, ["Okay"], local_dialog_channel);
    }
  
    timer()
    {
        if (internal_state == 0) 
            llDialog(trainee, d6_msg1, ["Yes", "No"] , local_dialog_channel);
        else if (internal_state == 1)    
            llDialog(trainee, d6_msg2, ["Okay"] , local_dialog_channel);  
        else if (internal_state == 2)
             llDialog(trainee, d6_msg3, ["Okay"], local_dialog_channel);
        llSetTimerEvent(dialog_box_interact_interval);
    }   
    
    listen(integer c, string n, key ID, string msg){
         llSetTimerEvent(dialog_box_interact_interval);       
        if (c == local_dialog_channel){
            if(msg == "Yes"){
                internal_state = 1;
                llDialog(trainee, d6_msg2, ["Okay"] , local_dialog_channel);       
            } else if (msg == "No") {
                internal_state = 2;
                llDialog(trainee, d6_msg3, ["Okay"], local_dialog_channel);
           } else if (msg == "Okay") {
               llSetTimerEvent(0);
               state Intro_d5_s1;
           }
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d7{
 
    state_entry(){
        common_state_entry("d7", d7_msg1, d7_button1, dialog_box_interact_interval);  
    }  

    touch_start(integer num_detected) {
        dialog_dialog_with_timer(d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }
  
    timer() {
        dialog_dialog_with_timer(d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }   
    
    listen(integer c, string n, key ID, string msg){
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel){
            if(msg == "Yes"){
                internal_state = 1;
                llTextBox(trainee, d7_msg2, local_dialog_channel);
            } else if (msg == "No") {
                llSetTimerEvent(0);
                state Intro_d7_s1;
            } else {
               llSetTimerEvent(0);
               state Intro_d7_s1;
            } 
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_d7_s1{
 
    state_entry(){
        common_state_entry("d7_s1", d7_s1_msg1, d7_s1_button1, dialog_box_interact_interval);
    }  
    
     touch_start(integer num_detected) {
        llSetTimerEvent(dialog_box_interact_interval);
        llTextBox(trainee, d7_s1_msg1, local_dialog_channel);
    }
  
    timer()
    {
        llTextBox(trainee, d7_s1_msg1, local_dialog_channel);
        llSetTimerEvent(dialog_box_interact_interval);
    }       
    listen(integer c, string n, key ID, string msg){
         llSetTimerEvent(dialog_box_interact_interval);       
        if (c == local_dialog_channel){
           llSetTimerEvent(0);
           state Intro_fin;
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}

state Intro_fin{
 
    state_entry(){
        common_state_entry("final", fin_msg1, fin_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) {
         llSetTimerEvent(dialog_box_interact_interval);
        llDialog(trainee, fin_msg1, fin_button1, local_dialog_channel);
    }
  
    timer()
    {
        llDialog(trainee, fin_msg1, fin_button1, local_dialog_channel);
        llSetTimerEvent(dialog_box_interact_interval);
    }       
    
    listen(integer c, string n, key ID, string msg){
        
        if (c == local_dialog_channel){
            llSetTimerEvent(0);
            state Idle;
        } else process_common_listen_port_msg(c, n, ID, msg);
    } 
}


       