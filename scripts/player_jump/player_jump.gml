function player_jump()
{
    image_speed = 0.35;
    hsp = movespeed * xscale;
    
    if (scr_hitwall(x + hsp, y, obj_solid))
    {
        movespeed = 0;
        
        if (movespeed >= 12)
        {
            state = states.bump;
            sprite_index = spr_player_wallsplat;
            image_index = 0;
            create_effect(x + (16 * xscale), y, spr_bumpeffect);
            hsp = -xscale * 4;
            vsp = -5;
            exit;
        }
    }
  
    if (anim_ended())
    {
        switch (sprite_index)
        {
            case spr_player_jump:
                sprite_index = spr_player_fall;
                break;
        }
    }
    
    if (grounded && vsp > 0)
    {
        sprite_index = spr_player_land;
        state = states.normal;
    }
    
    if ((!grounded || scr_slope(x, y + 1)) && scr_hitwall(x + xscale, y) && movespeed >= 6)
    {
        if (character == characters.peppino)
        {
            wallspeed = movespeed;
            
            if (movespeed < 1)
                wallspeed = 1;
            else
                movespeed = wallspeed;
            
            state = states.climbwall;
        }
        else if (character == characters.noise && !scr_goupwall())
        {
            movespeed = 0;
            vsp = -17 + wallbouncedampen;
            wallbouncedampen += 2.55;
            state = states.wallbounce;
            sprite_index = spr_playerN_wallbounce;
            scr_sound_3d(sfx_N_wallkick, x, y);
            particle_create(x, y, particles.noisebump);
        }
    }
    
    do_groundpound();
    do_grab();
    do_taunt();
}
