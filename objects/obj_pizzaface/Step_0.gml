var playerid = obj_player

if (!instance_exists(playerid))
	exit
	
var _move = true

with obj_player
{
	if (state == states.actor)
		_move = false
}

if !instance_exists(obj_treasure)
{
	if image_alpha >= 1
	{
		if (!obj_fade.fade && obj_player.state != states.actor)
		{
			if _move
			{
				var dir = point_direction(x, y, playerid.x, playerid.y)
				var mvsp = maxspeed + abs(playerid.vsp) + abs(playerid.hsp) / 8
				mvsp *= 0.56
				var turnspd = mvsp / 50
				var _g = distance_to_point(playerid.x, playerid.y)
				if (_g < 150)
				    maxspeed = 8
				else if (_g < 300)
				    maxspeed = 10
				else if (_g < 100)
				    maxspeed = 7
				else if (_g < 50)
				    maxspeed = 6
				else if (_g < 450)
				    maxspeed = 13
				else if (_g < 650)
				    maxspeed = 16
				else
				    maxspeed = 18
				hsp = approach(hsp, lengthdir_x(mvsp, dir), turnspd)
				vsp = approach(vsp, lengthdir_y(mvsp, dir), turnspd)
				x += hsp
				y += vsp
			}
		}
	}
	else
		image_alpha += 0.01
}
else
{
	x = -200
	y = -200
}

if !_move
{
	x += random_range(-6, 6)
	y += random_range(-6, 6)
	image_alpha = approach(image_alpha, 0, 0.1)
}

if (_move && place_meeting(x, y, playerid) && playerid.state != states.actor && !obj_fade.fade && !instance_exists(obj_rank) && image_alpha >= 1)
{
	with playerid
	{
		door_type = fade_types.generic
		hsp = 0
		vsp = 0
		movespeed = 0
		spawn = "a"
		state = states.actor
		sprite_index = spr_player_timesup
		image_index = 0
		global.secret = false
		if obj_music.mu != noone
			audio_stop_sound(obj_music.mu)
		if obj_music.secret_mu != noone
			audio_stop_sound(obj_music.secret_mu)
		scr_sound(sfx_explosion)
		scr_sound(sfx_groundpound)
		scr_sound(sfx_timesup)
		scr_sound(mu_timesup)
	}
	room_goto(rm_timesup)
	instance_destroy()
}

if maxspeed < 3 && image_alpha >= 1
	maxspeed += 0.01