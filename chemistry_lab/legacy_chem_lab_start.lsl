// change history:
//   September 2017: created by Raymond Naglieri in September 2017 to implement Zhaihuan's 
//      chemistry flowchart
//   10/14/2017, fixed channel numbering issue  -- XY
//   10/14/2017, added a dialog box to confirm the identity of the trainee -- XY
//   10/28/2017, clean up unused variables -- XY
//   

key trainee= NULL_KEY;

// constants used acrosss all scripts
integer button_to_facil_channel = 11500;   // chat channel from green button to facil
integer button_to_npc_channel = -35145;  // button to npc_channel
integer local_dialog_channel = 11002;     // this number should be different for 
                                          // different scripts 
                                         
default{    
    state_entry(){  
        llListen(local_dialog_channel, "", NULL_KEY, "");
    }   
        
    touch(integer num_detected){
        key kk;
        kk = llDetectedKey(0);
        if (trainee == NULL_KEY)
            llDialog(kk, "Are you the TA trainee? Are you sure you want to start a session?", 
            ["Yes", "No"], local_dialog_channel);        
        else llDialog(kk, "Are you the TA trainee? Are you sure you want to start a session? The session must be in the initial state (reset with the backdoor) before you can start a new session.", 
                 ["Yes", "No" ] , 
                 local_dialog_channel);
    }
    
    listen(integer c, string n, key ID, string msg){
        if (c == local_dialog_channel) {
            if (msg == "Yes") { 
                trainee = ID;
                llSay(button_to_facil_channel, trainee);
                llSay(button_to_npc_channel, "-spawn");
            }
        }
    } 
    
}

    