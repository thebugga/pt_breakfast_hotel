function player_normal()
{
	move = p_move;
	doublejump = false;
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
	if (ratmount_movespeed >= 12 && gustavodash != 51)
	{
		particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
		gustavodash = 51;
	}
	if (ratmount_movespeed >= 12 || gusdashpadbuffer > 0)
	{
		if !particle_contains_sprite(spr_mach3charge)
		{
			create_followingeffect(spr_mach3charge, states.normal, xscale)
			create_followingeffect(spr_speedlines, states.normal, xscale)
		}
		if (input.up.check || input.superjump.check) && vsp >= 0
		{
			movespeed = 0;
			state = states.superjump
			reset_anim(spr_player_superjumpprep)
		}
		instakill = true
	}
	if (move != xscale && move != 0 && gusdashpadbuffer <= 0)
	{
		xscale = move;
		if (abs(movespeed) > 2 && abs(hsp) > 2 && grounded)
		{
			state = states.slide;
			scr_sound_3d_on(myemitter, sfx_machslideboost)
			movespeed = abs(movespeed);
		}
	}
	if (gusdashpadbuffer > 0 && movespeed != 0)
	{
		xscale = sign(movespeed);
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
			else
			{
				movespeed = 0;
			}
		}
		else
		{
			movespeed = approach(movespeed, 0, 0.5);
		}
	}
	else
	{
		ratmount_movespeed = 12;
		movespeed = xscale * ratmount_movespeed;
	}
	if (abs(movespeed) > 2)
	{
		image_speed = abs(movespeed) / 12;
	}
	else
	{
		image_speed = 0.35;
	}
	if (sprite_index == spr_player_mach3)
	{
		image_speed = 0.4;
	}
	var front = scr_hitwall(x + sign(hsp), y) 
	if sprite_index != spr_player_land
	{
		if (hsp != 0 && !front)
		{
			if (ratmount_movespeed >= 12 || gusdashpadbuffer > 0)
			{
				sprite_index = spr_player_mach3;
			}
			else if (input.dash.check)
			{
				sprite_index = spr_player_mach1;
			}
			else
			{
				sprite_index = spr_player_move;
			}
		}
		else
		{
			image_speed = 0.35;
			if (sprite_index != spr_player_idle1)
			{
				sprite_index = spr_player_idle;
				if (idletimer < 400)
				{
					idletimer++;
				}
				if (idletimer >= 150)
				{
					idletimer = -4
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
	}
	if (anim_ended())
	{
		if (sprite_index == spr_player_land)
		{
			sprite_index = spr_player_idle;
		}
	}
	if (sprite_index == spr_player_land)
	{
		image_speed = 0.35;
	}
	/*
	if (hsp != 0 && grounded && vsp > 0 && !front)
	{
		if (steppybuffer > 0)
		{
			steppybuffer--;
		}
		else
		{
			create_particle(x, y + 43, particletypes.cloudeffect, 0);
			steppybuffer = 18;
			if (sprite_index != spr_player_ratmountattack)
			{
				fmod_event_one_shot_3d("event:/sfx/pep/step", x, y);
			}
		}
	}
	*/
	if (input_buffers.jump > 0 && coyote_time && gusdashpadbuffer == 0 && state != states.slide)
	{
		input_buffers.jump = 0;
		create_effect(x, y - 5, spr_highjumpcloud2)
		scr_sound_3d(sfx_jump, x, y)
		if ((ratmount_movespeed >= 12 && input.dash.check) || gusdashpadbuffer > 0)
		{
			sprite_index = spr_player_mach3jump;
		}
		else
		{
			sprite_index = spr_player_jump;
		}
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
		if (ratmount_movespeed >= 12)
		{
			sprite_index = spr_player_mach3jump;
		}
		else
		{
			sprite_index = spr_player_fall;
		}
	}
	if (input.dash.check && grounded && !place_meeting(x + xscale, y, obj_solid))
	{
		move = xscale;
		if (ratmount_movespeed < 12)
		{
			ratmount_movespeed = approach(ratmount_movespeed, 12, 0.15);
		}
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
	do_grab()
	do_taunt()
}