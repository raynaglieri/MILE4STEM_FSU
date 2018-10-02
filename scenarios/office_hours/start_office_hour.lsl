//  CREATED BY: Raymond Naglieri on 06/01/2018 
// DESCRIPTION: Start scenario Control Script. 
//         LOG: 06/22/2018 - Updated for Office Hours.
//              06/22/2018 - added scenario offset. 
//              08/13/2018 - Added Scenario Lock support
//
key trainee= NULL_KEY;
key facilitator = NULL_KEY;
vector COLOR_GREEN = <0.0, 1.0, 0.0>;
vector COLOR_RED = <1.0, 0.0, 0.0>;
float  OPAQUE = 1.0;



// constants used acrosss all scripts
integer scenario_offset = 100000;
integer facil_beg_guide_channel = 10104;
integer green_button_channel = 11500;
integer facil_capture_control_channel = -33156; 
integer facil_key_channel = -33157;  // input from this channel contains the faciltators key
integer button_to_facil_channel = 11501; // chat channel from green button to facil
integer button_to_npc_channel = -35145;  // button to npc_channel
integer local_dialog_channel = 11003;    // this number should be different for 
                                         // different scripts 

set_offset(){
    green_button_channel = 11500 + scenario_offset;
    facil_key_channel = -33157 + scenario_offset;  
    button_to_facil_channel = 11501 + scenario_offset; 
    button_to_npc_channel = -35145 + scenario_offset;  
    local_dialog_channel = 11003 + scenario_offset;
}

display_floating_message(){
    if(facilitator == NULL_KEY)
        llSetText("Press to begin the scenario: Faciltator not registered.", <1,0,0>, 1); 
    else 
        llSetText("Press to begin the scenario: Faciltator registered!", <0,1,0>, 1);
}

                                         
default{    
    state_entry(){  
        set_offset();
        display_floating_message();
        llListen(local_dialog_channel, "", NULL_KEY, "");
        llListen(facil_key_channel, "", NULL_KEY, "");
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
                llSay(0, key_package);
                llSay(button_to_facil_channel, key_package);
                llShout(green_button_channel, trainee);
                display_floating_message();
                llSay(button_to_npc_channel, trainee);
            }
        } else if(c == facil_key_channel) {
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
        llListen(facil_key_channel, "", NULL_KEY, "");
    }  

    touch_start(integer num_detected){
         llDialog(llDetectedKey(0), "Scenario locked. If you are the facilitator, you can unlock this scenario using the facilitator tool.", ["Okay"], local_dialog_channel);
    } 

     listen(integer c, string n, key ID, string msg){
         if(c == facil_key_channel) {
            list command_package = llParseString2List(msg, [":"], []);  
            if (llList2String(command_package, 0) == "unlock")
                state default;  
            else if (llList2String(command_package, 0) == "reset")
                llResetScript();  
            display_floating_message();
        }
     }
}