set_ask_settings(integer swq, integer snr, list so, integer srn, integer kma, integer eoi, integer sac)
{
    speak_with_question = swq;
    signal_npc_reponse = snr;
    signal_offsets = so;
    signal_response_num = srn;
    keyword_match_amount = kma;
    exit_on_incorrect = eoi;
    signal_action_complete = sac;
}

set_response_settings(integer sqr, integer sd, integer rso, string st)
{

    speak_with_response = sqr;
    speech_delay = sd;
    resp_signal_offset = rso;
    say_this = st;
}

if(signal_npc_reponse)
{
    integer i = 0;
    for(i = 0; i < llGetListLength(signal_offsets); i++)
    {
        if(signal_response_num = 1)
            llSay(scenario_send_base_channel+ 1, llList2String(signal_offsets, i)+":"+(string)myid); 
        else
            llSay(scenario_send_base_channel + 2, llList2String(signal_offsets, i)+":"+(string)myid); // incrementing offers different reponse options
    }        

    state WaitSignal;    
}


if(exit_on_incorrect)
{
    if(signal_action_complete)
    {
        llSay(auto_facil_control_channel, "-ac");
    }
    state Idle;
}

        if(directive == "1" && myid == 3) 
        {
            correct_response = "Yes, it's the same but the resistors have different resistances.";
            gen_response = ""; 
            set_response_settings(1, 5 , 1, llList2String(npc_lab_sounds, 0));
        }
        else if(directive == "2" && myid == 6) 
        {
            correct_response = "Yes, it's the same but the resistors have different resistances.";
            gen_response = ""; 
            set_response_settings(1, 5 , 4, llList2String(npc_lab_sounds, 0));
        }

integer question_inbounds(integer index)
{

}
integer npc_speech_inbounds(integer index)
{
	if(index < llGetListLength(npc_lab_sounds) && index >= 0)
		return 1;
	return 0;
}
integer corr_response_inbounds(integer index)
{
    if(index < llGetListLength(correct_responses) && index > 0)
        return 1;
    return 0; 
}

integer gen_response_inbounds(integer index)
{
    if(index < llGetListLength(gen_responses) && index > 0)
        return 1;
    return 0; 
}

integer npc_response_inbounds(integer index)
{
    if(index < llGetListLength(npc_to_npc_reponses) && index > 0)
        return 1;
    return 0; 
}

integer random_integer(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1));
}

list keywords_multimeter = ["$%&", "wire", "connect", "wires" , "connected"];
list keywords_series = ["$%&", "series", "one after another"];
list keywords_resistors = ["parallel", "simultaneous", "repeat the formula" ];
list keywords_kirchoff = ["loop", "kirchoff's rules", "kirchoffs rules", "repeat the rules"];
list keywords_polarity = ["polarity", "ampere", "current", "kirchoff's rules", "kirchoffs rules", "repeat the rules"];
list keywords_extratime = ["you", "can", "have"];
list keywords_yes_no = ["yes", "no"];
list keywords_current = []; // active keywords