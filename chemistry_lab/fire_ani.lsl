integer scenario_offset = 300000;
integer interact_with_lab_channel = 101;

set_offset()
{
   interact_with_lab_channel= 101 + scenario_offset;
}
fakeMakeFire(integer particle_count, float particle_scale, float particle_speed,
             float particle_lifetime, float source_cone, string source_texture_id,
             vector local_offset)
{
//    local_offset is ignored
    llParticleSystem([
        PSYS_PART_FLAGS,            PSYS_PART_INTERP_COLOR_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_EMISSIVE_MASK | PSYS_PART_WIND_MASK,
        PSYS_SRC_PATTERN,           PSYS_SRC_PATTERN_ANGLE_CONE,
        PSYS_PART_START_COLOR,      <1.0, 1.0, 1.0>,
        PSYS_PART_END_COLOR,        <1.0, 1.0, 1.0>,
        PSYS_PART_START_ALPHA,      0.50,
        PSYS_PART_END_ALPHA,        0.10,
        PSYS_PART_START_SCALE,      <particle_scale/3, particle_scale/3, 0.0>,
        PSYS_PART_END_SCALE,        <particle_scale/4, particle_scale/4, 6.0>,
        PSYS_PART_MAX_AGE,          0.5,
        PSYS_SRC_ACCEL,             <0.0, 0.0, 0.0>,
        PSYS_SRC_TEXTURE,           source_texture_id,
        PSYS_SRC_BURST_RATE,        5 / particle_count,
        PSYS_SRC_ANGLE_BEGIN,       0.0,
        PSYS_SRC_ANGLE_END,         source_cone * PI,
        PSYS_SRC_BURST_PART_COUNT,  1,
        PSYS_SRC_BURST_RADIUS,      0.0,
        PSYS_SRC_BURST_SPEED_MIN,   particle_speed / 8,
        PSYS_SRC_BURST_SPEED_MAX,   particle_speed /8,
        PSYS_SRC_MAX_AGE,           particle_lifetime / 2,
        PSYS_SRC_OMEGA,             <0.0, 0.0, 0.0>
        ]);
}

default
{
    state_entry()
    {   set_offset();
        llListen(interact_with_lab_channel, "", NULL_KEY, "");
    }
    
    listen(integer c, string n, key ID, string msg) 
    {
        if(msg == "-fire")
        {
            fakeMakeFire(10, 1.5, 20, 200, 25, "flames", <25.0, 25.0, 25.0>); 
        }       
        else if (msg == "-extfire" || msg == "-reset")
        {
           llParticleSystem([]); 
        }   
             
    }
}
// END //