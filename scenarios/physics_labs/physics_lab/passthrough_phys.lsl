// change history:
//   November 2017: created by Raymond Naglieri
//         2/27/18: added various commands to match design
integer num_npc = 8;
integer num_board = 3;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer board_control_channel = 36000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_beg_guide_state_channel = 10001;
integer facil_capture_channel = -33156;
integer auto_facil_control_channel = 10102;
integer physics_dialogue_state_control_channel = 10001; 
integer npc_scenario_control_channel = 41000;

interrupt()
{
    integer i;
    for (i=0; i<num_npc; i++)
        llSay(base_npc_control_channel+i, "-interrupt"); // ask(temp)
    llSleep(3.0);
}

integer random_integer(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
}

reset_to_start() 
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-reset");
    llSay(facil_control_channel, "-reset");
    llSay(physics_dialogue_state_control_channel, "-reset");   
    llSay(auto_facil_control_channel, "-reset");
    llSay(npc_scenario_control_channel , "-reset");
    llSay(facil_capture_channel, "-reset"); 
    llSay(facil_beg_guide_state_channel, "-reset"); 
} 

npc_group_speak() 
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-groupspeak");
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

npc_show_state()
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-showmood");    
}

npc_wait_animation()
{
    integer i;
    for (i=0; i<num_npc; i++)
        llSay(base_npc_control_channel+i, "-npcwait");   
}

npc_stop_animation()
{
    integer i;
    for (i=0; i<num_npc; i++)
         llSay(npc_action_control_base_channel+i, "@Stop_ani");  
}

npc_hand_animation()
{
    integer i;
    for (i=0; i<num_npc; i++)
    {
        if(i != 4)
            llSay(npc_action_control_base_channel+i, "@Hand_up");  
    }
}

npc_ask_animation()
{
    integer i;
    for (i=0; i<num_npc; i++)
    {
        if(random_integer(0,1))
            llSay(base_npc_control_channel+i, "-npcask3"); // ask(temp)
    }
}

npc_bored_animation()
{
    integer i;
    for (i=0; i<num_npc; i++)
    {
        if(random_integer(0,1))
            llSay(npc_action_control_base_channel+i, "@Perform-avatar_express_bored");  
    }
}

slide_board_update_all(string board_id)
{
    integer i;
    for (i=0; i<num_board; i++)
        llSay(board_control_channel + i, board_id);     
}

default
{
    state_entry()
    {
        llListen(backdoor_channel, "", NULL_KEY, "");
    }   
    
    listen(integer channel, string name, key id, string message)
    {
        if (message == "-reset")
        {
            reset_to_start();
        }
        else if(message == "-d_beg")
        {
            interrupt();
            llSay(facil_beg_guide_state_channel, "-gotostate:s0");
        }
        else if(message == "-nc_wiresandfuse") 
        {
            interrupt();
            llSay(facil_control_channel, "-nc1");
        } 
        else if(message == "-nc_npccorrectvoltage") 
        {
             interrupt();
             llSay(facil_control_channel, "-nc2");
        } 
        else if(message == "-nc_npcrighthandside") 
        {
            interrupt();
            llSay(facil_control_channel, "-nc2");
        }
        else if(message == "-d_start") 
        {
            interrupt();
            llSay(facil_control_channel, "-d0");
        } 
        else if(message == "-d_studentexperiments") ///
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
            llSay(board_control_channel+0, "1"); 
            llSay(board_control_channel+1, "1");
            llSay(board_control_channel+2, "4");              
        } 
        else if(message == "-d_lookatboard") 
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }  
        else if(message == "-d_lookatboard!") ///
        {
            interrupt();
            llSay(facil_control_channel, "-d2!");
        } 
        else if(message == "-d_waystomonitor") // only
        {
            interrupt();
            llSay(facil_control_channel, "-d3");
        }
        else if(message == "-d_samequestion") ///
        {
            interrupt();
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-d_npcmeasurecurrent") 
        {
            interrupt();
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-d_npcmeasurevoltage") 
        {
            interrupt();
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-d_npccorrectvoltage")
        {
            interrupt();
            llSay(facil_control_channel, "-d7");
        } 
        else if(message == "-d_npccorrectvoltage!") 
        {
            interrupt();
            llSay(facil_control_channel, "-d6");
        } 
        else if(message == "-d_tokirchoffsrules") ///
        {
            interrupt();
            llSay(facil_control_channel, "-d8");
        } 
        else if(message == "-d_npcdifferentcurrent")
        {
            interrupt();
            llSay(facil_control_channel, "-d9");
        }
        else if(message == "-d_npcdifferentcurrent2")
        {
            interrupt();
            llSay(facil_control_channel, "-d9");
        }
        else if(message == "-d_npcnegativevoltage")
        {
            interrupt();
            llSay(facil_control_channel, "-d10");
        }
        else if(message == "-d_npcrighthandside")
        {
            interrupt();
            llSay(facil_control_channel, "-d7");
        } 
        else if(message == "-d_npcrighthandside!") 
        {
            interrupt();
            llSay(facil_control_channel, "-d6");
        } 
        else if(message == "-d_labending") 
        {
            interrupt();
            llSay(facil_control_channel, "-d11");
        } 
        else if(message == "-d_labover") 
        {
            interrupt();
            llSay(facil_control_channel, "-d12");
        } 
        else if(message == "-d_dodifferent") 
        {
            interrupt();
            llSay(facil_control_channel, "-d13");
        } 
        else if(message == "-d_congrats") 
        {
            interrupt();
            llSay(facil_control_channel, "-d14");
        } 
        else if(message == "-d_startnow") 
        {
            interrupt();
            llSay(facil_control_channel, "-d15");
        } 
        else if(message == "-d_physicsdialogue") 
        {
            interrupt();
            llSay(physics_dialogue_state_control_channel, "-gotostate:s0");
        }
        else if(message == "-d_extratime") 
        {
            interrupt();
            llSay(facil_control_channel, "-d16");
        }
        else if(message == "-d_noextratime") 
        {
            interrupt();
            llSay(facil_control_channel, "-d17");
        }   
        else if(message == "-d_connect4voltage") 
        {
            interrupt();
            llSay(facil_control_channel, "-d18");
        }   
        else if(message == "-d_connect4current") 
        {
            interrupt();
            llSay(facil_control_channel, "-d19");
        }     
        else if(message == "-a_lookatboard")
        {
            interrupt();
            llSay(npc_action_control_base_channel, "@Rotate-n");
        }  
        else if(message == "-a_npcmeterbroken")
        {
            interrupt();
            llSay(base_npc_control_channel, "-npcask");
        } 
        else if(message == "-a_npclookatmeter")
        {
            interrupt();
            llSay(base_npc_control_channel+5, "-npcask2");
        } 
        else if(message == "-a_npcmeasurecurrent")
        {
            interrupt();
            llSay(base_npc_control_channel+1, "-npcask3");
            llSay(base_npc_control_channel+3, "-npcresp1");
            slide_board_update_all("5");
        } 
        else if(message == "-a_npcmeasurevoltage")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "-npcask4");
            llSay(base_npc_control_channel+6, "-npcresp2");
            slide_board_update_all("0");
        } 
        else if(message == "-a_npccorrectresvoltage")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "-npcask5");
            slide_board_update_all("3");
        } 
        else if(message == "-a_npccorrectcurrent")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "-npcask6");
            slide_board_update_all("2");
        }  
        else if(message == "-a_npcoutoftime")
        {   
            interrupt();
            llSay(base_npc_control_channel+2, "-npcask11");
        } 
        else if(message == "-a_connect4voltage") 
        {
            interrupt();
            llSay(base_npc_control_channel+2, "-npcask7");
            slide_board_update_all("3");
        }   
        else if(message == "-a_connect4current") 
        {
            interrupt();
            llSay(base_npc_control_channel+7, "-npcask8");
            slide_board_update_all("2");
        } 
        else if(message == "-ad_labending") 
        {
            interrupt();
            llSay(facil_control_channel, "-d11");
            llSay(base_npc_control_channel+2, "-npcask11");
        }  
        else if(message == "-sb_npcmeasurevoltage") 
        {
            interrupt();
            slide_board_update_all("1");
        }   

    }
} 