with other
{
	if global.laps >= 2 && input.jump.check
	{
		scr_loadcheckpoints();
	}
	else
	{
		if other.collidema
		{
			sprite_index = spr_player_dead
			image_speed = 0.35
			vsp = -8
			hsp = -4
		}
	}
}
collidema = false
if global.laps >= 2
	do_tip("{s}Press [j] to Restart!", 50)
