vector sitPosition=<0.35,0.01,0.18>; // change to fit
vector sitRotation=<0.01,0.01,0.01>; // change to fit
default
{
    state_entry()
    {
        sitRotation*=DEG_TO_RAD;
        rotation finalRotation = llEuler2Rot(sitRotation);
        llSitTarget(sitPosition, finalRotation);
    }
}