// Created on 1/29/2017 By Raymond Naglieri.
// Description: update prim texture to nth inventory via the board_control_channel. Click on prim to remove all textures from inventory and clear the set one.
// 2/20/18: Updated for training arena. 
//		  : Added delete_all_other_contents function provided by, http://wiki.secondlife.com/wiki/LlRemoveInventory . This will clear the prims given textures if the prim is clicked on.
// 2/22/18: Added drag from inventory support for all useres. 
//		  : Partially implemented displaying the most current provided texture. 
// 3/02/18: Completed displaying most recent texture functionality. 
//
string slide_texture;
integer MAX_SLIDE_COUNT = 5; 
string last_updated = "NULL";
string inventoryItemName;
integer board_control_channel = 36000;

// deletes all other contents of any type except the script itself
delete_all_other_contents()
{
    string thisScript = llGetScriptName();
    string inventoryItemName;
 
    integer index = llGetInventoryNumber(INVENTORY_ALL);
    while (index)
    {
        --index;        // (faster than index--;)
 
        inventoryItemName = llGetInventoryName(INVENTORY_ALL, index);
 
        if (inventoryItemName != thisScript)   
            llRemoveInventory(inventoryItemName);     
    }
}

display_slide(integer slide_number)
{
	if(llGetInventoryNumber(INVENTORY_ALL) > 1)
	{
		if(slide_number >= 0 && slide_number <= MAX_SLIDE_COUNT)
		{
			slide_texture = llGetInventoryName(INVENTORY_TEXTURE, slide_number);
			if(slide_texture != last_updated)
			{
				last_updated = slide_texture;
				llSetTexture(slide_texture, ALL_SIDES);		
				llRemoveInventory(slide_texture);
			}
			
		}	
	}		
	return;
}

default
{
	state_entry()
	{
		llAllowInventoryDrop(TRUE);
		llListen(board_control_channel, "", NULL_KEY, "");
	}

	touch_start(integer num_detected) // touching the prim will remove textures. 
	{
		delete_all_other_contents();
		llSetTexture(TEXTURE_BLANK, ALL_SIDES);
	}

	changed(integer change)
	{
	    if (change & CHANGED_ALLOWED_DROP)
	    	display_slide(0);
	   
	    else if(change & CHANGED_INVENTORY)  
        	display_slide(0);     
	}

	listen(integer c, string n, key ID, string msg)
	{
		display_slide((integer)msg);
	}
}
