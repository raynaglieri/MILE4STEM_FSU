integer on = 0; 
integer scenario_offset = 300000;
integer interact_with_lab_channel = 101;

set_offset()
{
   interact_with_lab_channel= 101 + scenario_offset;
}
default {
    state_entry(){
         set_offset();
    }    
    
    touch_start(integer num_detected){        
        if(on){
            llSay(interact_with_lab_channel,"-reset");
            on = 0;
        }  else {
            llSay(interact_with_lab_channel, "-alarm-on");
            on = 1;
        }     
    }   
}