function player_ratmountjump()
{
	var default_jump = brick ? spr_player_ratjump : spr_player_jump
	var default_fall = brick ? spr_player_ratfall : spr_player_fall
	var default_bump = brick ? spr_player_ratbump : spr_player_bump
	var default_land = brick ? spr_player_ratland : spr_player_land
	var default_landmove = brick ? spr_player_ratland : spr_player_landmove
	
	if (movespeed >= 12 || gusdashpadbuffer > 0)
	{
		default_jump = brick ? spr_player_ratmach3jump : spr_player_mach3jump
		default_fall = brick ? spr_player_ratmach3jump : spr_player_mach3jump
	}
    else if input.dash.check
	{
		default_jump = brick ? spr_player_ratmach2jump : spr_player_mach2jump
		default_fall = brick ? spr_player_ratmach2jump : spr_player_mach2jump
	}
	if has_shotgun
	{
		default_jump = spr_player_shotgun_jump
		default_fall = spr_player_shotgun_fall
		default_land = spr_player_shotgun_land
		default_landmove = spr_player_shotgun_land
	}
	if global.panic.active && global.panic.timer <= 0
	{
		default_jump = spr_player_hurtjump
		default_fall = spr_player_hurtjump
	}
	if sprite_index == spr_player_jump
		sprite_index = default_jump
	else if sprite_index == spr_player_fall
		sprite_index = default_fall
	
	if (sprite_index == spr_player_mach2jump)
        image_speed = 0.6
    else
        image_speed = 0.35
	
    if (!jumpstop && !input.jump.check && vsp < 0)
	{
		jumpstop = true
		vsp /= 10
	}
	
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
	
    if (gusdashpadbuffer > 0)
        gusdashpadbuffer--
    if (gusdashpadbuffer <= 0)
    {
		hsp = approach(hsp, p_move * gustavodash, 0.5)
        if p_move != 0
            xscale = p_move
    }
    if (gusdashpadbuffer > 0 && movespeed != 0)
		hsp = xscale * movespeed
	switch (sprite_index)
	{
		case spr_player_jump:
		case spr_player_piledriverjump:
			reset_anim_on_end(spr_player_fall)
			break;
		case spr_player_suplexcancel:
			image_speed = 0.4
			reset_anim_on_end(spr_player_fall)
			break;
		case spr_player_shotgun_jump:
			reset_anim_on_end(spr_player_shotgun_fall)
			break;
		case spr_player_stomp:
			if anim_ended()
				image_index = image_number - 3
			break;
		case spr_player_hurtjump:
			if anim_ended()
				image_index = image_number - 3
			break;
	}

    if input.down.pressed || input.groundpound.pressed
	{
        if brick
        {
            with (instance_create(x, y, obj_brickcomeback))
            {
                wait = true
                particle_create(x, y, particles.genericpoof)
            }
        }
        brick = false
        state = states.ratmountgroundpound
        reset_anim(spr_player_bodyslamstart)
    }
    
	do_ratattack()
	
    var bounce = true
    if (input_buffers.jump > 0 && coyote_time && gusdashpadbuffer == 0 && (!(place_meeting(x, (y + 5), obj_grindrail))))
    {
        bounce = false
        input_buffers.jump = 0
		fmod_studio_event_instance_oneshot_3d("event:/sfx/player/jump", x, y)
		particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
		reset_anim(default_jump)
        state = states.ratmountjump
        vsp = -11
        jumpstop = false
    }
    if (input.jump.pressed && brick && bounce)
    {
        //GamepadSetVibration(0, 0.8, 0.8, 0.65)
        state = states.ratmountbounce
        instance_create(x, y, obj_highjumpcloud2)
        reset_anim(spr_player_ratwalljump)
        vsp = -16
    }
    if (grounded && vsp > 0 && sprite_index != spr_player_kick)
    {
        state = states.normal
		
		movespeed = abs(hsp)
		if sign(hsp) != 0
		xscale = sign(hsp)
		
        reset_anim(movespeed < 1 ? default_land : default_landmove)
		fmod_studio_event_instance_oneshot_3d("event:/sfx/player/step", x, y)
		create_effect(x, y, spr_landeffect)
    }
	
    do_taunt()
}