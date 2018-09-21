// change history:
//   September 2017: created by Raymond Naglieri in September 2017 to implement Zhaihuan's 
//      chemistry flowchart
//   10/14/2017, fixed channel numbering issue  -- XY
//   10/14/2017, added a dialog box to confirm the identity of the trainee -- XY
//   10/28/2017, clean up unused variables -- XY
//   

key trainee= NULL_KEY;
key facilitator = NULL_KEY;
vector COLOR_GREEN = <0.0, 1.0, 0.0>;
vector COLOR_RED = <1.0, 0.0, 0.0>;
float  OPAQUE = 1.0;



// constants used acrosss all scripts
integer facil_capture_channel = -33157;  // input from this channel contains the faciltators key
integer button_to_facil_channel = 11500; // chat channel from green button to facil
integer button_to_npc_channel = -35145;  // button to npc_channel
integer local_dialog_channel = 11003;    // this number should be different for 
                                        // different scripts 
display_floating_message(){
    if(facilitator == NULL_KEY)
        llSetText("Press to begin the scenario: Faciltator not registered.", <1,0,0>, 1); 
    else 
        llSetText("Press to begin the scenario: Faciltator registered!", <0,1,0>, 1);
}                                      
default{    
    state_entry(){  
        llSetText("Press to begin lecture: facil not set", COLOR_RED, OPAQUE); 
        llListen(local_dialog_channel, "", NULL_KEY, "");
        llListen(facil_capture_channel, "", NULL_KEY, "");
    }   
        
    touch_start(integer num_detected){
        key kk;
        kk = llDetectedKey(0);
        if (trainee == NULL_KEY)
            llDialog(kk, "Are you the TA trainee? Are you sure you want to start a session?", 
            ["Yes", "No"], local_dialog_channel);        
        else llDialog(kk, "Are you the TA trainee? Are you sure you want to start a session? The session must be in the initial state (reset with the backdoor) before you can start a new session.", 
                 ["Yes", "No" ] , 
                 local_dialog_channel);
    }
    
    listen(integer c, string n, key ID, string msg){
        if (c == local_dialog_channel) {
            if (msg == "Yes") { 
                trainee = ID;
                string key_package = trainee + ":" + facilitator; 
               // llSay(0, key_package);
                llSay(button_to_facil_channel, key_package);
                display_floating_message();
                llSay(button_to_npc_channel, key_package);
            }
        }
        else if(c == facil_capture_channel)
        {
            list command_package = llParseString2List(msg, [":"], []);
            if (llList2String(command_package, 0) == "key")  
                facilitator = llList2String(command_package, 1);
            else if (llList2String(command_package, 0) == "lock")
                state Locked; 
            else if (llList2String(command_package, 0) == "reset")
                llResetScript();    
            display_floating_message();
        }
    } 
}

state Locked{

    state_entry(){  
        llSetText("Locked", COLOR_RED, OPAQUE); 
        llListen(facil_capture_channel, "", NULL_KEY, "");
    }  

    touch_start(integer num_detected){
         llDialog(llDetectedKey(0), "Scenario locked. If you are the facilitator, you can unlock this scenario using the facilitator tool.", ["Okay"], local_dialog_channel);
    } 

     listen(integer c, string n, key ID, string msg){
         if(c == facil_capture_channel) {
            list command_package = llParseString2List(msg, [":"], []);  
            if (llList2String(command_package, 0) == "unlock")
                state default;  
            else if (llList2String(command_package, 0) == "reset")
                llResetScript();  
            display_floating_message();
        }
     }
}