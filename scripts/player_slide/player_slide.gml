function player_slide() 
{
	hsp = movespeed * xscale
	movespeed = approach(movespeed, 0, 0.4);
	image_speed = 0.4;
	sprite_index = spr_player_machslideboost3;
	if (abs(movespeed) <= 0 || abs(hsp) <= 0)
	{
		if !input.dash.check
		{
			state = states.normal
		}
		else
		{	
			if prevspr == spr_player_mach3
			{
				state = states.normal
				movespeed = 10
				sprite_index = spr_player_mach3
				prevstate = state
			}
			else
			{
				state = states.normal
				movespeed = 8
				prevstate = state
			}
		}
	}
	if grounded && !particle_contains_sprite(spr_dashcloud)
	{
		with create_effect(x, y, spr_dashcloud)
			image_xscale = other.xscale
	}
	do_grab()
}