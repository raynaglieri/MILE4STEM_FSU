// change history:
//   November 2017: created by Raymond Naglieri
//      04/27/18 - updated to support interrupts. Now supports the ability to delay a command.
//      05/05/18 - modified for problem solving lecture
//  
integer num_npc = 8;
integer scenario_offset = 200000;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_capture_channel = -33156;
integer board_control_channel = 36000;
integer facil_scribe_channel = 17888; // scribe channel captures 

set_offset()
{
    base_npc_control_channel = 31000 + scenario_offset;
    npc_para_control_base_channel = 32000 + scenario_offset; 
    npc_action_control_base_channel = 33000 + scenario_offset;
    backdoor_channel= 20001 + scenario_offset;
    facil_control_channel = 10101 + scenario_offset;
    facil_capture_channel = -33156 + scenario_offset;
    board_control_channel = 36000 + scenario_offset; 
    facil_scribe_channel = 17888 + scenario_offset;    
}

string delayed_command = "NULL";
float delay = 0.0;
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

reset_to_start() 
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-reset");
    llSay(facil_control_channel, "-reset");  
    llSay(facil_capture_channel, "-reset");  
    llSay(facil_scribe_channel, "reset~*~");

} 

npc_rnd_pair_all() 
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "npccustsay0");
}

npc_group()
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-group");    
}

npc_group_return()
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-groupreturn");    
}

follow_up_resp()
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-npcfollow");    
}

multi_command(string command, list ignore)
{
    integer i;
    for (i=0; i<num_npc; i++)
    {
        if(~llListFindList(ignore, (list)i))
            llSay(base_npc_control_channel+i, command);
    }
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
            llSay(board_control_channel, "6");
        } 
        else if(message == "-2default")
        {
            interrupt();
            multi_command("-goto:default", [0,1,2,3,4,5,6,7]);
        }
        else if(message == "-d_teach")
        {
            interrupt();
            llSay(facil_control_channel, "-d0");
        }
        else if(message == "-ad_engage")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npccustanim_1");
            multi_command("npccustanim_0", [1,4,2]);
            llSleep(2.5);
            llSay(facil_control_channel, "-d1");
        }
        else if(message == "-ad_engage.r1")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");
        }
        else if(message == "-d_interest")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }
        else if(message == "-d_interest.r1")
        {
            interrupt();
            llSay(facil_control_channel, "-a1");
        }  
        else if(message == "-ad_states")
        {
            interrupt();
            multi_command("-goto:default", [1,4,2,7]);
            llSleep(1.0);
            multi_command("npcanim1", [3,7]);
            llSay(facil_control_channel, "-d3");
        }  
        else if(message == "-ad_states.r1")
        {
            interrupt();
            llSay(facil_control_channel, "-d3!");
        }
        else if(message == "-a_lost")
        {
            interrupt();
            llSay(base_npc_control_channel+3, "npcsay0");
            llSleep(1.0);
            llSay(base_npc_control_channel+7, "npcanim3");
        }  
        else if(message == "-a_lost.r1")
        {
            interrupt();
            llSay(facil_control_channel, "-a1");
        }
        else if(message == "-ad_handout")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay1");
            llSleep(1.0);
            llSay(base_npc_control_channel+1, "npcsay2");
            llSleep(1.0);
            llSay(base_npc_control_channel+2, "npcsay3");
            llSleep(2.5);
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-ad_handout.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d4!");
        }
        else if(message == "-ad_points")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npcsay8");
            llSleep(1.0);
            llSay(base_npc_control_channel+0, "npcsay9");
            llSleep(2.5);
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-ad_points.nc")
        {
            interrupt();
            llSay(facil_control_channel, "-nc1");
        }
        else if(message == "-ad_motivate")
        {
            interrupt();
            llSay(facil_control_channel, "-a1");
            llSay(base_npc_control_channel+0, "npccustanim_3");
            multi_command("npccustanim_2", [3,5,6]);
            llSleep(2.5);
            llSay(facil_control_channel, "-d6");
        }
        else if(message == "-ad_motivate.r1")
        {
            interrupt();
            multi_command("-goto:default", [0,3,5,6]);
        }
        else if(message == "-ad_cues")
        {
            interrupt();
            llSay(base_npc_control_channel+5, "npcsay10");
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay11");
            llSleep(2.5);
            llSay(facil_control_channel, "-d7");
        }
        else if(message == "-ad_cues.r2")
        {
            interrupt();
             llSay(facil_control_channel, "-d7!");
        }
        else if(message == "-ad_differ")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "npcsay12");
            llSleep(1.0);
            multi_command("npccustanim_2", [5,6]);
            llSleep(2.5);
            llSay(facil_control_channel, "-d8");
        }
        else if(message == "-ad_differ.r1")
        {
            interrupt();
            multi_command("-goto:default", [5,6]);
        }
        else if(message == "-ad_differ.r2")
        {
            interrupt();
            multi_command("-goto:default", [5,6]);
            llSay(facil_control_channel, "-d8!");
        }
        else if(message == "-ad_covered")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcaction0");
            llSay(base_npc_control_channel+1, "npcanim3");
            llSleep(2.5);
            llSay(facil_control_channel, "-d9");
        }
        else if(message == "-ad_covered.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d9!");
        }
        else if(message == "-ad_alternate")
        {
            interrupt();
            multi_command("npcaction1", [0,1,2,3,5,6,7]);
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay13");
            llSleep(3.0);
            llSay(facil_control_channel, "-d10");
        }
        else if(message == "-ad_alternate.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d10!");
        }
        // else if(message == "-ad_alternate")
        // {
        //     interrupt();
        //     multi_command("npcaction1", [0,1,2,3,5,6,7]);
        //     llSleep(1.0);
        //     llSay(base_npc_control_channel+4, "npcsay13");
        //     llSleep(2.5);
        //     llSay(facil_control_channel, "-d10");
        // }
        // else if(message == "-ad_alternate.r2")
        // {
        //     interrupt();
        //     llSay(facil_control_channel, "-d10!");
        // }
        else if(message == "-ad_speed")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npcaction2");
        }
        else if(message == "-ad_speed.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d15!");
        }
        else if(message == "-annd_present")
        {
            interrupt();
            llSay(facil_control_channel, "-a2");
        }
        else if(message == "-annd_present.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d17!");
        }
        else if(message == "-ad_understand")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npcaction3");
        }
        else if(message == "-ad_understand.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d18!");
        }
        else if(message == "-ad_chat")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcaction4");
            llSleep(1.0);
            llSay(base_npc_control_channel+3, "npcaction5");
        }
        else if(message == "-ad_chat.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d16!");
        }
        else if(message == "-ad_sequence")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay14");
        }
        else if(message == "-ad_sequence.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d19!");
        }
        else if(message == "-ad_visual")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay15");
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay16");
            llSleep(2.5);
            llSay(facil_control_channel, "-d11");
        }
        else if(message == "-ad_visual.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d11!");
        }
        else if(message == "-ad_relate")
        {
            interrupt();
            llSay(facil_control_channel, "-a1");
            llSay(base_npc_control_channel+4, "npcaction6");
        }
        else if(message == "-ad_relate.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d20!");
        }
        else if(message == "-ad_build")
        {
            interrupt();
            llSay(facil_control_channel, "-a3");
            llSleep(2.5);
            llSay(base_npc_control_channel+6, "npcaction7");
            llSleep(2.5);
            llSay(facil_control_channel, "-d12!");
        }
        else if(message == "-ann_finish")
        {
            interrupt();
            llSay(facil_control_channel, "-a4");
            llSleep(2.5);  
            llSay(facil_control_channel, "-a5");
        }
        else if(message == "-ann_finish.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d21");
        }
        else if(message == "-d_reluctant")
        {
            interrupt();
            llSay(facil_control_channel, "-d13");
        }
        else if(message == "-d_reluctant.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d13!");
        }
        else if(message == "-ad_add")
        {
            interrupt();
            multi_command("npcask6", [2,7]);
            llSleep(2.5);
            llSay(facil_control_channel, "-d14");
        }
    }
}