// change history:
//   November 2017: created by Raymond Naglieri
//      04/27/18 - updated to support interrupts. Now supports the ability to delay a command.
//      05/05/18 - modified for problem solving lecture
//  
integer num_npc = 8;
integer scenario_offset = 1100000;
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
            //llSay(board_control_channel, "0");
        }
        else if(message == "-d_start")
        {   
            interrupt();
            llSay(facil_control_channel, "-d1");
            //llSay(board_control_channel, "0");
        }
        else if(message == "-d_start.r1")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");
            //llSay(board_control_channel, "0");
        }
        else if(message == "-d_board.r1")
        {
            interrupt();
            llSay(facil_control_channel, "-d2!");
            //llSay(board_control_channel, "0");
        }
        else if(message == "-d_continue")
        {
            interrupt();
            llSay(facil_control_channel, "-d3");
            //llSay(board_control_channel, "0");
        }
        else if(message == "-anc_ohms")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npc_ask0"); 
        }
        else if(message == "-anc_ohms.r1")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay2"); 
            llSleep(4.0);
            llSay(facil_control_channel, "-nc3");
        }
        else if(message == "-anc_ohms.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npcsay3"); 
            llSleep(4.0);
            llSay(facil_control_channel, "-nc3");
        }
        else if(message == "-ad_range") ///
        {
            interrupt();
            llSay(base_npc_control_channel+5, "npc_ask1"); 
        }
        else if(message == "-ad_range.r2") ///
        {
            interrupt();
            llSay(base_npc_control_channel+5, "npc_empty");
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-d_volt")
        {
            interrupt();
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-d_volt.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d4!");//
        }        
        else if(message == "-ad_multimeter")
        {
            interrupt();
            llSay(board_control_channel, "2");
            llSay(base_npc_control_channel+1, "npc_cust_ask2_comment0");
            llSay(base_npc_control_channel+2, "npc_ask2");  
        }
        else if(message == "-ad_multimeter.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npc_empty");
            llSay(facil_control_channel, "-d6");
        }
        else if(message == "-ad_negative")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npc_ask4"); 
        }
        else if(message == "-ad_negative.r1.s1")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npc_ask4_resp0"); 
        }
        else if(message == "-ad_negative.r1.s2")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npc_ask4_resp1"); 
        }
        else if(message == "-ad_negative.r2.s1")
        {
            interrupt();
            llSay(facil_control_channel, "-d7");
            llSleep(4.0);
            llSay(base_npc_control_channel+7, "npc_ask4_resp0"); 
        }
        else if(message == "-ad_negative.r2.s2")
        {
            interrupt();
            llSay(facil_control_channel, "-d7");
            llSleep(4.0);
            llSay(base_npc_control_channel+7, "npc_ask4_resp1");
        }
        else if(message == "-d_current")
        {
            interrupt();
            llSay(facil_control_channel, "-d8");
        }
        else if(message == "-d_current.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d8!");//
        }  
        else if(message == "-ad_connected")
        {
            interrupt();
            llSay(board_control_channel, "0");
            llSay(base_npc_control_channel+6, "npc_cust_ask5_comment0"); 
            llSay(base_npc_control_channel+4, "npc_ask5"); 
        }
        else if(message == "-ad_connected.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npc_empty");
            llSay(facil_control_channel, "-d9"); 
        }

        else if(message == "-adnc_answer")
        {
            interrupt();
            llSay(board_control_channel, "1");
            llSay(base_npc_control_channel+3, "npc_ask6"); 
        }
        else if(message == "-adnc_answer.r1")
        {
            interrupt();
            llSay(base_npc_control_channel+3, "npc_empty");
            llSay(facil_control_channel, "-d10"); 
            llSleep(4.0);
            llSay(facil_control_channel, "-nc2"); 
        }
        else if(message == "-adnc_answer.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+3, "npc_empty");
            llSay(facil_control_channel, "-d10!"); 
            llSleep(4.0);
            llSay(facil_control_channel, "-nc2");
        }
        else if(message == "-cp_verify")
        {
            interrupt();
            llSay(facil_control_channel, "-d11");
        }
        else if(message == "-b_verify")
        {
            interrupt();
            // llSay(facil_control_channel, "-d");
        }       
        else if(message == "-d_verify")
        {
            interrupt();
            llSay(board_control_channel, "3");
            llSay(facil_control_channel, "-d21");
        }
        else if(message == "-d_verify.r2")
        {
            interrupt();
            llSay(facil_control_channel, "-d21!");
        }
        else if(message == "-ad_rheostat")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "npc_ask7"); 
        }
        else if(message == "-ad_rheostat.r1")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "npc_empty");
            llSay(facil_control_channel, "-d12"); 
        }
        else if(message == "-ad_rheostat.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+6, "npc_empty");
            llSay(facil_control_channel, "-d12!"); 
        }
        else if(message == "-ad_plot")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npc_cust_ask8_comment0"); 
            llSay(base_npc_control_channel+4, "npc_ask8"); 
        }
        else if(message == "-ad_plot.r1")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npc_empty");
            llSay(facil_control_channel, "-d13"); 
        }
        else if(message == "-ad_plot.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+4, "npc_empty");
            llSay(facil_control_channel, "-d13!"); 
        }
        else if(message == "-ad_measure")
        {
            interrupt();
            llSay(board_control_channel, "4");
            llSay(base_npc_control_channel+7, "npc_ask9"); 
        }
        else if(message == "-ad_measure.r1")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npc_empty");
            llSay(facil_control_channel, "-d14!"); 
        }
        else if(message == "-ad_measure.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+7, "npc_empty");
            llSay(facil_control_channel, "-d14"); 
        }
        else if(message == "-ad_line")
        {
            interrupt();
            llSay(board_control_channel, "5");
            llSay(base_npc_control_channel+1, "npc_ask10"); 
        }
        else if(message == "-ad_line.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+1, "npc_empty");
            llSay(facil_control_channel, "-d15!"); 
        }
        else if(message == "-d_over")
        {
            interrupt();
            llSay(facil_control_channel, "-d16!");
        }
        else if(message == "-ad_time")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npc_ask11"); 
        }
        else if(message == "-ad_time.r1")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay0");
            llSay(facil_control_channel, "-d17"); 
        }
        else if(message == "-ad_time.r2")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "npcsay1");
            llSay(facil_control_channel, "-d17!"); 
        }
        else if(message == "-d_feedback1")
        {
            interrupt();
            llSay(facil_control_channel, "-d18");
        }
        else if(message == "-d_feedback2")
        {
            interrupt();
            llSay(facil_control_channel, "-d19");
        }
        else if(message == "-d_completed")
        {
            interrupt();
            llSay(facil_control_channel, "-d20");
        }
    }
}