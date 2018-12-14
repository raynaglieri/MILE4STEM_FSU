//  CREATED BY: Raymond Naglieri on 11/01/18
// DESCRIPTION: Play various ambient sounds triggered by a faciltator. 
//         LOG: 11/26/2018 - Added timeout to prevent audio from looping forever.
//

integer scenario_offset = 0;
integer facil_capture_control_channel = -33156;
integer sound_channel = -44;
integer backdoor_channel=20001;

string current_sound = "null";
float  audio_timeout = 900.0;
set_offset(){
    sound_channel = -44 + scenario_offset; 
    backdoor_channel = 20001 + scenario_offset;
}

command_interface(string command){
    if(command == "crowd_noise") {
        current_sound = command;
        llLoopSound(current_sound, 1.0);
    }else if(command == "stop"){
        llStopSound();
    }
}

default
{
    state_entry(){
        set_offset();
        llSetTimerEvent(audio_timeout);
        llListen(facil_capture_control_channel, "", NULL_KEY, "");
    }

    touch_start(integer num_detected){
        llDialog(llDetectedKey(0), "Sound Script active.", ["Okay"], PUBLIC_CHANNEL);
    }

    timer()
    {
       llStopSound();
       current_sound = "null"; 
    }

    listen(integer channel, string name, key id, string message){
        if (channel == facil_capture_control_channel){
            command_interface(message);
        }    
    }

}




