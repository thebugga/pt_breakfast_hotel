function player_normal()
{
	hsp = movespeed * xscale
   
	if input.taunt.check
	{
		if breakdance_secret.buffer < 10
			breakdance_secret.buffer++
		else
		{
			sprite_index = spr_player_breakdance
			breakdance_secret.spd = approach(breakdance_secret.spd, 0.6, 0.005)
			image_speed = breakdance_secret.spd
		}
		
		if breakdance_secret.spd >= 0.5
		{
			aftimg_timers.blur.do_it = true
			if (!instance_exists(obj_beatbox))
				instance_create(x, y, obj_beatbox)
		}
	}
	else
	{
		breakdance_secret.buffer = 0
		breakdance_secret.spd = 0.25
	}
	
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
	
    if (p_move != xscale && p_move != 0)
    {
        if (abs(movespeed) > 2 && abs(hsp) > 2 && grounded)
        {
            state = states.slide;
            sprite_index = spr_player_machslideboost3;
            movespeed = abs(movespeed);
        }
    }
    
    if (input.dash.check)
	{
		if p_move != 0
		{
			xscale = p_move
			if !place_meeting(x + p_move, y, obj_solid)
				movespeed = twerp(TwerpType.in_expo, movespeed, 14, 0.5);
		}
        if (movespeed >= 12)
            sprite_index = spr_player_mach3;
        else 
            sprite_index = spr_player_mach2;
			
    }
	else
	{
		if p_move != 0
		{
			xscale = p_move
			if !place_meeting(x + p_move, y, obj_solid)
				 movespeed = twerp(TwerpType.inout_cubic, movespeed, 8, 0.5);
			else
	            movespeed = twerp(TwerpType.inout_cubic, movespeed, 0, 0.5);
			if particle_timer > 0
				particle_timer--
			else if sprite_index != spr_player_breakdance
			{
				particle_timer = 12
				scr_sound_3d_pitched(sfx_step, x, y)
				create_effect(x, y + 43, spr_cloudeffect)
			}
		}
		else
			movespeed = twerp(TwerpType.inout_cubic, movespeed, 0, 0.5);
	}
    
    switch (sprite_index)
    {
        case spr_player_mach2:
            reset_anim_on_end(spr_player_mach3);
            break;
        
        case spr_player_land:
            reset_anim_on_end(spr_player_idle);
            break;
        
        case spr_player_mach3jump:
            reset_anim_on_end(spr_player_mach3);
            break;
    }
	
	if (coyote_time && input_buffers.jump > 0)
	{
		input_buffers.jump = 0
		vsp = -11
		state = states.jump
		reset_anim(spr_player_jump)
		jumpstop = false
		create_effect(x, y - 5, spr_highjumpcloud2)
		scr_sound_3d(sfx_jump, x, y)
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
        movespeed = 0;
        state = states.bump;
        sprite_index = spr_player_wallsplat;
        image_index = 0;
        create_effect(x + (16 * xscale), y, spr_bumpeffect);
        hsp = -xscale * 4;
        vsp = -5;
        exit;
	}
    
    if (movespeed >= 12)
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
