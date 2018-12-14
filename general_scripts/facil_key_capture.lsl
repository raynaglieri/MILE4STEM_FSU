//  CREATED BY: Raymond Naglieri on 3/29/18
// DESCRIPTION: Store and send the facilitator's key. 
//         LOG: 05/31/2018 - Added Authentication timeout and reset functionality within the Authenticate State.
//              06/26/2018 - Added scenario offset
//              08/13/2018 - Added Scenario Lock support
//


key facil_key = NULL_KEY;
key facil_candidate = NULL_KEY;
string passphrase = "pass";

list facil_menu_options = ["Lock", "Unlock"];

integer scenario_offset = 0;
integer local_dialog_channel = -1000;
integer facil_capture_control_channel = -33156;
integer facil_key_channel = -33157;
integer backdoor_channel=20001;


integer authentication_timeout = 0;
integer authentication_reminder = 20;



set_offset(){
    local_dialog_channel = -1000 + scenario_offset;
    facil_capture_control_channel = -33156 + scenario_offset;
    facil_key_channel = -33157 + scenario_offset; 
    backdoor_channel = 20001 + scenario_offset;
}

command_interface(string command){
    if(command == "-reset") {
        llSay(facil_key_channel, "reset:NULL_KEY");
        llResetScript();
    }else if(command == "-print"){
        llSay(0, llKey2Name(facil_key));
    }
}

gen_facil_msg(){
    llDialog(facil_key, "Faciltator:" + llKey2Name(facil_key) + "\nReset the scenario to change the facilitator.\nSelect an option:", facil_menu_options, local_dialog_channel);
}

default
{
    state_entry(){
        set_offset();
        llListen(local_dialog_channel , "", NULL_KEY, "");
    }

    touch_start(integer num_detected){
        facil_candidate = llDetectedKey(0);
        llTextBox(facil_candidate, "Please enter the passphrase.", local_dialog_channel);
        state Authenticate;
    }
}

state Authenticate
{
    state_entry(){
        llSetTimerEvent(authentication_reminder);
        llListen(facil_capture_control_channel , "", NULL_KEY, "");
        llListen(local_dialog_channel , "", NULL_KEY, "");
    }

    timer(){
        authentication_timeout = 1;
        llDialog(facil_candidate, "User Authentication timeout. Returning to Idle.", ["Okay"], local_dialog_channel);
    }

    touch_start(integer num_detected){
        llTextBox(facil_candidate, "Try again. Please enter the passphrase. ", local_dialog_channel);
    }

    listen(integer channel, string name, key id, string message){
        if(channel == local_dialog_channel){   
            if(!authentication_timeout){
                if (message == passphrase){
                    facil_key = facil_candidate;
                    //llDialog(facil_key, llKey2Name(facil_key) + ", Authenticated.\n" + llKey2Name(facil_key) + " is the active facilitator." , ["Okay"], local_dialog_channel);
                    llSay(facil_key_channel, "key:"+facil_key );
                    state FacilitatorControl;
                }else llTextBox(facil_candidate, "Try again. Please enter the passphrase. ", local_dialog_channel);
            }else llResetScript();    
        }else if (channel == facil_capture_control_channel){
            command_interface(message);
        }    
    }
}


state FacilitatorControl{
    state_entry(){
        gen_facil_msg();
        llListen(facil_capture_control_channel, "", NULL_KEY, "");
        llListen(local_dialog_channel, "", NULL_KEY, "");
    }

    touch_start(integer num_detected){
        if(llDetectedKey(0) == facil_key)
            gen_facil_msg();
    }

    listen(integer channel, string name, key id, string message){
        if(channel == facil_capture_control_channel){
            command_interface(message);
        }else{
            if(message == "Lock")
                llSay(facil_key_channel, "lock:-");
            else if(message == "Unlock")
                llSay(facil_key_channel, "unlock:-");
        }    
    } 
}
