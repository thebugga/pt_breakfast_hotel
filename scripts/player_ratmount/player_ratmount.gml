function player_ratmount()
{
	var default_idle = brick ? spr_player_ratidle : spr_player_idle
	var default_move = brick ? spr_player_ratmove : spr_player_move
	var default_jump = brick ? spr_player_ratjump : spr_player_jump
	var default_fall = brick ? spr_player_ratfall : spr_player_fall
	if (movespeed >= 12 || gusdashpadbuffer > 0)
	{
		default_move = brick ? spr_player_ratmach3 : spr_player_mach3
		default_jump = brick ? spr_player_ratmach3jump : spr_player_mach3jump
		default_fall = brick ? spr_player_ratmach3jump : spr_player_mach3jump
	}
    else if input.dash.check
	{
		default_move = brick ? spr_player_ratmach2 : spr_player_mach2
		default_jump = brick ? spr_player_ratmach2jump : spr_player_mach2jump
		default_fall = brick ? spr_player_ratmach2jump : spr_player_mach2jump
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
	hsp = xscale * movespeed
	if scr_hitwall(x + xscale, y) || (movespeed < 8 && p_move != xscale) || !input.dash.check || movespeed <= 6
		gustavodash = 8
    if (input.dash.check && grounded && (!(place_meeting((x + xscale), y, obj_solid))))
            gustavodash = approach(gustavodash, 12, 0.15)
	var prevMS = movespeed
	
	if scr_hitwall(x + xscale, y) && !scr_slope(x, y + 1) && scr_slope(x, y + 1)
	{
		hsp = 0
		if (prevMS >= 12)
        {
            var _bump = scr_goupwall()
            
            if (_bump)
            {
                fmod_studio_event_instance_oneshot_3d("event:/sfx/misc/slam", x, y)
                state = states.bump
                sprite_index = brick ? spr_player_ratbump : spr_player_bump
                image_index = 0
                create_effect(x, y, spr_bumpeffect)
                hsp = -xscale * 4
                vsp = -5
				shake_camera(20, 40 / room_speed)
                exit;
            }
        }
	}
    if (movespeed >= 12 && !particle_contains_sprite(spr_jumpdust))
        particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
		
    if (movespeed >= 12 || gusdashpadbuffer > 0)
    {
        if !particle_contains_sprite(spr_mach3charge)
		{
			create_followingeffect(spr_mach3charge, states.mach3, xscale)
			create_followingeffect(spr_speedlines, states.mach3, xscale)
		}
    }
	if (p_move == -xscale && gusdashpadbuffer <= 0 && sprite_index != spr_player_kick)
    {
        if (movespeed > 2 && grounded)
        {
            fmod_studio_event_instance_oneshot_3d("event:/sfx/player/break", x, y)
            state = states.ratmountskid
        }
		else
			xscale = p_move
    }
	
	if (gusdashpadbuffer > 0 && hsp != 0)
        xscale = sign(hsp)
    if (gusdashpadbuffer > 0)
        gusdashpadbuffer--
    if (gusdashpadbuffer <= 0)
    {
	    if (p_move == xscale)
            movespeed = approach(movespeed, gustavodash, 0.5)
        else
            movespeed = approach(movespeed, 0, 0.5)
    }
    else
        movespeed = 12
	
	//if (abs(hsp) > 2)
    //    image_speed = abs(hsp) / 12
    //else
    //    image_speed = 0.35
    //if (sprite_index == spr_player_ratmountmach3)
    //    image_speed = 0.5
		
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
			if (sprite_index != (brick ? spr_player_ratlandmove : spr_player_landmove) && sprite_index != spr_player_shotgun_land)
				sprite_index = default_move
		}
		else
		{
			if !has_shotgun
			{
				if (idletimer <= 0 && idletimer != -4)
				{
					reset_anim(idlegestures[irandom(5)])
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
			
			if (sprite_index != spr_player_machslideend && sprite_index != (brick ? spr_player_ratland : spr_player_land) && sprite_index != spr_player_bodyslamland && sprite_index != spr_player_facehurt && sprite_index != spr_player_shotgun_land && idletimer > 0)
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
	if (input_buffers.jump > 0 && coyote_time && gusdashpadbuffer == 0 && state != states.ratmountskid)
    {
        input_buffers.jump = 0
		fmod_studio_event_instance_oneshot_3d("event:/sfx/player/jump", x, y)
		particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
		reset_anim(default_jump)
        state = states.ratmountjump
        vsp = -11
        jumpstop = false
    }
	if (!grounded && sprite_index != spr_player_ratswallow)
    {
        state = states.ratmountjump
		sprite_index = default_fall
    }
	
    do_ratattack()
	
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
		case spr_player_ratland:
		case spr_player_land:
		case spr_player_shotgun_land:
		case spr_player_facehurt:
			reset_anim_on_end(default_idle)
			break;
		case spr_player_ratlandmove:
		case spr_player_landmove:
			reset_anim_on_end(default_move);
			break;
	}
    //shootpowerup()
    do_taunt()
	
	instakill = movespeed >= 12
}