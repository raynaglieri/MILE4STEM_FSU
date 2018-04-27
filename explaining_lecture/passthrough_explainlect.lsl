// change history:
//   November 2017: created by Raymond Naglieri
//  4/10/18 - added reset for facil capture
//  4/27/18 - updated to support interrupts. Now supports the ability to delay a command. Matches new design
integer num_npc = 8;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_capture_channel = -33156;

string delayed_command = "NULL";
integer dc_is_action = 0;
integer dc_npc_offset = 0;

interrupt()
{
    llSetTimerEvent(0.0);
    delayed_command = "NULL";
    integer i;
    for (i=0; i<num_npc; i++)
        llSay(base_npc_control_channel+i, "-interrupt");
    llSleep(2.0); 
}  

reset_to_start() 
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-reset");
    llSay(facil_control_channel, "-reset");  
    llSay(facil_capture_channel, "-reset");  

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

follow_up_resp()
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-npcfollow");    
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
            follow_up_resp();
        }  
        else if (message == "-ad_drawmap")
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
            llSay(base_npc_control_channel+3, "-npcresp");
            llSay(base_npc_control_channel+2, "-npcask");
          

        } 
        else if (message == "-ad_promoteunder")
        {
            interrupt();
            llSay(facil_control_channel, "-d3");
            llSay(npc_action_control_base_channel+4, "@Speak-I'm still lost. Can you give us an example?");  
        }
        else if (message == "-a_lost")
        {
            interrupt();
            llSay(npc_action_control_base_channel+0, "@Speak-Now, with a concept map I understand it better.");
            llSay(npc_para_control_base_channel+4, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+4, "@Speak-And I don't. I don't even understand what parts of the concept TA is using");
            dc_is_action = 0;
            dc_npc_offset = 4;
            delayed_command = "-npcask2";
            llSetTimerEvent(2.0);
        } 
        else if(message == "-anc_cont")
        {
            interrupt();
            llSay(0,"Lecture continues.");
        }    
        else if(message == "-d_drawmap!")
        {
            interrupt();
            llSay(facil_control_channel, "-d1!");
        }
        else if(message == "-d_lost")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }   
        else if(message == "-d_lost!")
        {
            interrupt();
            llSay(facil_control_channel, "-d2!");
        }    
        else if(message == "-d_promoteunder!")
        {
            interrupt();
            llSay(facil_control_channel, "-d3!");
        }                
        else if(message == "-d_analyze")
        {
            interrupt();
            llSay(facil_control_channel, "-d5");
        }
        else if(message == "-d_analyze!")
        {
            interrupt();
            llSay(facil_control_channel, "-d5!");
        }
        else if(message == "-d_anotherway")
        {
            interrupt();
            llSay(facil_control_channel, "-d6");
        }
        else if(message == "-d_anotherway!")
        {
            interrupt();
            llSay(facil_control_channel, "-d6!");
        }
        else if(message == "-d_final")
        {
            interrupt();
            llSay(facil_control_channel, "-d7");
        }
    }
} 
