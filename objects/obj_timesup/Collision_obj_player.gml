if other.sprite_index == other.spr_player_dead
	exit;

with other
{
	if global.laps >= 2 && input.jump.check
		scr_loadcheckpoints();
	else
	{
		sprite_index = spr_player_dead
		image_speed = 0.35
		vsp = -8
		hsp = -4
	}
}
