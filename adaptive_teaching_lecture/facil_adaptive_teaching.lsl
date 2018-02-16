// variables whose value can be changed during the execution of the script
key trainee = NULL_KEY;      // the key for the TA being trained
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

integer facil_state_control_channel = 10101;  // chat channel for human control shared by all scripts
integer facil_para_control_channel = 10102;
integer facil_action_control_channel = 10103;

integer button_to_facil_channel = 11500;   // chat channel from green button to facil
integer backdoor_channel = 20001;    // channel to talk to backdoor script
integer local_dialog_channel = 11001; // chat channel for feedbacks from the dialog box

// Message for the dialog and textboxes in the conversation
string d1_msg1 = "Are students engaged during your lecture? You may want to check their situational interest by asking how interested they are in the details of the topic or the task.";
list   d1_button1 = ["Okay"];
string d1_msg2 = "Check for your learners situational interest!";
list   d1_button2 = ["Okay"];

string d2_msg1 = "Students are not engaged when they are in low situational interest state. What other learning activities can catch their interest? Try them!";
list   d2_button1 = ["Okay"];
string d2_msg2 = "Empty";
list   d2_button2 = ["Okay"];

string d3_msg1 = "It is also important to track learners’ cognitive states. Do they understand everything? You can find it out by asking some questions or give a quiz";
list   d3_button1 = ["Okay"];
string d3_msg2 = "You might want to ask students whether they understand the topic or not.";
list   d3_button2 = ["Okay"];

string d4_msg1 = "Keep in mind that students learn differently. You may use different forms of learning materials and activities to accommodate their learning styles.";
list   d4_button1 = ["Okay"];
string d4_msg2 = "You might want to give the student a handout.";
list   d4_button2 = ["Okay"];

string d5_msg1 = "Students come to class with different goals: some focus on learning while some may concern more about grades.";
list   d5_button1 = ["Okay"];
string d5_msg2 = "Empty";
list   d5_button2 = ["Okay"];

string d6_msg1 = "Did you notice that some students are not paying attention? They might be confused or not motivated by some part of your lecture. Can you ask students how they are going with your lecture?";
list   d6_button1 = ["Okay"];
string d6_msg2 = "Empty";
list   d6_button2 = ["Okay"];

string d7_msg1 = "You may also want to reflect whether the cues your students gave are emotional or cognitive. Now try to handle emotional cues by better engaging your students.";
list   d7_button1 = ["Okay"];
string d7_msg2 = "You might want to try telling a joke or making some intentionally funny movement and asking if students noticed it to attract everybody’s attention";
list   d7_button2 = ["Okay"];

string d8_msg1 = "Academic standards or “cultures” can be different between disciplines. It is important to let students understand the culture of your discipline, such as why something is done in a certain way.";
list   d8_button1 = ["Okay"];
string d8_msg2 = "You might want to say how things are done in your discipline.";
list   d8_button2 = ["Okay"];

string d9_msg1 = "Lecture scope should be adapted to what students have already learned in their classes. You might what to ask the whole class whether they have already had this point covered in their previous lectures.";
list   d9_button1 = ["Okay"];
string d9_msg2 = "You might want to asks students whether they have already had the point you are covering now in their previous lectures or not.";
list   d9_button2 = ["Okay"];

string d10_msg1 = "You might want to suggest to the only student who answers “no”  some alternative learning activities (look up in the shelf or find a handout on the table). If there are several students with similar needs you might want to put them in a separate group and provide them with some alternative activities.";
list   d10_button1 = ["Okay"];
string d10_msg2 = "You might want to provide the student with an alternative learning activity, for example, give him a handout from your inventory.";
list   d10_button2 = ["Okay"];

string d11_msg1 = "You might want to draw the topic on whiteboard, use handouts, multimedia clips you have prepared or physical objects.";
list   d11_button1 = ["Okay"];
string d11_msg2 = "Use visual means of explaining,  multimedia clips, physical objects...";
list   d11_button2 = ["Okay"];

string d12_msg1 = "To build student’s confidence you might want to give an example of an acceptable, rather than ideal performance level and suggest they do their personal best.";
list   d12_button1 = ["Okay"];
string d12_msg2 = "You might want to provide the student with an alternative learning activity, for example, give him a handout.";
list   d12_button2 = ["Okay"];

string d13_msg1 = "Sometimes learners are reluctant to give a negative evaluation if they did not understand the content or alternatively, they might feel they’ve learned everything but end up with poor grades. One of the ways to understand where your learners are at in their progress is to probe them to ask questions by introducing an upcoming quiz and promising to answer some quesitons if they ask them now";
list   d13_button1 = ["Okay"];
string d13_msg2 = "You need to understand where your learners are at.";
list   d13_button2 = ["Okay"];

string d14_msg1 = "An alternative way is to suggest coming during office hours for an additional explanation.";
list   d14_button1 = ["Okay"];
string d14_msg2 = "You might want to provide the student with an alternative learning activity, for example, give him a handout.";
list   d14_button2 = ["Okay"];

string a1_msg1 = "You were supposed to prepare examples to present to students";
list   a1_button1 = ["Okay"];
string a1_msg2 = "It's a time to present your students with a prepared example";
list   a1_button2 = ["Okay"];

string a2_msg1 = "We are revising the answers to the previous week quiz";
list   a2_button1 = ["Okay"];
string a2_msg2 = "Empty";
list   a2_button2 = ["Okay"];

string a3_msg1 = "Ask your students if they have questions";
list   a3_button1 = ["Okay"];
string a3_msg2 = "You need to know how well students understood your lecture";
list   a3_button2 = ["Okay"];

string dw1_msg1 = "Make sure students are attuned to your speed";
list   dw1_button1 = ["Okay"];
string dw1_msg2 = "Empty";
list   dw1_button2 = ["Okay"];

string dw2_msg1 = "Not all the students might understand your example. In this case give an additional explanation or choose another example.";
list   dw2_button1 = ["Okay"];
string dw2_msg2 = "Empty";
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
        } else if (msg == "-a1!"){     
            llSetTimerEvent(0);    
            state A1;    
        } else if (msg == "-a1"){     
            llSetTimerEvent(0);    
            state A1W;    
        } else if (msg == "-a2"){     
            llSetTimerEvent(0);    
            state A2;    
        }else if (msg == "-a3"){     
            llSetTimerEvent(0);    
            state A3;    
        }else if (msg == "-a3!"){     
            llSetTimerEvent(0);    
            state A3W;    
        }else if (msg == "-dw1"){     
            llSetTimerEvent(0);    
            state DW1;    
        }else if (msg == "-dw2"){     
            llSetTimerEvent(0);    
            state DW2;    
        }else if (msg == "-dw3"){     
            llSetTimerEvent(0);    
            state DW3;    
        }else if (msg == "-dw4"){     
            llSetTimerEvent(0);    
            state DW4;    
        }else if (msg == "-dw5"){     
            llSetTimerEvent(0);    
            state DW5;    
        }else if (msg == "-dw6"){     
            llSetTimerEvent(0);    
            state DW6;    
        }else if (msg == "-if"){     
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
                if (debug_level) 
                    llSay(0, "default state: received unknown feedback from dialog box, ignore");
            }             
        } 
        else if (c == button_to_facil_channel) 
        {                   // sent from the green button
            trainee = msg;  // here the green button passes the trainee ID to facil
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
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state D1W
{
    state_entry()
    {
        common_state_entry("d1w", d1_msg2, d1_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(d1_msg2, d1_button2,
                                 d1_msg2, d1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(d1_msg2, d1_button2,
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                llGiveInventory(trainee, "mastery_performance");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
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
                //llGiveInventory(trainee, "situational_interest");
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}   


state A1
{
    state_entry()
    {
        common_state_entry("a1", a1_msg1, a1_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(a1_msg1, a1_button1,
                                 a1_msg2, a1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(a1_msg1, a1_button1,
                                 a1_msg2, a1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state A1W
{
    state_entry()
    {
        common_state_entry("a1w", a1_msg2, a1_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(a1_msg2, a1_button2,
                                 a1_msg2, a1_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(a1_msg2, a1_button2,
                                 a1_msg2, a1_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state A2
{
    state_entry()
    {
        common_state_entry("a2", a2_msg1, a2_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(a2_msg1, a2_button1,
                                 a2_msg2, a2_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(a2_msg1, a2_button1,
                                 a2_msg2, a2_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state A3
{
    state_entry()
    {
        common_state_entry("a3", a3_msg1, a3_button1, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(a3_msg1, a3_button1,
                                 a3_msg2, a3_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(a3_msg1, a3_button1,
                                 a3_msg2, a3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state A3W
{
    state_entry()
    {
        common_state_entry("a3w", a3_msg2, a3_button2, dialog_box_interact_interval);
    }  

    touch_start(integer num_detected) 
    {
        dialog_dialog_with_timer(a3_msg2, a3_button2,
                                 a3_msg2, a3_button2, dialog_box_interact_interval); 
    }
  
    timer()
    {
        //internal_state = 1;
        dialog_dialog_with_timer(a3_msg2, a3_button2,
                                 a3_msg2, a3_button2, dialog_box_interact_interval);
    }
    
    listen(integer c, string n, key ID, string msg)
    {
        llSetTimerEvent(dialog_box_interact_interval);
        if (c == local_dialog_channel)
        {
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state DW1
{
    state_entry()
    {
        common_state_entry("dw1", dw1_msg1, dw1_button1, dialog_box_interact_interval);
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
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state DW2
{
    state_entry()
    {
        common_state_entry("dw2", dw2_msg1, dw2_button1, dialog_box_interact_interval);
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
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state DW3
{
    state_entry()
    {
        common_state_entry("dw3", dw3_msg1, dw3_button1, dialog_box_interact_interval);
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
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state DW4
{
    state_entry()
    {
        common_state_entry("dw4", dw4_msg1, dw4_button1, dialog_box_interact_interval);
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
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state DW5
{
    state_entry()
    {
        common_state_entry("dw5", dw5_msg1, dw5_button1, dialog_box_interact_interval);
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
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}

state DW6
{
    state_entry()
    {
        common_state_entry("dw6", dw6_msg1, dw6_button1, dialog_box_interact_interval);
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
            if (msg == "Okay") 
            {
                llSetTimerEvent(0);
                
                state Idle;
            }    
        } else process_common_listen_port_msg (c, n, ID, msg);         
    }    
}



