//  CREATED BY: Raymond Naglieri on 3/21/18
// DESCRIPTION: Hand out notecards from a given set. 
// 		 NOTES: 1. delete_all_other_contents provided by: http://wiki.secondlife.com/wiki/LlRemoveInventory, modified to exclude ORDER_FILE
//				2. ORDER_FILE notecard must be placed in prim before running	
//		   LOG: add empty ORDER_FILE handling
//

integer notecard_command_channel = 88000;

string ORDER_FILE = "DECK_ORDER_FILE";
integer eof_flag = 0;
integer line = 0;

list fixed_notecard_deck = [];
list current_deck = [];
integer deck_position = 0;

key notecard_insert_id = NULL_KEY;
string notecard_name = "";


delete_all_other_contents()
{
    string thisScript = llGetScriptName();
    string inventoryItemName;
 
    integer index = llGetInventoryNumber(INVENTORY_ALL);
    while (index)
    {
        --index;        
 
        inventoryItemName = llGetInventoryName(INVENTORY_ALL, index);
 
        if (inventoryItemName != thisScript || inventoryItemName != ORDER_FILE)   
            llRemoveInventory(inventoryItemName);     
    }
}
 
shuffle_card()
{
	notecard_insert_id = llGetNotecardLine(ORDER_FILE, line);
}

draw_card(key user)
{
	llSay(0,  (string)llGetListLength(fixed_notecard_deck));
	llSay(0,  (string)deck_position);
	if(deck_position < llGetListLength(fixed_notecard_deck))
	{
		llGiveInventory(user, llList2String(fixed_notecard_deck, deck_position));
		++deck_position;
	}
	else
	{
		llSay(0, "THE DECK IS OUT OF CARDS. -reshuffle THE DECK OR ADD -update THE DECK WITH MORE CARDS.");
	}
}

command_interface(string command)
{
	if(command == "-reset") // complete script reset
	{
		delete_all_other_contents();
		llResetScript();
	}
	else if(command == "-reshuffle") // restore current deck to original state
	{
		deck_position = 0;
	}
	else if(command == "-update") // update the deck contents
	{
		line = 0;
		deck_position = 0;
		fixed_notecard_deck = [];
		shuffle_card();
	}
}

default
{
	state_entry()
	{
		llSay(0, "Enter.");
		llListen(notecard_command_channel, "", NULL_KEY, "");
		shuffle_card();
	}

	touch_start(integer num_detected)
	{
		draw_card(llDetectedKey(0));	
	}

 	dataserver(key query_id, string sdata)
    {
    	llSay(0, "Query.");
    	llSay(0, sdata);
        if(query_id == notecard_insert_id)
        {
            if(sdata == EOF)
            {
				llSay(0, "EOF");
            }
			else
			{
				fixed_notecard_deck += sdata;
				notecard_insert_id = llGetNotecardLine(ORDER_FILE, ++line);
			}	
        }
    }

	listen(integer channel, string name, key id, string message)
	{
		llSay(0, "Command.");
		command_interface(message);
	}
}