// change history:
//   September 2017: created by Raymond Naglieri in September 2017 to implement Zhaihuan's 
//      chemistry flowchart, this file provides backdoor control to reset the session state
//      kill all NPC, etc
//   10/14/2017, fixed the recursive message issue. -XY
//   10/21/2017, removed detailed state change, only support global reset at this time.
//               more function can be added here for any purposes.
//   10/23/2017, added reset_lab_items() function in -reset
//   10/27/2017, added calls to start a fire in npc_s3 and spill acid in npc_s2 using 
//               interact_with_lab_channel 
// 
integer num_npc = 8;
integer base_npc_control_channel = 31000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer interact_with_lab_channel = 101;

reset_lab_items()
{
    llShout(interact_with_lab_channel, "-reset");
}    

reset_to_start() {
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-reset");
    llSay(facil_control_channel, "-reset");
} 

npc_s1() {
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-s1");
}

npc_s2() {
    integer i;
    llSay(interact_with_lab_channel, "-spill");
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-s2");
}

npc_s3() {
    integer i;
    llSay(interact_with_lab_channel, "-fire");
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-s3");
}

npc_s3_leave(){
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-s3leave");    

}


default{
    
    state_entry(){
        llListen(backdoor_channel, "", NULL_KEY, "");
    }   
    
    listen(integer channel, string name, key id, string message){
        if (message == "-reset"){
            reset_lab_items();
            reset_to_start();
        } else if (message == "-npcs1"){
            npc_s1();
        } else if (message == "-npcs2"){
            npc_s2();
        } else if (message == "-npcs3"){
            npc_s3();
        } else if(message == "-npcs3left"){

            npc_s3_leave();

        }
    }
} 
