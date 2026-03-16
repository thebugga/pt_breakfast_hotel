function player_slide() 
{
	hsp = movespeed * xscale
	movespeed = approach(movespeed, 0, 0.4);
	image_speed = 0.4;
	sprite_index = spr_player_machslideboost
	if (abs(movespeed) <= 0 || abs(hsp) <= 0)
	{
		state = states.normal;
	}
	if grounded && !particle_contains_sprite(spr_dashcloud)
	{
		with create_effect(x, y, spr_dashcloud)
			image_xscale = other.xscale
	}
	do_grab()
}