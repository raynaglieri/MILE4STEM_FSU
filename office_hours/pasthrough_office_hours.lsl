//  CREATED BY: Raymond Naglieri on 06/01/2018 
// DESCRIPTION: Command passthrough for faciltators and NPC signals. 
//         LOG: 06/22/2018 - Updated for Office Hours

integer num_npc = 8;
integer scenario_offset = 100000;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_beg_guide_channel = 10106;
integer facil_capture_channel = -33156;
integer board_control_channel = 36000;
integer interact_with_lab_channel = 101;

string delayed_command = "NULL";
integer dc_is_action = 0;
integer dc_npc_offset = 0;

interrupt()
{
    delayed_command = "NULL";
    llSetTimerEvent(0.0);
    
    // integer i;
    // for (i=0; i<num_npc; i++)
    //     llSay(base_npc_control_channel+i, "-interrupt");
    //llSleep(2.0); 
}  

reset_lab_items()
{
    llShout(interact_with_lab_channel, "-reset");
}    


reset_to_start() 
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-reset");
    llSay(facil_control_channel, "-reset");  
    llSay(facil_capture_channel, "-reset"); 
    llSay(facil_beg_guide_channel, "-reset");  
    reset_lab_items();

} 

multi_command(string command, list npcs)
{
    integer i;
    for (i=0; i<num_npc; i++)
    {
        if(~llListFindList(npcs, (list)i))
            llSay(base_npc_control_channel+i, command);
    }
}

set_offset()
{
    base_npc_control_channel = 31000 + scenario_offset;
    npc_para_control_base_channel = 32000 + scenario_offset;
    npc_action_control_base_channel = 33000 + scenario_offset;
    backdoor_channel=20001 + scenario_offset;
    facil_control_channel = 10101 + scenario_offset;
    facil_beg_guide_channel = 10106 + scenario_offset;
    facil_capture_channel = -33156 + scenario_offset;
    board_control_channel = 36000 + scenario_offset;
    interact_with_lab_channel = 101 + scenario_offset;
}

default
{
    state_entry()
    {
        set_offset();
        llListen(backdoor_channel, "", NULL_KEY, "");
    }  

    timer()
    {
        if(dc_is_action)
            llSay(npc_action_control_base_channel+dc_npc_offset, delayed_command);
        else    
            llSay(base_npc_control_channel+dc_npc_offset, delayed_command);
        llSetTimerEvent(0.0);    
    } 
    
    listen(integer channel, string name, key id, string message)
    {
        if (message == "-reset")
        {
            reset_to_start();
        }  
        else if(message == "-2default")
        {
            interrupt();
            multi_command("-goto:default", [0,1,2,3,4,5,6,7]);
        }
        else if(message == "-ad_begin")
        {
            interrupt();
            llSay(base_npc_control_channel, "entry_s:1");
            llSay(base_npc_control_channel+1, "entry_s:1");
            llSay(base_npc_control_channel+2, "entry_s:1");
            llSay(base_npc_control_channel+3, "entry_s:1");
            llSay(base_npc_control_channel+4, "entry_s:1");
            llSay(base_npc_control_channel+5, "entry_s:1");
            llSay(facil_control_channel, "-d1");

        }
        else if(message == "-d_begin!")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");

        }
        else if(message == "-a_hard")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "action_s:1");

        }
        else if(message == "-d_hard!")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }
        else if(message == "-a_notclear")
        {
            interrupt();
            llSay(base_npc_control_channel+3, "action_s:2");

        }
        else if(message == "-d_notclear!")
        {
            interrupt();
            llSay(facil_control_channel, "-d3");
        }
    }
}