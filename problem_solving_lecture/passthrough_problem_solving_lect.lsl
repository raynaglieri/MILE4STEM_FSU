// change history:
//   November 2017: created by Raymond Naglieri
//      04/27/18 - updated to support interrupts. Now supports the ability to delay a command.
//      05/05/18 - modified for problem solving lecture
//  
integer num_npc = 8;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_capture_channel = -33156;
integer board_control_channel = 36000;

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
        else if (message == "-npcr")
        {
            //follow_up_resp();
        }  
        else if(message == "-2default")
        {
            interrupt();
            multi_command("-goto:default", [0,1,2,3,4,5,6,7]);
        }
        ///////////////
        else if (message == "-ad_seperatetype")
        {
            interrupt();
            llSay(board_control_channel, "-exit_cycle"); 

            multi_command("npccustanimlength", [0,2,3,5,6,7]);
            llSleep(2.0);
            //multi_command("npcanim1", [1, 3, 4, 6]);
            llSay(base_npc_control_channel+1, "npcaction0");
            llSay(base_npc_control_channel+4, "npcaction1");
            llSleep(3.0); // add to delay functionality 
            llSay(facil_control_channel, "-d4");
        }
        else if (message == "-d_seperatetype" || message == "-d_seperatetype!")
        {
            interrupt(); 
            llSay(facil_control_channel, "-d5");
        } 
        ///////////////
        else if (message == "-ad_gotogether")
        {
            interrupt();
            //llSay(board_control_channel, "-cycle"); 
            npc_rnd_pair_all();
            llSleep(1.0);
            llSay(facil_control_channel, "-d19"); 

        } 
        else if (message == "-d_gotogether" || message == "-d_gotogether!")
        {
            interrupt();
            llSay(facil_control_channel, "-d3"); 
        }
        ///////////////
        else if (message == "-a_restrict")
        {
            interrupt();
            llSay(base_npc_control_channel+3, "npcask0");  
        }
        else if (message == "-d_restrict" || message == "-d_restrict!")
        {
            interrupt();
            llSay(facil_control_channel, "-d7"); 
        }
        ///////////////
        else if (message == "-a_givens")
        {
            interrupt();
            llSay(base_npc_control_channel+1, "npcask1");  
        }
        else if (message == "-d_givens" || message == "-d_givens!")
        {
            interrupt();
            llSay(facil_control_channel, "-d8"); 
        }
        ///////////////
        else if (message == "-a_2like1")
        {
            interrupt();
            llSay(base_npc_control_channel+5, "npcask3");  
        }
        else if (message == "-d_2like1" || message == "-d_2like1!")
        {
            interrupt();
            llSay(facil_control_channel, "-d10"); 
        }
        ///////////////
        else if (message == "-a_1like2")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcask2");  
        }
        else if (message == "-d_1like2" || message == "-d_1like2!")
        {
            interrupt();
            llSay(facil_control_channel, "-d11"); 
        }
        else if (message == "-d_diffappro" || message == "-d_diffappro!")
        {
            interrupt();
            llSay(facil_control_channel, "-d12"); 
        }
        ///////////////
        else if (message == "-nc_aidschema")
        {
            interrupt();
            llSay(facil_control_channel, "-nc1"); 

        }
        else if (message == "-d_aidschema" || message == "-d_aidschema!")
        {
            interrupt();
            llSay(facil_control_channel, "-d9"); 
        }
        ///////////////
        else if (message == "-anc_alright")
        {
            interrupt();
            multi_command("-goto:default", [0,2,3,5,6,7]);
            llSleep(1.0);
            llSay(base_npc_control_channel+1, "npcrndsay0"); 
            llSay(base_npc_control_channel+4, "npcrndsay0"); 
            llSay(base_npc_control_channel+1, "npcanim0"); 
            llSay(base_npc_control_channel+4, "npcanim0");   
            llSay(facil_control_channel, "-nc2"); 
        } 
        ///////////////
        else if(message == "-ann_thinkaloud")
        {
            interrupt();
            llSay(0,"See if your students could think aloud about their problem solving steps.");
            llSay(facil_control_channel, "-d18");
        }   
        else if (message == "-d_thinkaloud" || message == "-d_thinkaloud!")
        {
            interrupt();
            llSay(facil_control_channel, "-d13"); 
        }
        ///////////////
        else if (message == "-a_npcaloud")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "npcsay0"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+4, "npcsay1"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+3, "npcsay2");     
        } 
        else if (message == "-d_npcaloud" || message == "-d_npcaloud!")
        {
            interrupt();
            llSay(facil_control_channel, "-d14"); 
        }
        /////////////// 
        else if (message == "-anc_npceasy")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "npcrandsay1"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+4, "npcrandsay1"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+3, "npcrandsay1"); 
            llSay(facil_control_channel, "-nc3");     
        } 
        else if (message == "-d_npceasy" || message == "-d_npceasy!")
        {
            interrupt();
            llSay(facil_control_channel, "-d15");
        }
        /////////////// 
        else if(message == "-ann_socratic")
        {
            interrupt();
            llSay(0,"See if your students know what Socratic questionning is.");
        }   
        else if(message == "-d_socratic" || message == "-d_socratic!")
        {
            interrupt();
            llSay(facil_control_channel, "-d16"); 
        }
        ///////////////
        else if (message == "-anc_npcsocratic")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay3"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+4, "npcsay4"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+5, "npcsay5"); 
            llSay(facil_control_channel, "-nc4");     

        } 
        else if (message == "-d_npcsocratic" || message == "-d_npcsocratic!")
        {
            interrupt();
            llSay(facil_control_channel, "-d17");     

        } 
        /////////////// 
        else if(message == "-d_groupgame")
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
            llSay(board_control_channel, "1"); 
        }
        else if(message == "-d_groupgame!")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");
        }
        else if(message == "-d_surfacefeat")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        } 
         else if(message == "-b_explainprob")
        {
            interrupt();
            llSay(board_control_channel, "2");
        }  
              
        else if(message == "-d_explainprob")
        {
            interrupt();
            llSay(facil_control_channel, "-d6");
        }
        else if(message == "-d_analyze!")
        {
            interrupt();
            llSay(facil_control_channel, "-d5!");
        }
        // else if(message == "-d_boardexp" || message == "-d_boardexp!")
        // {
        //     interrupt();
        //     llSay(facil_control_channel, "-d6");
        // }
        else if(message == "-b_set1")
        {
            llSay(board_control_channel, "0");
        }
        else if(message == "-b_set2")
        {
           llSay(board_control_channel, "1"); 
        }
        else if(message == "-b_set3")
        {
            llSay(board_control_channel, "2"); 
        }
        else if(message == "-b_stopcyc")
        {
           llSay(board_control_channel, "-exit_cycle");  
        }
        else if(message == "-b_startcyc")
        {
           llSay(board_control_channel, "-cycle");  
        }
    }
}