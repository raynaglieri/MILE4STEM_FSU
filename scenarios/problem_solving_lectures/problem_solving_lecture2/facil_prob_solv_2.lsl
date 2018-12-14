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

integer scenario_offset = 900000;
integer facil_state_control_channel = 10101;  // chat channel for human control shared by all scripts
integer facil_para_control_channel = 10102;
integer facil_action_control_channel = 10103;

integer button_to_facil_channel = 11500;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11001; // chat channel for feedbacks from the dialog box
integer facil_scribe_channel = 17888; // scribe channel captures 

string facil_scribe_string;

// Message for the dialog and textboxes in the conversation
string d1_msg1 = "You are to discuss with students the concept of pointers and how to resolve problems with the usage of pointers. Look at the problems on whiteboard to see which parts of these problems might be difficult for students.";
list   d1_button1 = ["Okay"];
string d1_msg2 = "Empty";
list   d1_button2 = ["Okay"];

string dw1_msg1 = "Please, start the lecture";
list   dw1_button1 = ["Okay"];
string dw1_msg2 = "null";
list   dw1_button2 = ["Okay"];

string d2_msg1 = "Now ask students which parts of the problems sound difficult for them.";
list   d2_button1 = ["Okay"];
string d2_msg2 = "Empty";
list   d2_button2 = ["Okay"];

string dw2_msg1 = "You might want to ask students which parts of the problems are difficult for them as it might differ from what you think is difficult.";
list   dw2_button1 = ["Okay"];
string dw2_msg2 = "null";
list   dw2_button2 = ["Okay"];

string d3_msg1 = "Note that learners may pay more attention on surface features of the problem rather than on its solution path. For example, they would see all problems with arrays as difficult irrespective of what is required on the output.";
list   d3_button1 = ["Okay"];
string d3_msg2 = "Empty";
list   d3_button2 = ["Okay"];

string dw3_msg1 =  "You might want to ask the rest of the students which parts of the problems are difficult for them.";
list   dw3_button1 = ["Okay"];
string dw3_msg2 = "null";
list   dw3_button2 = ["Okay"];

string d4_msg1 = "null";
list   d4_button1 = ["Okay"];
string d4_msg2 = "Empty";
list   d4_button2 = ["Okay"];

string dw4_msg1 = "You may want to mention that the topic of discussion is pointers and also give some details about scan command.";
list   dw4_button1 = ["Okay"];
string dw4_msg2 = "null";
list   dw4_button2 = ["Okay"];

string d5_msg1 = "You may want to mention that the topic of discussion is pointers, not the memory allocation.";
list   d5_button1 = ["Okay"];
string d5_msg2 = "Empty";
list   d5_button2 = ["Okay"];

string dw5_msg1 = "You may want to explain one of the problems on the white board using the terms givens, restrictions, operators.";
list   dw5_button1 = ["Okay"];
string dw5_msg2 = "null";
list   dw5_button2 = ["Okay"];

string d6_msg1 = "null";
list   d6_button1 = ["Okay"];
string d6_msg2 = "Empty";
list   d6_button2 = ["Okay"];

string dw6_msg1 =  "You may want to explain where are the restrictions in this problem again.";
list   dw6_button1 = ["Okay"];
string dw6_msg2 = "null";
list   dw6_button2 = ["Okay"];

string d7_msg1 = "null";
list   d7_button1 = ["Okay"];
string d7_msg2 = "Empty";
list   d7_button2 = ["Okay"];

string dw7_msg1 =  "You may want to explain where are the givens in this problem again.";
list   dw7_button1 = ["Okay"];
string dw7_msg2 = "null";
list   dw7_button2 = ["Okay"];

string d8_msg1 = "You may want to use the Aid for schema construction and start with the problem analysis, try to use visual representations";
list   d8_button1 = ["Okay"];
string d8_msg2 = "null";
list   d8_button2 = ["Okay"];

string dw8_msg1 =  "You may want to use the Aid for schema construction and start with the problem analysis, try to use visual representations";
list   dw8_button1 = ["Okay"];
string dw8_msg2 = "null";
list   dw8_button2 = ["Okay"];

string d9_msg1 = "null";
list   d9_button1 = ["Okay"];
string d9_msg2 = "null";
list   d9_button2 = ["Okay"];

string dw9_msg1 = "You may want to explain the differences between these problems and the use of pointers";
list   dw9_button1 = ["Okay"];
string dw9_msg2 = "null";
list   dw9_button2 = ["Okay"];

string d10_msg1 = "You could also mention some problem solving strategies such as simplifying the problem by solving one part at a time and name all different approaches that might be used for the whiteboard problems.";
list   d10_button1 = ["Okay"];
string d10_msg2 = "null";
list   d10_button2 = ["Okay"];

string dw10_msg1 = "You may want to name all different approaches that might be used for the whiteboard problems";
list   dw10_button1 = ["Okay"];
string dw10_msg2 = "null";
list   dw10_button2 = ["Okay"];

string d11_msg1 = "See if your students could think aloud about their problem solving steps and use of operators (functions) in order to reach their goal and write a clean code that works. Choose any of the problem descriptions on white board.";
list   d11_button1 = ["Okay"];
string d11_msg2 = "null";
list   d11_button2 = ["Okay"];

string dw11_msg1 =  "You may want to ask your students to think aloud";
list   dw11_button1 = ["Okay"];
string dw11_msg2 = "null";
list   dw11_button2 = ["Okay"];

string d12_msg1 = "null";
list   d12_button1 = ["Okay"];
string d12_msg2 = "null";
list   d12_button2 = ["Okay"];

string dw12_msg1 = "Demonstrate an example of how to think aloud";
list   dw12_button1 = ["Okay"];
string dw12_msg2 = "null";
list   dw12_button2 = ["Okay"];
////
string d13_msg1 = "See if you can talk about one of the problem-solving approaches looking at the examples on white board";
list   d13_button1 = ["Okay"];
string d13_msg2 = "null";
list   d13_button2 = ["Okay"];

string dw13_msg1 = "You may want to talk about one of the problem-solving approaches";
list   dw13_button1 = ["Okay"];
string dw13_msg2 = "null";
list   dw13_button2 = ["Okay"];

string d14_msg1 =  "Socratic questioning also helps with problem-solving. Do your students know about it?";
list   d14_button1 = ["Okay"];
string d14_msg2 = "null";
list   d14_button2 = ["Okay"];

string dw14_msg1 =  "You may want to ask your students about Socratic questioning";
list   dw14_button1 = ["Okay"];
string dw14_msg2 = "null";
list   dw14_button2 = ["Okay"];
// 18
string d15_msg1 = "You might want to describe a Socratic questionning for students";
list   d15_button1 = ["Okay"];
string d15_msg2 = "null";
list   d15_button2 = ["Okay"];

string dw15_msg1 = "You may need to explain what constitutes Socratic questioning.";
list   dw15_button1 = ["Okay"];
string dw15_msg2 = "null";
list   dw15_button2 = ["Okay"];

string d16_msg1 = "null";
list   d16_button1 = ["Okay"];
string d16_msg2 = "null";
list   d16_button2 = ["Okay"];

string dw16_msg1 =  "depending on the learner you might want to use a disciplinary approach or try to bargain your way out giving out one of the midterm questions (rewards).";
list   dw16_button1 = ["Okay"];
string dw16_msg2 = "null";
list   dw16_button2 = ["Okay"];

string d17_msg1 = "Now, you are talking about the results of their last quiz.";
list   d17_button1 = ["Okay"];
string d17_msg2 = "null";
list   d17_button2 = ["Okay"];

string dw17_msg1 = "null";
list   dw17_button1 = ["Okay"];
string dw17_msg2 = "null";
list   dw17_button2 = ["Okay"];

string d18_msg1 = "to build student’s confidence you might want to give an example of an acceptable, rather than ideal performance level and suggest they do their personal best.";
list   d18_button1 = ["Okay"];
string d18_msg2 = "null";
list   d18_button2 = ["Okay"];

string dw18_msg1 = "null";
list   dw18_button1 = ["Okay"];
string dw18_msg2 = "null";
list   dw18_button2 = ["Okay"];

string d19_msg1 = "null";
list   d19_button1 = ["Okay"];
string d19_msg2 = "null";
list   d19_button2 = ["Okay"];

string dw19_msg1 = "You need to know how well students understood your lecture.";
list   dw19_button1 = ["Okay"];
string dw19_msg2 = "null";
list   dw19_button2 = ["Okay"];

string d20_msg1 = "sometimes learners have an impression they understood everything but later have difficulties completing homework or answering a quiz. One of the ways to understand where your learners are at in their progress is to probe them to ask questions by introducing an upcoming quiz and promising to answer some questions if they ask them now.";
list   d20_button1 = ["Okay"];
string d20_msg2 = "null";
list   d20_button2 = ["Okay"];

string dw20_msg1 = "You need to understand where your learners are at.";
list   dw20_button1 = ["Okay"];
string dw20_msg2 = "null";
list   dw20_button2 = ["Okay"];

string d21_msg1 = "You might want to ask why students are not raising their hands to ask their questions";
list   d21_button1 = ["Okay"];
string d21_msg2 = "null";
list   d21_button2 = ["Okay"];

string dw21_msg1 = "null";
list   dw21_button1 = ["Okay"];
string dw21_msg2 = "null";
list   dw21_button2 = ["Okay"];

string d22_msg1 = "null";
list   d22_button1 = ["Okay"];
string d22_msg2 = "null";
list   d22_button2 = ["Okay"];

string dw22_msg1 = "You might want to change an instructional sequence or repeat some complex topics, depending on students’ understanding.";
list   dw22_button1 = ["Okay"];
string dw22_msg2 = "null";
list   dw22_button2 = ["Okay"];

string d23_msg1 = "An alternative way is to suggest coming during office hours for an additional explanation.";
list   d23_button1 = ["Okay"];
string d23_msg2 = "null";
list   d23_button2 = ["Okay"];

string dw23_msg1 = "null";
list   dw23_button1 = ["Okay"];
string dw23_msg2 = "null";
list   dw23_button2 = ["Okay"];

set_offset()
{
    facil_state_control_channel = 10101 + scenario_offset; 
    facil_para_control_channel = 10102 + scenario_offset;
    facil_action_control_channel = 10103 + scenario_offset;
    button_to_facil_channel = 11500 + scenario_offset;   
    backdoor_channel = 20001 + scenario_offset;    
    local_dialog_channel = 11001 + scenario_offset;
    facil_scribe_channel = 17888 + scenario_offset;
}

send_response_to_facil(string trainee_response)
{
    if(facilitator != NULL_KEY)
    {
        llInstantMessage(facilitator,"Trainee response: " + trainee_response); 
        llSay(facil_scribe_channel, "scribe~*~" + facil_scribe_string + "::" + trainee_response);
    }
}

send_promt_to_facil(string trainee_prompt)
{
    if(facilitator != NULL_KEY)
    {
        llInstantMessage(facilitator,"Text Box Prompt: " + trainee_prompt); 
        facil_scribe_string = trainee_prompt;
    }
}

//reset the changeable variables to the original mode
reset_glob()
{
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
        }  else if (msg == "-d8"){     
            llSetTimerEvent(0); 
            state D8;    
        } else if (msg == "-d8!"){     
            llSetTimerEvent(0); 
            state D8W;    
        }  else if (msg == "-d9"){     
            llSetTimerEvent(0); 
            state D9;    
        } else if (msg == "-d9!"){     
            llSetTimerEvent(0); 
            state D9W;    
        }  else if (msg == "-d10"){     
            llSetTimerEvent(0); 
            state D10;    
        } else if (msg == "-d10!"){     
            llSetTimerEvent(0); 
            state D10W;    
        }  else if (msg == "-d11"){     
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
        } else if (msg == "-d15!"){     
            llSetTimerEvent(0); 
            state D15W;    
        } else if (msg == "-d16"){     
            llSetTimerEvent(0); 
            state D16;    
        } else if (msg == "-d16!"){     
            llSetTimerEvent(0); 
            state D16W;    
        } else if (msg == "-d17"){     
            llSetTimerEvent(0); 
            state D17;    
        } else if (msg == "-d17!"){     
            llSetTimerEvent(0); 
            state D17W;    
        } else if (msg == "-d18"){     
            llSetTimerEvent(0); 
            state D18;    
        } else if (msg == "-d18!"){     
            llSetTimerEvent(0); 
            state D18W;    
        } else if (msg == "-d19"){     
            llSetTimerEvent(0); 
            state D19;    
        } else if (msg == "-d19!"){     
            llSetTimerEvent(0); 
            state D19W;    
        } else if (msg == "-d20"){     
            llSetTimerEvent(0); 
            state D20;    
        } else if (msg == "-d20!"){     
            llSetTimerEvent(0); 
            state D20W;    
        } else if (msg == "-d21"){     
            llSetTimerEvent(0); 
            state D21;    
        } else if (msg == "-d21!"){     
            llSetTimerEvent(0); 
            state D21W;    
        } else if (msg == "-d22"){     
            llSetTimerEvent(0); 
            state D22;    
        } else if (msg == "-d22!"){     
            llSetTimerEvent(0); 
            state D22W;    
        } else if (msg == "-d23"){     
            llSetTimerEvent(0); 
            state D23;    
        } else if (msg == "-d23!"){     
            llSetTimerEvent(0); 
            state D23W;    
        } else if (msg == "-nc1"){   
            llSetTimerEvent(0); 
            llGiveInventory(trainee, "probl_solving _analysis _aid"); 
            state Idle; 
        } else if (msg == "-nc2"){   
            llSetTimerEvent(0); 
            llGiveInventory(trainee, "problem_solving_aid"); 
            state Idle; 
        } else if (msg == "-nc3"){   
            llSetTimerEvent(0); 
            llGiveInventory(trainee, "problem_solving_aid_2"); 
            state Idle; 
        } else if (msg == "-nc4"){   
            llSetTimerEvent(0); 
            llGiveInventory(trainee, "socaratic_questions"); 
            state Idle; 
        } else if (msg == "-nc5"){   
            llSetTimerEvent(0); 
            llGiveInventory(trainee, "schema_construction_aid"); 
            state Idle; 
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
        send_promt_to_facil(msg1);  
        if (button1 == [])
            llTextBox(trainee, msg1, local_dialog_channel); 
    else llDialog(trainee, msg1, button1, local_dialog_channel);    
    } else if (internal_state == 1) {
        send_promt_to_facil(msg2);   
        if (button2 == []) 
            llTextBox(trainee, msg2, local_dialog_channel);
        else llDialog(trainee, msg2, button2, local_dialog_channel);
  }
}

common_state_entry(string n, string s, list l, integer t)
{
    internal_state = 0;
    state_name = n;
    send_promt_to_facil(s);   
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
        set_offset();
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D1W
{
    state_entry()
    {
        common_state_entry("d1w", dw1_msg1, dw1_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw1_msg1, dw1_button1,
                                 dw1_msg2, dw1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw1_msg1, dw1_button1,
                                 dw1_msg2, dw1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(dw2_msg1, dw2_button1,
                                 dw2_msg2, dw2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d3_msg1, d3_button1,
                                 d3_msg2, d3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D3W
{
    state_entry()
    {
        common_state_entry("D3W", dw3_msg1, dw3_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw3_msg1, dw3_button1,
                                 dw3_msg2, dw3_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw3_msg1, dw3_button1,
                                 dw3_msg2, dw3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D4W
{
    state_entry()
    {
        common_state_entry("D4W", dw4_msg1, dw4_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw4_msg1, dw4_button1,
                                 dw4_msg2, dw4_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw4_msg1, dw4_button1,
                                 dw4_msg2, dw4_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D5W
{
    state_entry()
    {
        common_state_entry("D5W", dw5_msg1, dw5_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw5_msg1, dw5_button1,
                                 dw5_msg2, dw5_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw5_msg1, dw5_button1,
                                 dw5_msg2, dw5_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D6W
{
    state_entry()
    {
        common_state_entry("D6W", dw6_msg1, dw6_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw6_msg1, dw6_button1,
                                 dw6_msg2, dw6_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw6_msg1, dw6_button1,
                                 dw6_msg2, dw6_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
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
        //internal_state = 1;
        dialog_dialog_with_timer(d7_msg1, d7_button1,
                                 d7_msg2, d7_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D7W
{
    state_entry()
    {
        common_state_entry("D7W", dw7_msg1, dw7_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw7_msg1, dw7_button1,
                                 dw7_msg2, dw7_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw7_msg1, dw7_button1,
                                 dw7_msg2, dw7_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D8W
{
    state_entry()
    {
        common_state_entry("D8W", dw8_msg1, dw8_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw8_msg1, dw8_button1,
                                 dw8_msg2, dw8_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw8_msg1, dw8_button1,
                                 dw8_msg2, dw8_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D9W
{
    state_entry()
    {
        common_state_entry("D9W", dw9_msg1, dw9_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw9_msg1, dw9_button1,
                                 dw9_msg2, dw9_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw9_msg1, dw9_button1,
                                 dw9_msg2, dw9_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D10W
{
    state_entry()
    {
        common_state_entry("D10W", dw10_msg1, dw10_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw10_msg1, dw10_button1,
                                 dw10_msg2, dw10_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw10_msg1, dw10_button1,
                                 dw10_msg2, dw10_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D11W
{
    state_entry()
    {
        common_state_entry("D11W", dw11_msg1, dw11_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw11_msg1, dw11_button1,
                                 dw11_msg2, dw11_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw11_msg1, dw11_button1,
                                 dw11_msg2, dw11_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D12W
{
    state_entry()
    {
        common_state_entry("D12W", dw12_msg1, dw12_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw12_msg1, dw12_button1,
                                 dw12_msg2, dw12_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw12_msg1, dw12_button1,
                                 dw12_msg2, dw12_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D13W
{
    state_entry()
    {
        common_state_entry("D13W", dw13_msg1, dw13_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw13_msg1, dw13_button1,
                                 dw13_msg2, dw13_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw13_msg1, dw13_button1,
                                 dw13_msg2, dw13_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D14W
{
    state_entry()
    {
        common_state_entry("D14W", dw14_msg1, dw14_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw14_msg1, dw14_button1,
                                 dw14_msg2, dw14_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw14_msg1, dw14_button1,
                                 dw14_msg2, dw14_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D15W
{
    state_entry()
    {
        common_state_entry("D15W", dw15_msg1, dw15_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw15_msg1, dw15_button1,
                                 dw15_msg2, dw15_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw15_msg1, dw15_button1,
                                 dw15_msg2, dw15_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D16W
{
    state_entry()
    {
        common_state_entry("D16W", dw16_msg1, dw16_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw16_msg1, dw16_button1,
                                 dw16_msg2, dw16_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw16_msg1, dw16_button1,
                                 dw16_msg2, dw16_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D17W
{
    state_entry()
    {
        common_state_entry("D17W", dw17_msg1, dw17_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw17_msg1, dw17_button1,
                                 dw17_msg2, dw17_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw17_msg1, dw17_button1,
                                 dw17_msg2, dw17_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D18W
{
    state_entry()
    {
        common_state_entry("D18W", dw18_msg1, dw18_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw18_msg1, dw18_button1,
                                 dw18_msg2, dw18_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw18_msg1, dw18_button1,
                                 dw18_msg2, dw18_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D19W
{
    state_entry()
    {
        common_state_entry("D19W", dw19_msg1, dw19_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw19_msg1, dw19_button1,
                                 dw19_msg2, dw19_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw19_msg1, dw19_button1,
                                 dw19_msg2, dw19_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D20W
{
    state_entry()
    {
        common_state_entry("D20W", dw20_msg1, dw20_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw20_msg1, dw20_button1,
                                 dw20_msg2, dw20_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw20_msg1, dw20_button1,
                                 dw20_msg2, dw20_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D21W
{
    state_entry()
    {
        common_state_entry("D21W", dw21_msg1, dw21_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw21_msg1, dw21_button1,
                                 dw21_msg2, dw21_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw21_msg1, dw21_button1,
                                 dw21_msg2, dw21_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
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
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D22W
{
    state_entry()
    {
        common_state_entry("D22W", dw22_msg1, dw22_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw22_msg1, dw22_button1,
                                 dw22_msg2, dw22_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw22_msg1, dw22_button1,
                                 dw22_msg2, dw22_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D23
{
    state_entry()
    {
        common_state_entry("d23", d23_msg1, d23_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d23_msg1, d23_button1,
                                 d23_msg2, d23_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d23_msg1, d23_button1,
                                 d23_msg2, d23_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D23W
{
    state_entry()
    {
        common_state_entry("D23W", dw23_msg1, dw23_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(dw23_msg1, dw23_button1,
                                 dw23_msg2, dw23_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(dw23_msg1, dw23_button1,
                                 dw23_msg2, dw23_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            send_response_to_facil(msg);
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}