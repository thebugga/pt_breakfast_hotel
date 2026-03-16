function player_normal()
{
    hsp = movespeed;
    var front = scr_hitwall(x + sign(hsp), y);
    
    if (sprite_index != spr_player_land)
    {
        if (p_move)
        {
            sprite_index = spr_player_move;
        }
        else if (sprite_index != spr_player_idle1)
        {
            sprite_index = spr_player_idle;
            
            if (idletimer < 400)
                idletimer++;
            
            if (idletimer >= 150)
            {
                idletimer = -4;
                sprite_index = spr_player_idle1;
                image_index = 0;
            }
        }
        else if (anim_ended())
        {
            idletimer = 0;
            sprite_index = spr_player_idle;
        }
    }
    
    if (p_move != xscale && p_move != 0 && !front)
    {
        if (abs(movespeed) > 2 && abs(hsp) > 2 && grounded)
        {
            state = states.slide;
            sprite_index = spr_player_machslideboost3;
            movespeed = abs(movespeed);
        }
    }
    
    if (!input.dash.check)
    {
        if (p_move)
            movespeed = approach(movespeed, 8 * xscale, 0.5);
        else
            movespeed = approach(movespeed, 0, 0.5);
    }
    else
    {
        if (p_move != 0)
            xscale = p_move;
        
        movespeed = approach(movespeed, 12 * xscale, 0.15);
        
        if (movespeed >= 12)
            sprite_index = spr_player_mach3;
        
        if (abs(movespeed) > 2 && sprite_index != spr_player_mach2 && movespeed <= 12)
            sprite_index = spr_player_mach1;
    }
    
    if (p_move && grounded && vsp > 0 && !front)
    {
        if (particle_timer > 0)
        {
            particle_timer--;
        }
        else
        {
            particle_timer = 12;
            scr_sound_3d_pitched(sfx_step, x, y);
        }
    }
    
    switch (sprite_index)
    {
        case spr_player_mach1:
            reset_anim_on_end(spr_player_mach2);
            break;
        
        case spr_player_land:
            reset_anim_on_end(spr_player_idle);
            break;
        
        case spr_player_mach3jump:
            reset_anim_on_end(spr_player_mach3);
            break;
    }
    
    if (input_buffers.jump > 0 && coyote_time && gusdashpadbuffer == 0 && state != states.slide)
    {
        input_buffers.jump = 0;
        create_effect(x, y - 5, spr_highjumpcloud2);
        scr_sound_3d(sfx_jump, x, y);
        
        if ((movespeed >= 12 && input.dash.check) || gusdashpadbuffer > 0)
            sprite_index = spr_player_mach3jump;
        else
            sprite_index = spr_player_jump;
        
        image_index = 0;
        jumpAnim = true;
        state = states.jump;
        vsp = -11;
        jumpstop = false;
    }
    
    if (!grounded)
    {
        state = states.jump;
        jumpAnim = false;
        
        if (movespeed >= 12)
            sprite_index = spr_player_mach3jump;
        else
            sprite_index = spr_player_fall;
    }
    
    if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_slope))
    {
        if (movespeed >= 12)
        {
            movespeed = 0;
            state = states.bump;
            sprite_index = spr_player_wallsplat;
            image_index = 0;
            create_effect(x + (16 * xscale), y, spr_bumpeffect);
            hsp = -xscale * 4;
            vsp = -5;
            exit;
        }
    }
    
    if (movespeed >= 12 || gusdashpadbuffer > 0)
    {
        if (!particle_contains_sprite(spr_mach3charge))
        {
            create_followingeffect(spr_mach3charge, states.normal, xscale);
            create_followingeffect(spr_speedlines, states.normal, xscale);
        }
        
        if ((input.up.check || input.superjump.check) && vsp >= 0)
        {
            state = states.superjump;
            reset_anim(spr_player_superjumpprep);
        }
        
        instakill = true;
    }
    
    image_speed = 0.35;
    do_grab();
    do_taunt();
}
