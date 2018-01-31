
string slide_texture;
integer MAX_SLIDE_COUNT = 5; 
integer board_control_channel = 36000;

display_slide(integer slide_number)
{
	if(slide_number >= 0 && slide_number <= MAX_SLIDE_COUNT)
	{
		llGetInventoryName(INVENTORY_TEXTURE, slide_number);
		llSetTexture(slide_texture, ALL_SIDES);		
		return;
	}		
}

default
{
	state_entry()
	{
		llListen(board_control_channel, "", NULL_KEY, "");
	}

	listen(integer c, string n, key ID, string msg)
	{
		display_slide((integer)msg);
	}
	
}
