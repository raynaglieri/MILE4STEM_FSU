//  CREATED BY: Raymond Naglieri on 08/31/18
// DESCRIPTION: Store and send user responses to the faciltator. 
//       NOTES: Sample call:- /17888 scribe-Question::Response
//  CHANGE LOG:
//

key facilitator = NULL_KEY;

integer scenario_offset = 0;
integer facil_scribe_channel = 17888;

integer debug = 0;

list global_content = [];
integer entry_count = 0;

string  invalid_msg = "invalid input";

set_offset(){
	facil_scribe_channel = 17888 + scenario_offset;
}

scribe(string passed_content){
	++entry_count;
	list scribe_package = llParseString2List(passed_content, ["::"], []);
	list format_content = ["**_Begin Data Entry " + entry_count + "_**"];
	format_content += [llList2String(scribe_package, 0) + ""];
	format_content += [llList2String(scribe_package, 1) + ""];
	format_content += ["**_End Data Entry "+ entry_count + "_**\n"];
	global_content +=format_content;
}

write_out(){
	osMakeNotecard(llGetTimestamp(), global_content);
}

command_interface(string command){
	list command_package = llParseString2List(command, ["-"], []);
	if(llList2String(command_package, 0)=="key")
		facilitator = llList2String(command_package, 1);
	else if(llList2String(command_package, 0) == "scribe")	
		scribe(llList2String(command_package, 1));
	else if(llList2String(command_package, 0) == "reset"){
		write_out();	
		llResetScript();
	} else llSay(0, invalid_msg);
}

default{
	state_entry(){
		set_offset();
		llListen(facil_scribe_channel, "", NULL_KEY, "");
	}

	listen(integer channel, string name, key id, string message){
		if(channel == facil_scribe_channel) {
			command_interface(message);
		}
	}
}