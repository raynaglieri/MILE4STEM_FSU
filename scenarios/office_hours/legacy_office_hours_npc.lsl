/* 
NPC_70
6/15/17
Created By: Ray Naglieri
About: NPC will approach trainee on pre-scripted path when the trainee starts office hours. The NPC will then ask a question specified by the facilitator. Use '/70@ask: <question> or /70@leave: <good bye message> to communicate with trainee.
NOTES:  6/15/17 NPC response not completed.
        6/16/17 response support completed        
*/

key npc;
key touched;
integer cnpc;

default{
    
    state_entry(){
        
    osOwnerSaveAppearance("app");
    llListen(70,"", NULL_KEY, "");

    }

    touch_start(integer numn){
        
        if ((cnpc == 0) && (llDetectedKey(0)== llGetOwner())){
            
            cnpc = 1;
            npc = osNpcCreate("David","Scofield",llGetPos()+<0.0,0.0,1.0>,"app");
            osNpcSit(npc,llGetKey(),OS_NPC_SIT_NOW);
            touched = llDetectedKey(0);
          
        } else if ((cnpc == 1) && (llDetectedKey(0)== llGetOwner())){
            
            osNpcRemove(npc);
            cnpc = 0;
            
        }
        
    }

    listen(integer c, string sm, key ID, string ms) {
        
        if (c == 70){

            if(ms == "@execute order 66"){
                
                osNpcStand(npc);
                llSleep(2.0);
                state path;
                
            }
                         
        }
        
    }
    
}    

state path{
    
    state_entry(){
        
        rotation rot = osNpcGetRot(npc);           
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <5.0,0.0,0.0>*rot,OS_NPC_NO_FLY);
        llSleep(4.0);
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <0.0,3.0,0.0>*rot,OS_NPC_NO_FLY);
        llSleep(4.0);     
        state askQuestions;
                               
    }
    
}

state askQuestions{
    
    state_entry(){
        
        llListen(70,"",NULL_KEY,"");            
        
    }
    
    listen(integer c, string sm, key ID, string ms){
        
        if (c == 70){

            integer index = llSubStringIndex(ms,"@leave:");
            if(index != -1){
                
                ms = llDeleteSubString(ms, 0, 6);
                osNpcSay(npc, ms);
                llSay(71,"@execute order 77");
                state leaveOffice;
                
            }
               
            index = llSubStringIndex(ms,"@ask:");   
            if(index != -1) {
                
                ms = llDeleteSubString(ms, 0, 4);
                osNpcSay(npc, ms);
                state askQuestions;
                
            }
                
        }
        
    }   
    
}  

state leaveOffice{
 
    state_entry(){
     
        rotation rot = osNpcGetRot(npc);    
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <-10.0,0.0,0.0>*rot,OS_NPC_NO_FLY);
        llSleep(5.0);  
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <0.0,-2.0,0.0>*rot,OS_NPC_NO_FLY);
        llSleep(2.0);    
        osNpcMoveToTarget(npc,osNpcGetPos(npc) + <-3.0,0.0,0.0>*rot,OS_NPC_NO_FLY);
        llSleep(2.0);            
        osNpcRemove(npc);
        cnpc = 0;
        state default; 
        
    }   
    
}    



    
      
    