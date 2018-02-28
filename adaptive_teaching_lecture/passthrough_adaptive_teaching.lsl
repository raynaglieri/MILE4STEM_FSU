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
integer num_npc = 8;
integer base_npc_control_channel = 31000;
integer npc_para_control_base_channel = 32000;
integer npc_action_control_base_channel = 33000;
integer room_control_base_channel = 35000;
integer backdoor_channel=20001;
integer facil_control_channel = 10101;
integer wait = 10;

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
    list bored_amims = ["avatar_impatient","avatar_express_bored", "avatar_express_sad", "avatar_express_shrug","avatar_express_shrug","Defensive"];
    list random_anim = llListRandomize(bored_amims, 1);
    integer random_index = 0;
    for (i=0; i<num_npc; i++)
    {
        random_index =  random_integer(0,2);
        if(random_integer(0,1))
            llSay(npc_action_control_base_channel+i, "@Perform-" + llList2String(random_anim,random_index));  
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
        if (message == "-reset"){
            reset_to_start();
        } else if (message == "-npcgroup"){
            npc_group();
        } else if (message == "-npcgs"){
            npc_group_speak(); 
        } else if (message == "-npcreturn"){
            npc_group_return();
        } else if (message == "-facilengage"){
            llSay(0,"Lecture in progress");
            llSay(facil_control_channel, "-d1");
            llSleep(wait);
            llSay(npc_action_control_base_channel+3, "@Perform-avatar_express_wink");
            llSay(npc_action_control_base_channel+4, "@Perform-avatar_express_sad");
            llSay(npc_action_control_base_channel+7, "@Perform-Defensive");
            npc_wait_animation();
        } else if (message == "-facilengage!"){
            llSay(facil_control_channel, "-d1!"); 
        } else if (message == "-facilsit"){
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d2");
        } else if (message == "-facilsit!"){
            llSay(facil_control_channel, "-d2!");
        } else if (message == "-facilcog"){
            llSay(facil_control_channel, "-d3");
            llSleep(wait);
            llSay(npc_action_control_base_channel+3, "@Perform-avatar_no_unhappy");
            llSay(npc_action_control_base_channel+7, "@Perform-avatar_no_unhappy");
            npc_wait_animation();
        } else if (message == "-facilcog!"){
            llSay(facil_control_channel, "-d3!");
        } else if (message == "-facilprefer"){ // say
            llSay(facil_control_channel, "-d4");
            llSleep(wait);
            llSay(npc_action_control_base_channel+2, "@SpeakList-Did we get the handouts#1::I understand better when I read the handouts#5");
            llSay(npc_para_control_base_channel+3, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+3, "@Speak-Why do you need them?");
        } else if (message == "-facilprefer!"){ // say
            llSay(facil_control_channel, "-d4!");
        } else if (message == "-facilgrade"){
            llSay(facil_control_channel, "-d5");
            llSleep(wait);
            llSay(0, "Instructional break");
            llSleep(wait);
            llSay(npc_action_control_base_channel+4, "@Speak-Do we get additional points for the questions we have answered in previous lecture?");
            llSay(npc_para_control_base_channel, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel, "@Speak-They were not about our subject matter – chill out!");
        } else if (message == "-facilgrade!"){
            llSay(0, "Instructional break");
            llSay(facil_control_channel, "-d5!");
        } else if (message == "-facilident"){
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d6");
            llSleep(wait);
            npc_bored_animation();
            npc_wait_animation();
        } else if (message == "-facilident!"){
            llSay(facil_control_channel, "-d6!");
        } else if (message == "-facilemot"){
            llSay(facil_control_channel, "-d7");
            llSleep(wait);
            llSay(npc_action_control_base_channel+5, "@Speak-It’s quite boring.");
            llSay(npc_para_control_base_channel+6, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+6, "@Speak-and not well structured.");
        } else if (message == "-facilemot!"){
            llSay(facil_control_channel, "-d7!");
        } else if (message == "-facildiscip"){
            llSay(facil_control_channel, "-d8");
            llSleep(wait);
            llSay(npc_action_control_base_channel+6, "@Speak-we do it differently in mathematics");
            llSay(npc_action_control_base_channel+6, "@Perform-avatar_express_wink");
            llSay(npc_action_control_base_channel+5, "@Perform-avatar_express_sad");
            //npc_bored_animation();
        } else if (message == "-facildiscip!"){
            llSay(facil_control_channel, "-d8!");
            npc_stop_animation();
        } else if (message == "-facilcovered"){
            llSay(facil_control_channel, "-d9");
            llSleep(wait);
            llSay(npc_action_control_base_channel, "@Speak-we have already had the point TA is covering now two weeks ago");
        } else if (message == "-facilcovered!"){
            llSay(facil_control_channel, "-d9!");
        } else if (message == "-facilhand"){ // 
            npc_hand_animation();
            llSay(facil_control_channel, "-d10");
        } else if (message == "-facilhand!"){ // 
            llSay(facil_control_channel, "-d10!");
        } else if (message == "-facilvisual"){
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d11");
            llSleep(wait);
            llSay(npc_action_control_base_channel, "@Speak-we don’t understand anything");
            llSay(npc_para_control_base_channel, "@Setwait_talk 2");
            llSay(npc_action_control_base_channel+6, "@Speak-we are visual learners!");
        } else if (message == "-facilvisual!"){
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-d11!");
        } else if (message == "-facildisap"){
            llSay(0, "Now its time to talk about quiz results");
            llSay(facil_control_channel, "-d12");
            //llSay(room_control_base_channel, "-showfloattext");
            llSay(npc_action_control_base_channel+7, "@Perform-avatar_express_sad");
            npc_wait_animation(); 
        } else if (message == "-facildisap!"){
            llSay(facil_control_channel, "-d12!");
        } else if (message == "-facilnohands"){ 
            llSay(facil_control_channel, "-d13");
        } else if (message == "-facilnohands!"){ 
            llSay(facil_control_channel, "-d13!");
        } else if (message == "-facilhands"){
            npc_ask_animation();
            llSay(facil_control_channel, "-d14");
        } else if (message == "-facilhands!"){
            llSay(facil_control_channel, "-d14!");
        } else if (message == "-npcss"){
            npc_show_state();
        } else if (message == "-npcquiz"){
            llSay(0, "Lecture continues");
            //////////////////////////////////////////////////
        } else if (message == "-npclost"){
            llSay(0, "Lecture continues");
            llSay(npc_action_control_base_channel+3, "@Speak-I thought I got lost for a second, ok now");
            llSay(npc_action_control_base_channel+7, "@Perform-Okay_nodding");
            npc_wait_animation();
        } else if (message == "-npcunderstand"){ 
            llSay(base_npc_control_channel+4, "-npcask2");
        } else if (message == "-npcunderstand!"){ 
            llSay(facil_control_channel, "-dw2");
        } else if (message == "-npctoofast"){
            llSay(base_npc_control_channel+7, "-npcask");
        } else if (message == "-npctoofast!"){ 
            llSay(facil_control_channel, "-dw1");
        } else if (message == "-npcargue"){
            llSay(0, "Lecture continues");
            llSay(npc_action_control_base_channel+2, "@SpeakAnim-TA said this goes after that::avatar_point_me::15::3");
            llSay(npc_action_control_base_channel+3, "@SpeakAnim-no, that goes after that::avatar_express_shrug::15::3");
        } else if (message == "-npcargue!"){
            llSay(facil_control_channel, "-dw3"); 
        } else if (message == "-npclostprev"){
            llSay(npc_action_control_base_channel+2, "@Speak-We got lost about what you have said in a previous part");
        } else if (message == "-npclostprev!"){
            llSay(facil_control_channel, "-dw4"); 
        } else if (message == "-npcatten"){
            llSay(0, "Lecture continues");
            llSay(npc_action_control_base_channel+4, "@SpeakAnim-why are we doing this::avatar_express_bored::15::1");
            // llSay(npc_action_control_base_channel+4, "@Speak-why are we doing this");
            // llSay(npc_action_control_base_channel+4, "@Perform-avatar_express_bored");
            npc_wait_animation();  
        } else if (message == "-npcatten!"){
            llSay(0, "Lecture continues");
            llSay(facil_control_channel, "-dw5");  
        } else if (message == "-npcquestions"){
            //npc_hand_animation();
            llSay(base_npc_control_channel+7, "-npcask3"); // ask(temp)
            llSay(base_npc_control_channel+3, "-npcask3"); // ask(temp)
        } else if (message == "-npcquestions!"){
            llSay(facil_control_channel, "-dw6");
        } else if (message == "-announce1"){
            llSay(0,"It's a time to present your students with a prepared example");
        } else if (message == "-announce1!"){
            llSay(facil_control_channel, "-a1!");
            llSay(0, "It's time to presemt your students with a prepared example.");
        } else if (message == "-announce2"){
            llSay(facil_control_channel, "-a2"); 
        } else if (message == "-announce3"){
            llSay(0, "Lecture has concluded");
            llSay(0, "Ask your students if they have questions");
            //llSay(facil_control_channel, "-a3"); 
        } else if (message == "-announce3!"){
            llSay(facil_control_channel, "-a3!"); 
        }

    }
} 
