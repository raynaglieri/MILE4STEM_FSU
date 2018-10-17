// change history:
//   November 2017: created by Raymond Naglieri
//      04/27/18 - updated to support interrupts. Now supports the ability to delay a command.
//      05/05/18 - modified for problem solving lecture
//  
integer num_npc = 8;
integer scenario_offset = 800000;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_capture_channel = -33156;
integer board_control_channel = 36000;

set_offset()
{
    base_npc_control_channel = 31000 + scenario_offset;
    npc_para_control_base_channel = 32000 + scenario_offset; 
    npc_action_control_base_channel = 33000 + scenario_offset;
    backdoor_channel= 20001 + scenario_offset;
    facil_control_channel = 10101 + scenario_offset;
    facil_capture_channel = -33156 + scenario_offset;
    board_control_channel = 36000 + scenario_offset;  
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
        } 
        else if(message == "-2default")
        {
            interrupt();
            multi_command("-goto:default", [0,1,2,3,4,5,6,7]);
        }
        else if(message == "-d_deliver")
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
        }
        else if(message == "-d_deliver!")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");
        }
        else if(message == "-ad_situation")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npccustanim"); 
            llSay(base_npc_control_channel+4, "npcanim1"); 
            llSay(base_npc_control_channel+5, "npccustanim");
            llSleep(2.0);
            llSay(facil_control_channel, "-d2");
        }
        else if(message == "-ad_situation!")
        {
            interrupt();
            llSay(facil_control_channel, "-d2!");
        }
        else if(message == "-ad_understand")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npcsay0"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay1");
            llSleep(2.0);
            llSay(facil_control_channel, "-d3");
        }
        else if(message == "-a_cognitive")
        {
            interrupt();
            multi_command("-goto:default", [0,5]);
            llSleep(1.0);
            llSay(base_npc_control_channel+3, "npcask0"); 
        }
        else if(message == "-a_cognitiveres")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay3");
        }
        else if(message == "-a_cognitive!")
        {
            interrupt();
            llSay(facil_control_channel, "-d4!");
        }
        else if(message == "-ad_goals")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npccustanim"); 
            llSay(base_npc_control_channel+4, "npcanim1"); 
            llSay(base_npc_control_channel+5, "npccustanim");
            llSay(facil_control_channel, "-d5");

        }
        else if(message == "-ad_goals!")
        {
            interrupt();
            llSay(facil_control_channel, "-d5!");
        }
        else if(message == "-ad_diff")
        {
            interrupt();
            llSay(base_npc_control_channel+5, "npcsay4"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+1, "npcsay5"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+7, "npcsay6");
            llSleep(2.0);
            llSay(facil_control_channel, "-d6");

        }
        else if(message == "-ad_diff!")
        {
            interrupt();
            llSay(facil_control_channel, "-d6!");
        }
        else if(message == "-ad_atten")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay7"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay7"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+0, "npcsay8");
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay9"); 
            llSleep(2.0);
            llSay(facil_control_channel, "-d7");

        }
        else if(message == "-ad_culture")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay10"); 
            llSleep(2.0);
            llSay(facil_control_channel, "-d8");

        }
        else if(message == "-ad_culture!")
        {
            interrupt();
            llSay(facil_control_channel, "-d8!");
        }
        else if(message == "-ad_fast")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npcask1"); 

        }
        else if(message == "-ad_fast!")
        {
            interrupt();
            llSay(facil_control_channel, "-d9!");
        }
        else if(message == "-ad_discuss")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay7"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+3, "npcsay7"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+2, "npcsay11");
            llSleep(1.0);
            llSay(base_npc_control_channel+3, "npcaction4"); 
        }
        else if(message == "-ad_discuss!")
        {
            interrupt();
            llSay(facil_control_channel, "-d10!");            
        }
        else if(message == "-ad_lost")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay13"); 
        }
        else if(message == "-ad_lost!")
        {
            interrupt();
            llSay(facil_control_channel, "-d11!");            
        }
        else if(message == "-ad_moreref")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcask2"); 
        }
        else if(message == "-ad_moreref!")
        {
            interrupt();
            llSay(facil_control_channel, "-d12!");            
        }
        // else if(message == "-ad_moreref")
        // {
        //     interrupt();
        //     llSay(base_npc_control_channel+2, "npcask2"); 
        // }
        // else if(message == "-ad_moreref!")
        // {
        //     interrupt();
        //     llSay(facil_control_channel, "-d12!");            
        // }
        else if(message == "-ad_visual")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay14"); 
            llSleep(1.0);
            llSay(base_npc_control_channel+6, "npcsay15"); 
            llSay(base_npc_control_channel+0, "npcanim2"); 
            llSay(base_npc_control_channel+6, "npcanim2"); 
            llSleep(2.0);
            llSay(facil_control_channel, "-d13"); 

        }
        else if(message == "-ad_visual!")
        {
            interrupt();
            llSay(facil_control_channel, "-d13!");            
        }
        else if(message == "-ann_example")
        {
            interrupt();
            llSay(0, "it's a time to present your students with an example of a top-down processing");            
        }
        else if(message == "-ann_example!")
        {
            interrupt();
            llSay(facil_control_channel, "-d14!");            
        }
        else if(message == "-a_understand")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npcaction0");
        }
        else if(message == "-a_understand!")
        {
            interrupt();
            llSay(facil_control_channel, "-d15!");            
        }
        else if(message == "-a_discip")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npcsay16");
        }
        else if(message == "-a_discip!")
        {
            interrupt();
            llSay(facil_control_channel, "-d16!");            
        }
        else if(message == "-ad_confid")
        {
            llSay(facil_control_channel, "-d17"); 
            llSleep(2.0);
            interrupt();
            llSay(base_npc_control_channel+6, "npcaction1");
            llSleep(1.0);
            llSay(base_npc_control_channel+7, "npcsay17");
            llSay(facil_control_channel, "-d18"); 
        }
        else if(message == "-ann_finish")
        {
            interrupt();
            llSay(0, "Ask your students if they have questions.");            
        }
        else if(message == "-ann_finish!")
        {
            interrupt();
            llSay(facil_control_channel, "-d19!");            
        }
        else if(message == "-ad_impression")
        {
            interrupt();
            llSay(facil_control_channel, "-d20"); 
        }
        else if(message == "-ad_impression!")
        {
            interrupt();
            llSay(facil_control_channel, "-d20!"); 
        }
      else if(message == "-ad_add")
        {
            interrupt();
            multi_command("npcask3",[0,1,4]);
            llSleep(2.0);
            llSay(facil_control_channel, "-d23"); 
        }
    }
}