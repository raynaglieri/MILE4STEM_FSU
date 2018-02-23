//Created by Raymond Naglieri 
integer game_button_channel = -501;
integer game_text_channel = -500;

vector COLOR_GREEN = <0.0, 1.0, 0.0>;
vector COLOR_BLUE = <0.0, 0.0, 1.0>;
float  OPAQUE = 1.0;
float TRANSPARENT = 0.0;

integer internal_state = 0;

key player = NULL_KEY;

string r1 = "Now you presenting a \nlecture on TBD to your students. \n What preparation steps did \nyou take to address \nstudents diversity?";

string r2 = "Are you prepared to modify \nthe content sequence as \nneeded or repeat some \nparts of the content?";
string r2n = "Students’ learning will \nbe more effective if \nthe parts of the \ncontent are logically connected \nbetween themselves and well \nunderstood by all the learners.";
string r2y = "Great!  It is especially \nimportant if one part \nof the content builds \non understanding of the \nprevious part.";

string r3 = "Are you prepared to end \nthe class earlier than expected \neven if you have not \nfinished the content planned?";
string r3n = "You need to think about \n thorough content planning \n and possible adjustments you \nmight need to do \n for diverse learners \nto be fully prepared for \nyour lecture.";
string r3y = "Wonderful! You should always \nuse a thorough content planning \nfor your lecture as you might \nneed to do some adjustments \nand account for a diversity \nof learners you are teaching.";

string r4 = "Did you prepare alternative \nmodes / medias for instructional \nmaterials?";
string r4n = "Could you think of some?";
string r4y = "Great! Presenting students \nwith alternative modes of \ndelivery helps addressing  \nvarious learning strategies.";

string r5 = "Are you prepared to use \nalternative learning activities \n to address varied levels \nof a prior knowledge of \nyour learners?";
string r5n = "It is always a good practice \nto have a large spectrum \nof activities.";
string r5y = "Awesome! It helps cater to \na large spectrum of students \nwith various instructional needs.";

string r6 = "Are you prepared to use \nalternative learning activities \nto address various \nlearning paces?";
string r6n = "Preparing alternative activities \nhelps address learners \nwith various instructional \nneeds and exceptionalities.";
string r6y = "Perfect! You are fully \nprepared to deliver a \ngreat learning experience!";

help_message()
{
    if(internal_state)
    {
        llDialog(player, "Click any button to continue'.", ["Okay"], game_text_channel);
    }

    llDialog(player, "Click the Green Button for 'Yes' and the Red Button for 'No'.", ["Okay"], game_text_channel);
}

correct()
{

    llPlaySound("correct_beep", 3.0);
    llParticleSystem([
     PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,

     PSYS_SRC_MAX_AGE, 0.,
     PSYS_PART_MAX_AGE, .9,

     PSYS_SRC_BURST_RATE, .05,
     PSYS_SRC_BURST_PART_COUNT, 50,

     PSYS_SRC_BURST_RADIUS, 5.,
     PSYS_SRC_BURST_SPEED_MIN, .1,
     PSYS_SRC_BURST_SPEED_MAX, 2.,
     PSYS_SRC_ACCEL, <0.0,0.0,-0.8>,

     PSYS_PART_START_COLOR, <1,1,1>,
     PSYS_PART_END_COLOR, <1,0,0>,

     PSYS_PART_START_ALPHA, 0.9,
     PSYS_PART_END_ALPHA, 0.0,

     PSYS_PART_START_SCALE, <.15,.15,0>,
     PSYS_PART_END_SCALE, <.01,.1,0>,

     PSYS_PART_FLAGS
     , 0
     | PSYS_PART_EMISSIVE_MASK
     | PSYS_PART_INTERP_COLOR_MASK
     | PSYS_PART_INTERP_SCALE_MASK
     | PSYS_PART_FOLLOW_SRC_MASK
     | PSYS_PART_FOLLOW_VELOCITY_MASK
    ]); 
    llSleep(2.0);
    llParticleSystem([]);
    llStopSound();
}

wrong()
{
    llPlaySound("wrong_beep", 3.0);
    llParticleSystem([

     PSYS_PART_FLAGS
     , 0
     | PSYS_PART_EMISSIVE_MASK
     | PSYS_PART_INTERP_COLOR_MASK
     | PSYS_PART_INTERP_SCALE_MASK
     | PSYS_PART_FOLLOW_SRC_MASK
     ,

     PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_DROP,

     PSYS_SRC_MAX_AGE, 0.,
     PSYS_SRC_BURST_RATE, 2.,
     PSYS_SRC_BURST_PART_COUNT, 3,

     PSYS_SRC_ACCEL, <0.0,0.0,-0.01>,

     PSYS_PART_MAX_AGE, 9.,
     PSYS_PART_START_COLOR, <1,0,0>,
     PSYS_PART_END_COLOR, <1,1,1>,
     PSYS_PART_START_ALPHA, 0.8,
     PSYS_PART_END_ALPHA, 0.,

     PSYS_PART_START_SCALE, <1,1,0>,
     PSYS_PART_END_SCALE, <.01,.01,0>
     ]);
    llSleep(2.0);
    llParticleSystem([]);
    llStopSound();
}

default
{
    state_entry()
    {
        llSetText("Stand near the screen to \nbegin the game.", COLOR_BLUE, OPAQUE);
        llSensorRepeat("", NULL_KEY, AGENT, 5.0, PI, 1);
    }

    touch_start(integer num_detected)
    {
        player = llDetectedKey(0);
        correct();
        state R1;
    }

    sensor(integer detected )
    {
        player = llDetectedKey(0);
        correct();
        state R1;
    }

}


state R1
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r1, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        llDialog(player, "Click any button to continue.", ["Okay"], game_text_channel);
    }

    listen(integer c, string n, key ID, string msg)
    {
            if(msg == "yes")
            {
                correct();
            } 
            else if(msg == "no")
            {
                wrong();
            }
            else
            {
                llResetScript();
            }

            state R2;
    }

}

state R2
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r2, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        help_message();
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }

        if(!internal_state) 
        {  
            if(msg == "yes")
            {
                correct();
                llSetText(r2y, COLOR_BLUE, OPAQUE);
                internal_state++;
            } 
            else
            {
                wrong();
                internal_state = 0;
                state R2W;
            }
                

        }
        else 
        {
            internal_state = 0;
            state R3;
        }
        

        
    }
}

state R2W
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r2n, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        llDialog(player, "Click any button to continue.", ["Okay"], game_text_channel);
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }
        
        if(!internal_state)
        {
            llSetText(r2y, COLOR_BLUE, OPAQUE);
            internal_state++;
        }
        else 
        {
            internal_state = 0;
            state R3;
        }


    }
}


state R3
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r3, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        help_message();
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }

        if(!internal_state) 
        {  
            if(msg == "yes")
            {
                correct();
                llSetText(r3y, COLOR_BLUE, OPAQUE);
                internal_state++;
            } 
            else
            {
                wrong();
                internal_state = 0;
                state R3W;
            }
                

        }
        else 
        {
            internal_state = 0;
            state R4;
        }
        
    }
}

state R3W
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r3n, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        llDialog(player, "Click any button to continue.", ["Okay"], game_text_channel);
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }
        
        if(!internal_state)
        {
            llSetText(r3y, COLOR_BLUE, OPAQUE);
            internal_state++;
        }
        else 
        {
            internal_state = 0;
            state R4;
        }


    }
}

state R4
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r4, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        help_message();
    }

    listen(integer c, string n, key ID, string msg)
    {

        if(msg == "-reset")
        {
            llResetScript();
        }

        if(!internal_state) 
        {  
            if(msg == "yes")
            {
                correct();
                llSetText(r4y, COLOR_BLUE, OPAQUE);
                internal_state++;
            } 
            else
            {
                wrong();
                internal_state = 0;
                state R4W;
            }
                

        }
        else 
        {
            internal_state = 0;
            state R5;
        }
        
    }
}

state R4W
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r4n, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        llDialog(player, "Click any button to continue.", ["Okay"], game_text_channel);
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }
        
        if(!internal_state)
        {
            llSetText(r4y, COLOR_BLUE, OPAQUE);
            internal_state++;
        }
        else 
        {
            internal_state = 0;
            state R5;
        }


    }
}

state R5
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r5, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        help_message();
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }

        if(!internal_state) 
        {  
            if(msg == "yes")
            {
                correct();
                llSetText(r5y, COLOR_BLUE, OPAQUE);
                internal_state++;
            } 
            else
            {
                wrong();
                internal_state = 0;
                state R5W;
            }
                

        }
        else 
        {
            internal_state = 0;
            state R6;
        }
        
    }
}

state R5W
{

    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r5n, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        llDialog(player, "Click any button to continue.", ["Okay"], game_text_channel);
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }
        
        if(!internal_state)
        {
            llSetText(r5y, COLOR_BLUE, OPAQUE);
            internal_state++;
        }
        else 
        {
            internal_state = 0;
            state R6;
        }


    }
}

state R6
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r6, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        help_message();
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }

        if(!internal_state) 
        {  
            if(msg == "yes")
            {
                correct();
                llSetText(r6y, COLOR_BLUE, OPAQUE);
                internal_state++;
            } 
            else
            {
                wrong();
                internal_state = 0;
                state R6W;
            }
                

        }
        else 
        {
            internal_state = 0;
            state Complete;
        }
        
    }
}

state R6W
{
    state_entry()
    {
        llListen(game_button_channel, "", NULL_KEY, "");
        llSetText(r6n, COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        llDialog(player, "Click any button to continue.", ["Okay"], game_text_channel);
    }

    listen(integer c, string n, key ID, string msg)
    {
        if(msg == "-reset")
        {
            llResetScript();
        }
        
        if(!internal_state)
        {
            llSetText(r6y, COLOR_BLUE, OPAQUE);
            internal_state++;
        }
        else 
        {
            internal_state = 0;
            state Complete;
        }


    }
}

state Complete
{
    state_entry()
    {
        llSetText("Game completed. \nClick the screen to restart.", COLOR_BLUE, OPAQUE);
    }

    touch_start(integer num_detected)
    {
        state default;
    }
}





