// Created on 1/29/2017 By Raymond Naglieri.
// Description: Takes commands from board_control_channel and updates textures on attatched prim.
// 3/3/18 added MYID for individual board control.
string slide_texture;
integer MAX_SLIDE_COUNT = 5; 
integer board_control_channel = 36000;
integer MYID = 0; 

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

	listen(integer c, string n, key ID, string msg)
	{
		display_slide((integer)msg);
	}
	
}
