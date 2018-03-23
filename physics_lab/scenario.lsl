// Created on 3/29/2018 By Raymond Naglieri.
// Description: Handles logic for scenario specific NPC actions

integer scenario_action_base_channel = 51000;


       

action_settings(string action, integer directive)
{
    if(action == "A")
    {
        if(directive == "1" && myid == 0)
        {
            currentquestion = "Hi, I think I need your help. The digital multimeter is broken.";
            keywords_current = keywords_multimeter;
            correct_response = "Yes, I misconnected the wires.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds, 7);
            set_ask_settings(1, 0, [], 0, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        } 
        else if (directive == "2" && myid == 5)
        {
            currentquestion = "Can you take a look at my digital multimeter? I might have broken it.";
            keywords_current = keywords_multimeter;
            correct_response = "Yes, I probably messed up the wires";
            gen_response = "I've done that!";
            say_this = llList2String(npc_lab_sounds, 2);
            set_ask_settings(1, 0, [], 0, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";

        } 
        else if(directive == "3" && myid == 1) 
        {
            currentquestion = "I have measured the current between the first and the second resistor and between the second and the third resistor and it's always the same. Are the current readings supposed to be the same?";
            keywords_current = keywords_series;
            correct_response = "Thanks.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds,4);
            set_ask_settings(1, 1, [3], 1, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        }
        else if(directive == "4" && myid == 4) 
        {
            currentquestion = "Why am I getting the same voltage reading across each of the resistors?";
            keywords_current = keywords_resistors;
            correct_response = "Thanks.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds, 6);
            set_ask_settings(1, 1, [6], 1, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        }
        else if (directive == "5" && myid == 2)
        {
            currentquestion = "I have measured the voltage on the second resistor and it's 1.67 V. How do I know this is correct?";
            keywords_current = ["yes", "no"];
            correct_response = "Thanks.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds, 3);
            set_ask_settings(1, 0, [], 0, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        } 
        else if (directive == "6" && myid == 7)
        {
            currentquestion = "I have measured current on the first resistor and it's 0.05 A.  Is it correct?";
            keywords_current = ["yes" , "no"];
            correct_response = "Thanks.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds, 6);
            set_ask_settings(1, 0, [], 0, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        }  
        else if (directive == "7" && myid == 2)
        {
            currentquestion = "How do I connect the multimeter to measure the voltage across each resistor?";
            keywords_current = ["connecting the voltmeter"]; 
            correct_response = "Thanks.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds, 3);
            set_ask_settings(1, 0, [], 0, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        }  
        else if (directive == "8" && myid == 7)
        {
            currentquestion = "Can you explain to me how to connect the digital multimeter to measure the current passing through each of the resistors in the parallel circuit?";
            keywords_current = ["break the circuit"]; 
            correct_response = "Thanks.";
            gen_response = "I've tried that!";
            say_this = llList2String(npc_lab_sounds, 6);
            set_ask_settings(1, 0, [], 0, 1, 0, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        } 
        else if(directive == "11" && myid == 2) 
        {
            currentquestion = "We are still working on our report. Could you give us some extra time?";
            keywords_current = ["yes"];
            correct_response = "Great Thank you so much!";
            gen_response = "Alright, we'll finish as much as we can.";
            say_this = llList2String(npc_lab_sounds, 5);
            set_ask_settings(1, 0, [], 3, 1, 1, 1);
            // speak_with_question = 1;
            // currentsound = "You_are_talking_too_fast";
        }
    }
    else if(action == "R")
    {

    }    
}



default
{
    state_entry()
    {
        
    }

    
              
}          