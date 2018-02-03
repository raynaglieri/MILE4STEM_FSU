// Created By: Raymond Naglieri 2/2/2018
// Decription: Auto executes a series of commands when given a specific command. 
// Log:
// 2/3/2018 - 

integer auto_facil_control_channel = 10102;
integer backdoor_channel=20001;
list active_series; 
integer  index = 0;
list series_a = ["-a_npcmeterbroken" , "-a_npclookatmeter", "-a_npcmeasurecurrent"];

command_parser(string msg)
{
	string parse_msg = llToLower(msg); 
	if(msg == "-ser_a")
	{
		llSay(0,"series_a");
		active_series = series_a;
	} 
	else if (msg == "-ser_b")
	{
		llSay(0,"series_b");
		active_series = series_a;
	}
	else if(msg == "-reset")
	{
		llSay(0, "Reset");
		llResetScript();
	}

	if(active_series != [])
	{
		state ExecuteCommands;
	}

	state default;		
}

default
{
	state_entry()
	{
		llListen(auto_facil_control_channel, "", NULL_KEY, "");
	}

	listen(integer c, string n, key ID, string msg)
	{
		command_parser(msg);
	}
}

state ExecuteCommands
{
	state_entry()
	{
		index = 0;
		llListen(auto_facil_control_channel, "", NULL_KEY, "");
		llSay(backdoor_channel, llList2String(active_series, index));
	}

	listen(integer c, string n, key ID, string msg)
	{
		if(msg == "-ac")
		{
			index++;
			if(index < llGetListLength(active_series))
			{
				llSay(backdoor_channel, llList2String(active_series, index));
			}
			else
			{
				state default;
			}	
		}	
		else 
			command_parser(msg);
	}
}