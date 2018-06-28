//  CREATED BY: Raymond Naglieri on 3/29/18
// DESCRIPTION: Store and send the facilitator's key. 
//         LOG: 05/31/2018 - Added Authentication timeout and reset functionality within the Authenticate State.
//              06/26/2018 - Added scenario offset
//


key facil_key = NULL_KEY;
key facil_candidate = NULL_KEY;
string passphrase = "pass";

integer scenario_offset = 100000;
integer local_dialog_channel = -1000;
integer facil_capture_channel = -33156;
integer facil_key_channel = -33157;

integer authentication_timeout = 0;
integer authentication_reminder = 20;


command_interface(string command)
{
    if(command == "-reset") // complete script reset
    {
        llSay(facil_key_channel, NULL_KEY);
        llResetScript();
    }
    else if(command == "-print") // print the current facilitator
    {
        llSay(0, llKey2Name(facil_key));
    }
}

set_offset()
{
    local_dialog_channel = -1000 + scenario_offset;
    facil_capture_channel = -33156 + scenario_offset;
    facil_key_channel = -33157 + scenario_offset; 
}

default
{
    state_entry()
    {
        set_offset();
        llListen(local_dialog_channel , "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    {
        facil_candidate = llDetectedKey(0);
        llTextBox(facil_candidate, "Please enter the passphrase." , local_dialog_channel);
        state Authenticate;
    }
}

state Authenticate
{
    state_entry()
    {
        llSetTimerEvent(authentication_reminder);
        llListen(facil_capture_channel , "", NULL_KEY, "");
        llListen(local_dialog_channel , "", NULL_KEY, "");
    }

    timer()
    {
        authentication_timeout = 1;
        llDialog(facil_candidate, "User Authentication timeout. Returning to Idle.", ["Okay"], local_dialog_channel);
    }

    touch_start(integer num_detected)
    {
        llTextBox(facil_candidate, "Try again. Please enter the passphrase. ", local_dialog_channel);
    }

    listen(integer channel, string name, key id, string message)
    {
        if(channel == local_dialog_channel)
        {   
            if(!authentication_timeout)
            {
                if (message == passphrase)
                {
                    facil_key = facil_candidate;
                    llDialog(facil_key, llKey2Name(facil_key) + ", Authenticated.\n" + llKey2Name(facil_key) + " is the active facilitator." , ["Okay"], local_dialog_channel);
                    llSay(facil_key_channel, facil_key);
                    state Locked;
                }
                else 
                    llTextBox(facil_candidate, "Try again. Please enter the passphrase. ", local_dialog_channel);
            }
            else 
               llResetScript();    
        }
        else if (channel == facil_capture_channel)
        {
            command_interface(message);
        }    
    }
}

state Locked
{
    state_entry()
    {
        llListen(facil_capture_channel, "", NULL_KEY, "");
    }

    touch_start(integer num_detected)
    {
        llDialog(llDetectedKey(0), "Scenario in progress. Reset the scenario to change the facilitator.", ["Okay"], local_dialog_channel);
    }

    listen(integer channel, string name, key id, string message)
    {
        command_interface(message);
    }    
}