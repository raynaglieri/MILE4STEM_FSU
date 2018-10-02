integer flag = 0;
integer scenario_offset = 300000;
integer interact_with_lab_channel = 101;

set_offset()
{
   interact_with_lab_channel= 101 + scenario_offset;
}
on(){ 
    llSetColor(<1, 1, 1>, ALL_SIDES);
}



off(){
    llSetColor(<0, 0, 0>, ALL_SIDES);
}



default {
    state_entry(){   
        set_offset();
         llListen(interact_with_lab_channel, "", NULL_KEY, ""); 
    }     
    
    
    listen(integer channel, string name, key id, string message){
        if(channel == interact_with_lab_channel){
            if(message == "-alarm-on"){
                state AlarmOn;
            }
        }  
    }   
}  

state AlarmOn {
    state_entry(){
        llSetTimerEvent(1);
        llListen(interact_with_lab_channel, "", NULL_KEY, ""); 
    }

    timer(){
        if (flag++ %  2 == 0 ){
            llTriggerSound("FireAlarm", 1.0);
            on();
        } else {
            off();
            llStopSound();
        }   
    }
    
    listen(integer channel, string name, key id, string message){
        if(channel == interact_with_lab_channel){
            if ((message == "-reset") || (message == "-alarm-off")) {   
                llStopSound(); 
                off();
                state default;
            }  
        }   
    } 
}      