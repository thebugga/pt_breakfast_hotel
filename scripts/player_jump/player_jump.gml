function player_jump()
{
	move = p_move
	image_speed = 0.35;
	if (!jumpstop && vsp < 0.5 && !input.jump.check)
	{
		vsp /= 10;
		jumpstop = true;
	}
	hsp = movespeed;
	var r = ratmount_movespeed;
	if scr_hitwall(x + xscale, y, obj_solid)
	{
		gustavodash = 0;
		ratmount_movespeed = 8;
	}
	if (scr_hitwall(x + hsp, y, obj_solid) && gustavodash != 51 && movespeed < 6)
	{
		movespeed = 0;
		if (r >= 12)
		{
			state = states.bump;
			sprite_index = spr_player_wallsplat;
			image_index = 0;
			create_effect(x + (16 * xscale), y, spr_bumpeffect)
			hsp = -xscale * 4;
			vsp = -5;
			exit;
		}
	}
	if (gusdashpadbuffer > 0)
	{
		gusdashpadbuffer--;
	}
	if (gusdashpadbuffer <= 0)
	{
		if (move != 0)
		{
			if (move == xscale)
			{
				movespeed = approach(movespeed, xscale * ratmount_movespeed, 0.5);
			}
			else if (gustavodash == 51)
			{
				movespeed = approach(movespeed, 0, 0.5);
			}
			else
			{
				movespeed = approach(movespeed, 0, 0.5);
			}
		}
		else if (gustavodash == 51)
		{
			movespeed = approach(movespeed, 0, 0.5);
		}
		else
		{
			movespeed = approach(movespeed, 0, 0.5);
		}
		if (move != xscale && move != 0)
		{
			ratmount_movespeed = 8;
			xscale = move;
		}
	}
	if (gusdashpadbuffer > 0 && movespeed != 0)
	{
		xscale = sign(movespeed);
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
		if character == characters.peppino
		{
			wallspeed = movespeed
			if movespeed < 1
				wallspeed = 1
			else
				movespeed = wallspeed
			state = states.climbwall
		}
		else if character == characters.noise && !scr_goupwall()
		{
			movespeed = 0
			vsp = -17 + wallbouncedampen
			wallbouncedampen += 2.55
			state = states.wallbounce
			sprite_index = spr_playerN_wallbounce
			scr_sound_3d(sfx_N_wallkick, x, y)
			particle_create(x, y, particles.noisebump)
		}
	}
	do_groundpound()
	do_grab()
	do_taunt();
}