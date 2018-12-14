// change history:
//   November 2017: created by Raymond Naglieri
//      04/27/18 - updated to support interrupts. Now supports the ability to delay a command.
//      05/05/18 - modified for problem solving lecture
//  
integer num_npc = 8;
integer scenario_offset = 700000;
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
        } 
        else if(message == "-2default")
        {
            interrupt();
            multi_command("-goto:default", [0,1,2,3,4,5,6,7]);
        }
        else if(message == "-d_explain")
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
        }
        else if(message == "-d_explain!")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");
        }
        else if(message == "-d_engaged")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }
        else if(message == "-ad_engaged")
        {
            interrupt();
            llSay(base_npc_control_channel+0, "npccustanim"); 
            llSay(base_npc_control_channel+4, "npccustanim"); 
            llSay(base_npc_control_channel+5, "npccustanim");
            llSay(facil_control_channel, "-d2");
        }
        else if(message == "-ad_engaged!")
        {
            llSay(facil_control_channel, "-d2!");
        }
        else if(message == "-ad_interest")
        {
            multi_command("-goto:default", [0,4,5]);
            llSleep(1.0);
            llSay(base_npc_control_channel+4, "npcsay0");
            llSleep(2.0); 
            llSay(base_npc_control_channel+6, "npcsay1"); 
            llSleep(2.0); 
            llSay(facil_control_channel, "-d3");
        }
        else if(message == "-ad_cognitive")
        {
            llSay(base_npc_control_channel+3, "npcanim1");
            llSay(base_npc_control_channel+7, "npcanim1"); 
            llSleep(2.0); 
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-ad_cognitive!")
        {
            llSay(facil_control_channel, "-d4!");
        }
        else if(message == "-ad_lost")
        {
            llSay(base_npc_control_channel+3, "npcsay2");
            llSleep(2.0);
            llSay(base_npc_control_channel+7, "npcanim2"); 
        }
        else if(message == "-ad_confused") 
        {
            llSay(base_npc_control_channel+6, "npccustanim"); 
            llSay(base_npc_control_channel+0, "npccustanim"); 
            llSay(base_npc_control_channel+4, "npccustanim"); 
            llSay(base_npc_control_channel+3, "npccustanim"); 
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-ad_cues") 
        {
            multi_command("-goto:default", [0,3,4,6]);
            llSay(base_npc_control_channel+5, "npcsay3"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+6,"npcaction0");
            llSay(facil_control_channel, "-d6");
        }
        else if(message == "-ad_cues!") 
        {
            llSay(facil_control_channel, "-d6!");
        }
       else if(message == "-ad_diff") 
        {
            llSay(base_npc_control_channel+6, "npcsay4"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+2, "npcsay5"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+1, "npcsay6"); 
            llSleep(2.0);
            llSay(base_npc_control_channel+2, "npcsay7"); 
            llSleep(2.0);
            llSay(facil_control_channel, "-d7");
        }
        else if(message == "-ad_diff!") 
        {
            llSay(facil_control_channel, "-d7!");
        }
        else if(message == "-ad_speed") 
        {
            llSay(base_npc_control_channel+7,"npcask0");
        }
        else if(message == "-ad_speed!") 
        {
            llSay(facil_control_channel, "-d8!");
        }
        else if(message == "-ann_present") 
        {
            llSay(0,"It's time to present your students with an example of how to use malloc.");
        }
        else if(message == "-ann_present!") 
        {
            llSay(facil_control_channel, "-d9!");
        }
        else if(message == "-ad_example") 
        {
            llSay(base_npc_control_channel+4,"npcask1");
        }
        else if(message == "-ad_example!") 
        {
            llSay(facil_control_channel, "-d10!");
        }
        else if(message == "-ad_prev") 
        {
            llSay(base_npc_control_channel+0,"npcsay9");
            llSleep(2.0);
            llSay(base_npc_control_channel+1,"npcsay9");
            llSleep(2.0);
            llSay(base_npc_control_channel+0,"npcsay10");
            llSay(facil_control_channel, "-d11");
        }
        else if(message == "-ad_prev!") 
        {
            llSay(facil_control_channel, "-d11!");
        }
        else if(message == "-ad_similar") 
        {
            multi_command("npcaction1", [0,1,2,3,5,6,7]);
            llSay(base_npc_control_channel+4,"npcsay17");
            llSleep(2.0);
            llSay(facil_control_channel, "-d12");
        }
        else if(message == "-ad_similar!") 
        {
            llSay(facil_control_channel, "-d12!");
        }
        else if(message == "-ad_alt") 
        {
            llSay(base_npc_control_channel+4,"npcsay10");
            llSleep(2.0);
            llSay(base_npc_control_channel+0,"npcsay11");
            llSay(facil_control_channel, "-d13");
            llSleep(2.0);
            llSay(facil_control_channel, "-nc1");
        }
        else if(message == "-ad_visual") 
        {
            llSay(base_npc_control_channel+0,"npcsay12");
            llSleep(2.0);
            llSay(base_npc_control_channel+6,"npcsay13");
            llSay(facil_control_channel, "-d14");
        }
        else if(message == "-ad_visual!") 
        {
            llSay(facil_control_channel, "-d14!");
        }
        else if(message == "-ad_cultures") 
        {
            llSay(base_npc_control_channel+6,"npcsay14");
            llSleep(2.0);
            llSay(base_npc_control_channel+6,"npccustanim");
            llSay(facil_control_channel, "-d15");
        }
        else if(message == "-ad_cultures!") 
        {
            llSay(facil_control_channel, "-d15!");
        }
        else if(message == "-ad_why") 
        {
            llSay(base_npc_control_channel+6, "-goto:default");
            llSay(base_npc_control_channel+4,"npcsay16");
        }
        else if(message == "-ad_why!") 
        {
            llSay(facil_control_channel, "-d16!");
        }
        else if(message == "-d_quiz") 
        {
            llSay(facil_control_channel, "-d17");
        }  
        else if(message == "-ad_quiz")
        {  
            llSay(base_npc_control_channel+2,"npcaction2");
            llSleep(2.0);
            llSay(facil_control_channel, "-d18");
        }
        else if(message == "-ann_finish") 
        {  
            llSay(0,"Lecture is finished, Ask your students if they have questions.");
        }
        else if(message == "-ann_finish!") 
        {  
            llSay(facil_control_channel, "-d19!");
        }
        else if(message == "-d_understand") 
        {  
            llSay(facil_control_channel, "-d20");
        }
        else if(message == "-d_understand!") 
        {  
            llSay(facil_control_channel, "-d20!");
        }
        else if(message == "-ad_hands") 
        {
            llSay(base_npc_control_channel+2,"npcaction3");
            llSleep(2.0);
            llSay(base_npc_control_channel+3,"npcaction4");
        }
        else if(message == "-ad_hands!") 
        {
            llSay(facil_control_channel, "-d21!");
        }
        else if(message == "-ad_complex") 
        {
            llSay(base_npc_control_channel+2,"npcsay15");
        }
        else if(message == "-ad_complex!") 
        {
            llSay(facil_control_channel, "-d22!");
        }
        else if(message == "-ad_questions") 
        {
            llSay(base_npc_control_channel+1,"npcask5");
            llSay(base_npc_control_channel+7,"npcask5");
            llSay(facil_control_channel, "-d23");
        }
        else if(message == "-ad_drop") 
        {
            multi_command("-goto:default", [1,7]);
        }

    }
}