// change history:
//   November 2017: created by Raymond Naglieri
//   January 2017: updated various commands
//      --npclost: new animation
//      --longer delay between instructional break message and dialogue 
//      --message to whiteboard added to trigger hovering text.
//      --npc_bored_animation now provides random animations. 
//      --facildiscip command play animations forever until until facildiscip! command is called
//    2/15/18: various changes to match design docs
//    2/16/18: standard wait time between dialogue and actions implemented
//    3/01/18: Updated to match New NPC "Move" structure.
//    4/19/18: added interrupt command support. 

integer num_npc = 8;
integer scenario_offset = 200000;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer room_control_base_channel = 35000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer facil_capture_channel = -33156;
integer wait = 10;

set_offset()
{
    base_npc_control_channel = 31000 + scenario_offset;
    npc_para_control_base_channel = 32000 + scenario_offset;
    npc_action_control_base_channel = 33000 + scenario_offset;
    room_control_base_channel = 35000 + scenario_offset;
    backdoor_channel = 20001 + scenario_offset;
    facil_control_channel = 10101 + scenario_offset;
    facil_capture_channel = -33156 + scenario_offset;
}


integer random_integer(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
}

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
         llSay(base_npc_control_channel+i, "-stopanim_idle"); 
}

npc_hand_animation()
{
    integer i;
    for (i=0; i<num_npc; i++)
    {
        if(i != 4)
        {
            llSay(base_npc_control_channel+i, "-npcmove14");   
        }
        else llSay(npc_action_control_base_channel+i, "@Speak-no"); 
    }
}

npc_ask_animation()
{
    integer i;
    for (i=0; i<num_npc-6; i++)
    {
        if(random_integer(0,1))
            llSay(base_npc_control_channel+i, "-npcask3"); // ask(temp)
    }
}

follow_up_resp()
{
    integer i;
    for (i=0; i<num_npc; i++)
       llSay(base_npc_control_channel+i, "-npcfollow");    
}

npc_bored_animation() ///////////////////////////////////////////////////////////
{
    integer i;
    list bored_amims = ["avatar_impatient","avatar_express_bored", "avatar_express_sad", "avatar_express_shrug","avatar_express_shrug","Defensive"];
    list random_anim = llListRandomize(bored_amims, 1);
    integer random_index = 0;
    for (i=0; i<num_npc; i++)
    {
        if(random_integer(0,1))
               llSay(base_npc_control_channel+i, "-randanim_animhandle"); 
    }           
}

default
{
    state_entry()
    {
        set_offset();
        llListen(backdoor_channel, "", NULL_KEY, "");
    }   
    
    listen(integer channel, string name, key id, string message)
    {
        if (message == "-reset"){
            reset_to_start();
        } else if(message == "-halt"){
            interrupt();
            llSleep(2.0);
        } else if (message == "-npcr"){
            follow_up_resp();
        } else if (message == "-npcgroup"){
            interrupt();
            llSleep(2.0);
            npc_group();
        } else if (message == "-npcgs"){
            interrupt();
            llSleep(2.0);
            npc_group_speak(); 
        } else if (message == "-npcreturn"){
            interrupt();
            llSleep(2.0);
            npc_group_return();
        } else if (message == "-facilengage"){
            interrupt();
            llSleep(2.0);
            llSay(0,"Lecture in progress");
            llSay(facil_control_channel, "-d1");
            llSleep(wait);
            // llSay(npc_action_control_base_channel+3, "@Perform-avatar_express_wink"); 
            // llSay(npc_action_control_base_channel+4, "@Perform-avatar_express_sad");
            // llSay(npc_action_control_base_channel+7, "@Perform-Defensive");
            llSay(base_npc_control_channel+3, "-npcmove1"); 
            llSay(base_npc_control_channel+4, "-npcmove2");
            llSay(base_npc_control_channel+7, "-npcmove3");
            //npc_wait_animation();
        } else if (message == "-facilengage!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d1!"); 
        } else if (message == "-facilsit"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d2");
        } else if (message == "-facilsit!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d2!");
        } else if (message == "-facilcog"){ ///////////////////////////////////////////////////////////
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d3");
            llSleep(wait);
            // llSay(npc_action_control_base_channel+3, "@Perform-avatar_no_unhappy");
            // llSay(npc_action_control_base_channel+7, "@Perform-avatar_no_unhappy");
            llSay(base_npc_control_channel+3, "-npcmove4");
            llSay(base_npc_control_channel+7, "-npcmove5");
            // npc_wait_animation();
        } else if (message == "-facilcog!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d3!");
        } else if (message == "-facilprefer"){ // say
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d4");
            llSleep(wait);
            llSay(npc_action_control_base_channel+2, "@SpeakList-Did we get the handouts#1::I understand better when I read the handouts#5");
            llSay(npc_para_control_base_channel+3, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+3, "@Speak-Why do you need them?");
        } else if (message == "-facilprefer!"){ // say
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d4!");
        } else if (message == "-facilgrade"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d5");
            llSleep(wait);
            llSay(0, "Instructional break");
            llSleep(wait);
            llSay(npc_action_control_base_channel+4, "@Speak-Do we get additional points for the questions we have answered in previous lecture?");
            llSay(npc_para_control_base_channel, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel, "@Speak-They were not about our subject matter – chill out!");
        } else if (message == "-facilgrade!"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Instructional break");
            llSay(facil_control_channel, "-d5!");
        } else if (message == "-facilident"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d6");
            llSleep(wait);
            npc_bored_animation();
            //npc_wait_animation();
        } else if (message == "-facilident!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d6!");
            npc_stop_animation();
        } else if (message == "-facilemot"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d7");
            llSleep(wait);
            llSay(npc_action_control_base_channel+5, "@Speak-It’s quite boring.");
            llSay(npc_para_control_base_channel+6, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+6, "@Speak-and not well structured.");
        } else if (message == "-facilemot!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d7!");
        } else if (message == "-facildiscip"){ //*****************************************************************************
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d8");
            llSleep(wait);
            //llSay(npc_action_control_base_channel+6, "@Speak-we do it differently in mathematics");
            // llSay(npc_action_control_base_channel+6, "@Perform-avatar_express_wink");
            // llSay(npc_action_control_base_channel+5, "@Perform-avatar_express_sad");
            llSay(base_npc_control_channel+6, "-npcmove6");
            llSay(base_npc_control_channel+5, "-npcmove7");
            //npc_bored_animation();
        } else if (message == "-facildiscip!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d8!");
            llSay(base_npc_control_channel+6, "-stopanim_idle");
            llSay(base_npc_control_channel+5, "-stopanim_idle");
        } else if (message == "-facilcovered"){
            interrupt();
            llSleep(2.0);
            llSay(base_npc_control_channel+6, "-stopanim_idle");
            llSay(base_npc_control_channel+5, "-stopanim_idle");
            llSay(facil_control_channel, "-d9");
            llSleep(wait);
            llSay(npc_action_control_base_channel, "@Speak-we have already had the point TA is covering now two weeks ago");
        } else if (message == "-facilcovered!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d9!");
        } else if (message == "-facilhand"){ // 
            interrupt();
            llSleep(2.0);
            npc_hand_animation();
            llSay(facil_control_channel, "-d10");
        } else if (message == "-facilhand!"){ // 
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d10!");
        } else if (message == "-facilvisual"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d11");
            llSleep(wait);
            llSay(npc_action_control_base_channel, "@Speak-we don’t understand anything");
            llSay(npc_para_control_base_channel, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+6, "@Speak-we are visual learners!");
        } else if (message == "-facilvisual!"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d11!");
        } else if (message == "-facildisap"){///////////////////////////////////////////////////////////
            interrupt();
            llSleep(2.0);
            llSay(0, "Now its time to talk about quiz results");
            llSay(facil_control_channel, "-d12");
            //llSay(room_control_base_channel, "-showfloattext");
            //llSay(npc_action_control_base_channel+7, "@Perform-avatar_express_sad");
            llSay(base_npc_control_channel+7, "-npcmove8");
            //npc_wait_animation(); 
        } else if (message == "-facildisap!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d12!");
        } else if (message == "-facilnohands"){ 
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d13");
        } else if (message == "-facilnohands!"){ 
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d13!");
        } else if (message == "-facilhands"){
            interrupt();
            llSleep(2.0);
            npc_ask_animation();
            llSay(facil_control_channel, "-d14");
        } else if (message == "-facilhands!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-d14!");
        } else if (message == "-npcss"){
            interrupt();
            llSleep(2.0);
            npc_show_state();
        } else if (message == "-npcquiz"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            //////////////////////////////////////////////////
        } else if (message == "-npclost"){//************************************************************
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            llSay(npc_action_control_base_channel+3, "@Speak-I thought I got lost for a second, I'm ok now");
            //llSay(npc_action_control_base_channel+7, "@Perform-Okay_nodding");
            llSay(base_npc_control_channel+7, "-npcmove9");
            //npc_wait_animation();
        } else if (message == "-npcunderstand"){ 
            interrupt();
            llSleep(2.0);
            llSay(base_npc_control_channel+4, "-npcask2");
        } else if (message == "-npcunderstand!"){ 
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-dw2");
        } else if (message == "-npctoofast"){
            interrupt();
            llSleep(2.0);
            llSay(base_npc_control_channel+7, "-npcask");
        } else if (message == "-npctoofast!"){ 
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-dw1");
        } else if (message == "-npcargue"){ //*********************************************************************
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            // llSay(npc_action_control_base_channel+2, "@SpeakAnim-TA said this goes after that::avatar_point_me::15::3");
            // llSay(npc_action_control_base_channel+3, "@SpeakAnim-no, that goes after that::avatar_express_shrug::15::3");
            llSay(base_npc_control_channel+2, "-npcmove10");
            llSay(base_npc_control_channel+3, "-npcmove11");
        } else if (message == "-npcargue!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-dw3"); 
        } else if (message == "-npclostprev"){
            interrupt();
            llSleep(2.0);
            llSay(npc_action_control_base_channel+2, "@Speak-We got lost about what you have said in a previous part");
        } else if (message == "-npclostprev!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-dw4"); 
        } else if (message == "-npcatten"){ //*********************************************************************
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            //llSay(npc_action_control_base_channel+4, "@SpeakAnim-why are we doing this::avatar_express_bored::15::1");
            llSay(base_npc_control_channel+4, "-npcmove12");
            npc_wait_animation();  
        } else if (message == "-npcatten!"){ 
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-dw5");  
        } else if (message == "-npcquestions"){
            //npc_hand_animation();
            interrupt();
            llSleep(2.0);
            llSay(base_npc_control_channel+7, "-npcask3"); // ask(temp)
            llSay(base_npc_control_channel+3, "-npcask3"); // ask(temp)
        } else if (message == "-npcquestions!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-dw6");
        } else if (message == "-announce1"){
            interrupt();
            llSleep(2.0);
            llSay(0,"It's a time to present your students with a prepared example");
        } else if (message == "-announce1!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-a1!");
            //llSay(0, "It's time to presemt your students with a prepared example.");
        } else if (message == "-announce2"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-a2"); 
        } else if (message == "-announce3"){
            interrupt();
            llSleep(2.0);
            llSay(0, "Lecture has concluded");
            llSay(0, "Ask your students if they have questions");
            //llSay(facil_control_channel, "-a3"); 
        } else if (message == "-announce3!"){
            interrupt();
            llSleep(2.0);
            llSay(facil_control_channel, "-a3!"); 
        } else if (message == "-cmdanim1"){
            interrupt();
            llSleep(2.0);
            llSay(base_npc_control_channel+0, "-testcmdanim1");
        } else if (message == "-cmdanim2"){
            interrupt();
            llSleep(2.0);
            llSay(base_npc_control_channel+0, "-testcmdanim2");
        }
    }
} 
