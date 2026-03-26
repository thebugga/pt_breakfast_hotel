function player_wallbounce()
{
	
	hsp = p_move * movespeed;
	dir = xscale;
	
	if (input.jump.pressed)
	{
		if (!input.dash.check)
		{
			vsp = approach(vsp, -11, 0.8);
		}
		else
		{
			vsp = approach(vsp, 0, 0.8);
		}
	}
	if (p_move != 0)
	{
		if (p_move != xscale)
		{
			if (movespeed > 0)
			{
				movespeed -= 0.7;
			}
			if (movespeed <= 0)
			{
				xscale = p_move;
			}
		}
		else if (movespeed < 8)
		{
			movespeed += 0.7;
		}
	}
	else
		movespeed = approach(movespeed, 0, 0.7);
	if (scr_solid(x, y - 1) && vsp < 0.5)
		vsp = grav;
		
	if grounded && vsp >= 0
	{
		flash = 8
		scr_sound_3d(sfx_N_machland, x, y)
		particle_create(x, y, particles.noisebump)
		with create_effect(x, y, spr_crazyruneffect)
		{
			image_xscale = other.xscale
			depth = -150
		}
		if input.dash.check
		{
			if p_move != 0
				xscale = p_move
			state = states.mach3
			movespeed = max(abs(movespeed), 12)
			sprite_index = spr_player_mach3
		}
		else
			state = states.normal
	}
	
	if !particle_contains_sprite(spr_drilleffect)
		create_followingeffect(spr_drilleffect, states.wallbounce, xscale).depth = -100
	
	image_speed = 0.5
	
	do_grab()
	
	do_taunt()
	
	if state != states.wallbounce
		audio_stop_sound(sfx_N_wallkick)
	
	aftimg_timers.mach.do_it = true
	
	instakill = true
}
