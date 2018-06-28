//  CREATED BY: Raymond Naglieri on 06/01/2018 
// DESCRIPTION: Start Lab Control Script. 
//         LOG: 06/22/2018 - Updated for Office Hours.
//              06/22/2018 - added scenario offset. 
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
integer facil_capture_channel = -33157;  // input from this channel contains the faciltators key
integer button_to_facil_channel = 11501; // chat channel from green button to facil
integer button_to_npc_channel = -35145;  // button to npc_channel
integer local_dialog_channel = 11003;    // this number should be different for 
                                         // different scripts 

set_offset()
{
    green_button_channel = 11500 + scenario_offset;
    facil_capture_channel = -33157 + scenario_offset;  
    button_to_facil_channel = 11501 + scenario_offset; 
    button_to_npc_channel = -35145 + scenario_offset;  
    local_dialog_channel = 11003 + scenario_offset;
}
                                         
default{    
    state_entry(){  
        set_offset();
        llSetText("Press to begin Office Hours: facil not set", COLOR_RED, OPAQUE); 
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
                llSay(0, key_package);
                llSay(button_to_facil_channel, key_package);
                llShout(green_button_channel, trainee);
                if(facilitator == NULL_KEY)
                    llSetText("Press to begin Office Hours: facil not set", <1,0,0>, 1); 
                else 
                    llSetText("Press to begin Office Hours: facil set", <0,1,0>, 0);

                llSay(button_to_npc_channel, trainee);
            }
        }
        else if(c == facil_capture_channel)
        {
            facilitator = msg;
            if(facilitator == NULL_KEY)
                llSetText("Press to begin Office Hours: facil not set", COLOR_RED, OPAQUE); 
            else 
                llSetText("Press to begin Office Hours: facil set", COLOR_GREEN, OPAQUE);

        }
    } 
}