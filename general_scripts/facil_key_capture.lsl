//  CREATED BY: Raymond Naglieri on 3/29/18
// DESCRIPTION: Store and send the facilitator's key. 
// 		 NOTES: 
//		   LOG: 
//

key facil_key = NULL_KEY;
key facil_candidate = NULL_KEY;
string passphrase = "pass";

integer local_dialog_channel = -1000;
integer facil_capture_channel = -33157;


command_interface(string command)
{
	if(command == "-reset") // complete script reset
	{
		llSay(0, "Resetting...");
		llResetScript();
	}
	else if(command == "-print") // print the current facilitator
	{
		llSay(0, llKey2Name(facil_key));
	}
}

default
{
	state_entry()
	{
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
		llListen(local_dialog_channel , "", NULL_KEY, "");
	}

	touch_start(integer num_detected)
	{
		llTextBox(facil_candidate, "Try again. Please enter the passphrase. ", local_dialog_channel);
	}

	listen(integer channel, string name, key id, string message)
	{
		if (message == passphrase)
		{
			facil_key = facil_candidate;
			llDialog(facil_key, llKey2Name(facil_key) + ", Authenticated.\n" + llKey2Name(facil_key) + " is the active facilitator." , ["Okay"], local_dialog_channel);
			llSay(facil_capture_channel, facil_key);
			state Locked;
		}
		else 
			llTextBox(facil_candidate, "Try again. Please enter the passphrase. ", local_dialog_channel);
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