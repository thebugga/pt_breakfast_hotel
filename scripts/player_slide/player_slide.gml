function player_slide() 
{
	hsp = movespeed * xscale
	movespeed = max(movespeed - 0.4, 0);
	gustavodash = 0;
	ratmount_movespeed = 8;
	image_speed = 0.4;
	sprite_index = spr_player_machslideboost
	if (abs(movespeed) <= 0 || abs(hsp) <= 0)
	{
		state = states.normal;
		xscale *= -1
	}
	if grounded && !particle_contains_sprite(spr_dashcloud)
	{
		with create_effect(x, y, spr_dashcloud)
			image_xscale = other.xscale
	}
	do_grab()
}