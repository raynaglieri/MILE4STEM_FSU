// Created on 3/29/2018 By Raymond Naglieri.
// Description: Handles logic for actions driven by NPC interaction.

integer scenario_base_channel = 41000;
integer scenario_first_option_channel = 41001;
integer scenario_second_option_channel = 41002;
integer scenario_recieve_base_channel = 42000;

integer signal_me = 0; // NPC to signal


default
{
	state_entry()
	{
		llListen(scenario_first_option_channel, "", NULL_KEY, "");
		llListen(scenario_second_option_channel, "", NULL_KEY, "");
	}

	listen(integer channel, string name, key id, string message)
	{
		list reciever_and_sender = llParseString2List(message, [":"],[]);
		signal_me = llList2Integer(reciever_and_sender,1);

		if(channel == scenario_first_option_channel)
			llSay(scenario_recieve_base_channel+llList2Integer(reciever_and_sender,0),"1");
		else
			llSay(scenario_recieve_base_channel+llList2Integer(reciever_and_sender,0),"2");

		state SendSignal;
	}
}

state SendSignal
{
	state_entry()
	{
		llListen(scenario_base_channel, "", NULL_KEY, "");
	}

	listen(integer channel, string name, key id, string message)
	{
		if(message == "@done")
		{
			llSay(scenario_recieve_base_channel+signal_me, "@signal_complete");
			state default;
		}
		else if(message == "-reset")
		{
			llResetScript();
		}

	}
}