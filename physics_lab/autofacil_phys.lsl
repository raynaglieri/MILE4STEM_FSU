// Created By: Raymond Naglieri 2/2/2018
// Decription: Auto executes a series of commands when given a specific command. 
// Log:
// 2/4/2018 - Template completed, added all npc actions. Fixed msg to parse_msg. 

integer auto_facil_control_channel = 10102;
integer backdoor_channel=20001;
list active_series; 
integer  index = 0;
list series_a = ["-a_npcmeterbroken" , "-a_npclookatmeter"];
list series_b = ["-a_npcmeasurecurrent" , "-a_npcmeasurevoltage", "-a_npccorrectresvoltage"];
list series_c = ["-a_npccorrectcurrent"];
list series_d = ["-a_npcdifferentcurrent" , "-a_npcdifferentcurrentt2", "-a_npcnegativevoltage", "-a_npcrighthandside"];
list series_e = ["-a_npcoutoftime"];



command_parser(string msg)
{
	string parse_msg = llToLower(msg); 
	if(parse_msg == "-ser_a")
	{
		llSay(0,"series_a");
		active_series = series_a;
	} 
	else if (parse_msg == "-ser_b")
	{
		llSay(0,"series_b");
		active_series = series_b;
	}
	else if (parse_msg == "-ser_c")
	{
		llSay(0,"series_c");
		active_series = series_c;
	}
	else if (parse_msg == "-ser_d")
	{
		llSay(0,"series_d");
		active_series = series_d;
	}
	else if (parse_msg == "-ser_e")
	{
		llSay(0,"series_e");
		active_series = series_e;
	}
	else if(parse_msg == "-reset")
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