// change history:
//   November 2017: created by Raymond Naglieri
//  4/10/18 - added reset for facil capture
integer num_npc = 8;
integer base_npc_control_channel = 31000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_capture_channel = -33156;

interrupt()
{
    integer i;
    for (i=0; i<num_npc; i++)
        llSay(base_npc_control_channel+i, "-interrupt"); // ask(temp)
    
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

default
{
    state_entry()
    {
        llListen(backdoor_channel, "", NULL_KEY, "");
    }   
    
    listen(integer channel, string name, key id, string message)
    {
        if (message == "-reset"){
            reset_to_start();
        } 
        else if (message == "-a_askmetaphor")
        {
            interrupt();
            llSay(base_npc_control_channel+2, "-npcask");
        } 
        else if (message == "-a_groupact")
        {
            interrupt();
            npc_group(); 
        } 
        else if (message == "-a_g1explainloss")
        {
            interrupt();
            llSay(base_npc_control_channel+1, "-npcask2");
        }
        else if (message == "-a_g2explainloss")
        {
            interrupt();
            llSay(base_npc_control_channel+5, "-npcask3");
        }
        else if (message == "-npcreturn")
        {
            interrupt();
            npc_group_return();
        } 
        else if(message == "-anc_groupup")
        {
            interrupt();
            llSay(0, "The students have to break on two groups and compete in giving a good metaphor for **your choice**, **whatever you will be covering in the lecture**."); 
            llSay(0, "Assign neighboring students to the same group."); 
            llSay(0, "Students can use physical objects at the side table as needed.");
        }
        else if(message == "-anc_cont")
        {
            interrupt();
            llSay(0,"Lecture continues.");
        }
        else if(message == "-d_groupup")
        {
            interrupt();
            llSay(facil_control_channel, "-d0");
        }
        else if(message == "-d_groupup!")
        {
            interrupt();
            llSay(facil_control_channel, "-d0w");
        }
        else if(message == "-d_giveexample")
        {
            interrupt();
            llSay(facil_control_channel, "-d1");
        }
        else if(message == "-d_choosewinner")
        {
            interrupt();
            llSay(facil_control_channel, "-d2");
        }       
        else if(message == "-d_explainloss")
        {
            interrupt();
            llSay(facil_control_channel, "-d3");
        }        
        else if(message == "-d_promoteunder")
        {
            interrupt();
            llSay(facil_control_channel, "-d4");
        }
        else if(message == "-d_promoteunder!")
        {
            interrupt();
            llSay(facil_control_channel, "-d4!");
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
