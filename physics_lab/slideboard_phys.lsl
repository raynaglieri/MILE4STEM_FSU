// Created on 1/29/2018 By Raymond Naglieri.
// Description: Takes commands from board_control_channel and updates textures on attatched prim.
// 03/03/2018 - added MYID for individual board control.
// 05/21/2018 - added touch functionality for changing slides. 
string slide_texture;
integer MAX_SLIDE_COUNT = 2;
integer curr_slide = 0; 
integer board_control_channel = 36000;
integer MYID = 0; 
float CYCLE_INTER = 5.0;

next_slide()
{
	++curr_slide;
	if(curr_slide >= MAX_SLIDE_COUNT)
		curr_slide = 0;
	display_slide(curr_slide);
}

command_interface(string command)
{
	if(command == "-cycle")
	{
		state Cycle;
	}
	else if(command == "-exit_cycle")
	{
		state default;
	}
	else
		display_slide((integer)command);
}

display_slide(integer slide_number)
{
	if(slide_number >= 0 && slide_number <= MAX_SLIDE_COUNT)
	{
		slide_texture = llGetInventoryName(INVENTORY_TEXTURE, slide_number);
		llSetTexture(slide_texture, ALL_SIDES);		
		return;
	}		
}

default
{
	state_entry()
	{
		llListen(board_control_channel + MYID, "", NULL_KEY, "");
	}

	touch_start(integer num_detected)
	{
		next_slide();
	}

	listen(integer channel, string name, key id, string message)
	{
		command_interface(message);
	}	
}

state Cycle
{
	state_entry()
	{
		llListen(board_control_channel + MYID, "", NULL_KEY, "");	
		llSetTimerEvent(CYCLE_INTER);
	}

	timer()
	{
		next_slide();
	}

	listen(integer channel, string name, key id, string message)
	{
		command_interface(message);
	}
}
