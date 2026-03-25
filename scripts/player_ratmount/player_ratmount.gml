function player_ratmount()
{
	var default_idle = spr_player_idle
	var default_move = spr_player_move
	var default_jump = spr_player_jump
	var default_fall = spr_player_fall
	var default_bump = spr_player_bump
	if (movespeed >= 12 || gusdashpadbuffer > 0)
	{
		default_move = spr_player_mach3
		default_jump = spr_player_mach3jump
		default_fall = spr_player_mach3jump
	}
    else if input.dash.check
	{
		default_move = spr_player_mach2
		default_jump = spr_player_mach2jump
		default_fall = spr_player_mach2jump
	}
	if has_shotgun
	{
		default_idle = spr_player_shotgun_idle
		default_move = spr_player_shotgun_move
		default_jump = spr_player_shotgun_jump
		default_fall = spr_player_shotgun_fall
	}
	else if global.combo.count >= 50
	{
		default_idle = spr_player_rageidle
		default_move = spr_player_ragemove
	}
	else if global.combo.count >= 25
	{
		default_idle = spr_player_madidle
		default_move = spr_player_madmove
	}
	
	if winding >= 1800
		default_idle = spr_player_winding
	
	if global.panic.active
	{
		default_idle = spr_player_panic
		
		if global.panic.timer <= 0
		{
			default_idle = spr_player_hurtidle
			default_move = spr_player_hurtmove
			default_jump = spr_player_hurtjump
			default_fall = spr_player_hurtjump
		}
	}
	
	
	doublejump = false
	//hsp = xscale * movespeed
	var prevMS = movespeed
	
	if scr_hitwall(x + xscale, y) || (movespeed < 8 && p_move != xscale) || !input.dash.check || movespeed <= 6
	{
		gustavodash = 0
		movespeed = 8
	}
	
	if scr_hitwall(x + xscale, y) && !scr_slope(x, y + 1) && scr_slope(x, y + 1) && gustavodash != 51
	{
		hsp = 0
		if (prevMS >= 12)
        {
            var _bump = scr_goupwall()
            
            if (_bump)
            {
                fmod_studio_event_instance_oneshot_3d("event:/sfx/misc/slam", x, y)
                state = states.bump
                sprite_index = default_bump
                image_index = 0
                create_effect(x, y, spr_bumpeffect)
                hsp = -xscale * 4
                vsp = -5
				shake_camera(20, 40 / room_speed)
                exit;
            }
        }
	}
	if (movespeed >= 12 && gustavodash != 51)
    {
        particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
        gustavodash = 51
    }
	if (p_move != xscale && p_move != 0 && gusdashpadbuffer <= 0)
    {
        xscale = p_move
		prevspr = sprite_index
        if (abs(movespeed) > 2 && abs(hsp) > 2 && grounded)
        {
            fmod_studio_event_instance_oneshot_3d("event:/sfx/player/break", x, y)
            state = states.slide
        }
    }
	if (gusdashpadbuffer > 0 && hsp != 0)
        xscale = sign(hsp)
    if (gusdashpadbuffer > 0)
        gusdashpadbuffer--
    if (gusdashpadbuffer <= 0)
    {
        if (p_move != 0)
        {
            if (p_move == xscale)
                hsp = approach(hsp, (xscale * movespeed), 0.5)
            else
                hsp = approach(hsp, 0, 0.5)
        }
        else
            hsp = approach(hsp, 0, 0.5)
    }
    else
    {
        movespeed = 12
        hsp = xscale * movespeed
    }
	if (abs(hsp) > 2)
        image_speed = abs(hsp) / 12
    else
        image_speed = 0.35
    if (sprite_index == spr_player_mach3)
        image_speed = 0.5
		
    var front = scr_hitwall(x + xscale, y) && !scr_slope(x + xscale, y)
	var idlegestures = [
		spr_player_idle1, 
		spr_player_idle2, 
		spr_player_idle3, 
		spr_player_idle4, 
		spr_player_idle5,
		spr_player_idle6
	]
	
	if (breakdance_secret.buffer < 10)
    {
		if hsp != 0
		{
			if (sprite_index != spr_player_landmove && sprite_index != spr_player_shotgun_land)
				sprite_index = default_move
		}
		else
		{
			if !has_shotgun
			{
				if (idletimer <= 0 && idletimer != -4)
				{
					//reset_anim(idlegestures[irandom(5)])
					idletimer = -4
					if irandom(100) >= 50
						scr_sound_pitched(choose(v_pep_bah, v_pep_alright, v_pep_alright_high, v_pep_paranoid, v_pep_paParanoid), 0.5, 1.5)
				}
				
				if (anim_ended() && idletimer == -4)
				{
					reset_anim(default_idle)
					idletimer = 180
				}
			}
			
			if (sprite_index != spr_player_machslideend && sprite_index != (spr_player_land) && sprite_index != spr_player_bodyslamland && sprite_index != spr_player_facehurt && sprite_index != spr_player_shotgun_land && idletimer > 0)
				sprite_index = default_idle
		}
    }
	
	image_speed = 0.35
	if input.taunt.check && !brick
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
	
    if (hsp != 0 && grounded && vsp > 0 && (!front))
    {
        if (particle_timer > 0)
            particle_timer--
        else
        {
            create_effect(x, y + 43, spr_cloudeffect)
            particle_timer = 18
            fmod_studio_event_instance_oneshot_3d("event:/sfx/player/step", x, y)
        }
    }
	if (input_buffers.jump > 0 && coyote_time && gusdashpadbuffer == 0 && state != states.slide)
    {
        input_buffers.jump = 0
		fmod_studio_event_instance_oneshot_3d("event:/sfx/player/jump", x, y)
		particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
        sprite_index = default_jump
        image_index = 0
        state = states.jump
		movespeed = prevMS
        vsp = -11
        jumpstop = false
    }
    if (input.dash.check && grounded && (!(place_meeting((x + xscale), y, obj_solid))))
    {
        if (movespeed < 12)
            movespeed = approach(movespeed, 12, 0.15)
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
	if (state == states.slide)
	    hsp *= -1
	/*
    if input_buffers.grab > 0 && gusdashpadbuffer == 0
    {
	    input_buffers.grab = 0
	    if key_up && !instance_exists(obj_brickball)
		{
	        kickbrick()
		}
		else
	    {
	        if holding
	        {
	            state = states.ratmountspit
	            sprite_index = spr_player_ratspit
	            image_index = 0
	        }
	        else
	        {
	            state = states.ratmountattack
	            image_index = 0
	            if (p_move != 0)
	                xscale = p_move
	            movespeed = 12
	            sprite_index = spr_player_ratattack
	            fmod_studio_event_instance_oneshot_3d("event:/sfx/player/jump", x, y)
	            particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
	        }
	    }
	} 
	*/
	if !particle_contains_sprite(spr_crazyruneffect) && grounded && movespeed >= 12
	{
		with create_effect(x, y, spr_crazyruneffect)
		{
			image_xscale = other.xscale
			depth = -150
		}
	}
	
	if global.combo.count >= 25 && !particle_contains_sprite(spr_angrycloud)
		create_followingeffect(spr_angrycloud, states.normal).image_speed = 0.35
	
	switch (sprite_index)
	{
		case default_move:
			if movespeed > 6
	            image_speed = 0.6;
			break;
		case spr_player_machslideend:
		case spr_player_land:
		case spr_player_shotgun_land:
		case spr_player_facehurt:
			reset_anim_on_end(default_idle)
			break;
		case spr_player_landmove:
			reset_anim_on_end(default_move);
			break;
	}
    //shootpowerup()
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
    do_grab();
    do_taunt()
}