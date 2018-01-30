// change history:
//   November 2017: created by Raymond Naglieri
integer num_npc = 8;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer physics_dialogue_state_control_channel = 10001; 


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
        else if(message == "-nc_wiresandfuse") 
        {
            llSay(facil_control_channel, "-nc1");
        } 
        else if(message == "-nc_npccorrectvoltage") 
        {
             llSay(facil_control_channel, "-nc2");
        } 
        else if(message == "-nc_npcrighthandside") 
        {
             llSay(facil_control_channel, "-nc2");
        }
        else if(message == "-d_start") 
        {
            llSay(facil_control_channel, "-d0");
        } 
        else if(message == "-d_studentexperiments") 
        {
            llSay(facil_control_channel, "-d1");
        } 
        else if(message == "-d_lookatboard") 
        {
            llSay(facil_control_channel, "-d2");
        }  
        else if(message == "-d_lookatboard!") 
        {
            llSay(facil_control_channel, "-d2!");
        } 
        else if(message == "-d_waystomonitor") // only
        {
            llSay(facil_control_channel, "-d3");
        }
        else if(message == "-d_samequestion") 
        {
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-d_npcmeasurecurrent") 
        {
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-d_npcmeasurevoltage") 
        {
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-d_npccorrectvoltage")
        {
             llSay(facil_control_channel, "-d7");
        } 
        else if(message == "-d_npccorrectvoltage!") 
        {
             llSay(facil_control_channel, "-d6");
        } 
        else if(message == "-d_tokirchoffsrules") 
        {
             llSay(facil_control_channel, "-d8");
        } 
        else if(message == "-d_npcdifferentcurrent")
        {
            llSay(facil_control_channel, "-d9");
        }
        else if(message == "-d_npcdifferentcurrent2")
        {
            llSay(facil_control_channel, "-d9");
        }
        else if(message == "-d_npcnegativevoltage")
        {
            llSay(facil_control_channel, "-d10");
        }
        else if(message == "-d_npcrighthandside")
        {
             llSay(facil_control_channel, "-d7");
        } 
        else if(message == "-d_npcrighthandside!") 
        {
             llSay(facil_control_channel, "-d6");
        } 
        else if(message == "-d_labending") 
        {
             llSay(facil_control_channel, "-d11");
        } 
        else if(message == "-d_labover") 
        {
             llSay(facil_control_channel, "-d12");
        } 
        else if(message == "-d_dodifferent") 
        {
             llSay(facil_control_channel, "-d13");
        } 
        else if(message == "-d_congrats") 
        {
             llSay(facil_control_channel, "-d14");
        } 
        else if(message == "-d_startnow") 
        {
             llSay(facil_control_channel, "-d15");
        } 
        else if(message == "-d_physicsdialogue") 
        {
             llSay(physics_dialogue_state_control_channel, "-gotostate:s0");
        }         
        else if(message == "-a_lookatboard")
        {
             llSay(npc_action_control_base_channel, "@Rotate-n");
        }  
        else if(message == "-a_npcmeterbroken")
        {
             llSay(base_npc_control_channel, "-npcask");
        } 
        else if(message == "-a_npclookatmeter")
        {
             llSay(base_npc_control_channel+5, "-npcask2");
        } 
        else if(message == "-a_npcmeasurecurrent")
        {
             llSay(base_npc_control_channel+1, "-npcask3");
             llSay(base_npc_control_channel+3, "-npcresp1");
        } 
        else if(message == "-a_npcmeasurevoltage")
        {
             llSay(base_npc_control_channel+4, "-npcask4");
             llSay(base_npc_control_channel+6, "-npcresp2");
        } 
        else if(message == "-a_npccorrectresvoltage")
        {
             llSay(base_npc_control_channel+2, "-npcask5");
        } 
        else if(message == "-a_npccorrectcurrent")
        {
             llSay(base_npc_control_channel+7, "-npcask6");
        } 
        else if(message == "-a_npcdifferentcurrent")
        {
             llSay(base_npc_control_channel, "-npcask7");
             llSay(base_npc_control_channel+1, "-npcresp3");
             llSay(base_npc_control_channel+2, "-npcresp4");
        } 
        else if(message == "-a_npcdifferentcurrentt2")
        {
             llSay(base_npc_control_channel+6, "-npcask8");
             llSay(base_npc_control_channel+3, "-npcresp5");
        }   
        else if(message == "-a_npcnegativevoltage")
        {
             llSay(base_npc_control_channel+4, "-npcask9");
             llSay(base_npc_control_channel+2, "-npcresp6");
        }  
        else if(message == "-a_npcrighthandside")
        {
             llSay(base_npc_control_channel+7, "-npcask10");
             llSay(base_npc_control_channel+1, "-npcresp7");
        }
        else if(message == "-a_npcoutoftime")
        {
             llSay(base_npc_control_channel+2, "-npcask11");
        } 
        else if(message == "-ad_labending") 
        {
             llSay(facil_control_channel, "-d11");
             llSay(base_npc_control_channel+2, "-npcask11");

        }    

    }
} 