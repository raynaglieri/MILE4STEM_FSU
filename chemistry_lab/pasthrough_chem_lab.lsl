//  CREATED BY: Raymond Naglieri on 06/01/2018 
// DESCRIPTION: Command passthrough for faciltators and NPC signals. 
//         LOG: 06/01/2018 - Updated for chemistry lab.

integer num_npc = 8;
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

default
{
    state_entry()
    {
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
        else if(message == "-d_monprog")
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
        }
        else if(message == "-d_imaglab")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }
        // else if(message == "-d_idlemonitor")
        // {
        //     interrupt();
        //     llSay(facil_control_channel, "-d3");
        // }
        else if(message == "-d_nomonitor")
        {
            interrupt();
            llSay(facil_control_channel, "-d3");
        }
        else if(message == "-d_idlemonitor")
        {
            interrupt();
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-d_helpmonitor")
        {
            interrupt();
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-a_ph1")
        {
            interrupt();
            llSay(base_npc_control_channel, "ask_s1:1");
        }
        else if(message == "-a_ph2")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "ask_s1:2");
        }
        else if(message == "-a_ph3")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "ask_s1:3");
        }
        else if(message == "-d_ph!")
        {
            interrupt();
            llSay(facil_control_channel, "-d6");
        }
        else if(message == "-nc_ph!")
        {
            interrupt();
            llSay(facil_control_channel, "-nc1");
        }
        else if(message == "-d_similar")
        {
            interrupt();
            llSay(facil_control_channel, "-d7");
        }
        else if(message == "-d_similarkey!")
        {
            interrupt();
            llSay(facil_control_channel, "-d8");
        }
        else if(message == "-d_similarkey")
        {
            interrupt();
            llSay(facil_control_channel, "-d9");
        }
        else if(message == "-d_similarann")
        {
            interrupt();
            llSay(facil_control_channel, "-d10");
        }
        else if(message == "-d_teachagain")
        {
            interrupt();
            llSay(facil_control_channel, "-d11");
        }
        else if(message == "-d_teachagainkey!")
        {
            interrupt();
            llSay(facil_control_channel, "-d12");
        }
        else if(message == "-d_teachagainkey")
        {
            interrupt();
            llSay(facil_control_channel, "-d13");
        }
        else if(message == "-a_time")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "ask_s1:4");
        }
        else if(message == "-d_labover")
        {
            interrupt();
            llSay(facil_control_channel, "-d14");
        }
        else if(message == "-d_labdiff")
        {
            interrupt();
            llSay(facil_control_channel, "-d15");
        }
        else if(message == "-d_cont2spill")
        {
            interrupt();
            llSay(facil_control_channel, "-d16");
        }
        else if(message == "-d_yes2spill")
        {
            interrupt();
            llSay(facil_control_channel, "-d17");
        }
        else if(message == "-d_no2spill")
        {
            interrupt();
            llSay(facil_control_channel, "-d18");
        }
        else if(message == "-a_spill")
        {
            interrupt();
            llSay(interact_with_lab_channel, "-spill");
            llSay(base_npc_control_channel+2, "ask_s2:1");
        }
        else if(message == "-nc_acid")
        {
            interrupt();
            llSay(facil_control_channel, "-nc2");
        }        
        else if(message == "-d_cont2fire")
        {
            interrupt();
            llSay(facil_control_channel, "-d20");
        }
        else if(message == "-d_yes2fire")
        {
            interrupt();
            llSay(facil_control_channel, "-d19");
        }
        else if(message == "-d_no2fire")
        {
            interrupt();
            llSay(facil_control_channel, "-d18");
        }
        else if(message == "-a_fire")
        {
            interrupt();
            llSay(interact_with_lab_channel, "-fire");
            llSay(base_npc_control_channel, "ask_s3:1");
        }
        else if(message == "-nc_fire")
        {
            interrupt();
            llSay(facil_control_channel, "-nc3");
        }
        else if(message == "-a_allleave")
        {
            interrupt();
            multi_command("leave_s3:1", [0,1,2,3,4,5,6,7]);
        }
        else if(message == "-d_fireout")
        {
            interrupt();
            llSay(facil_control_channel, "-d21");
        }
        else if(message == "-d_congrats")
        {
            interrupt();
            llSay(facil_control_channel, "-d22");
        }
    }
}