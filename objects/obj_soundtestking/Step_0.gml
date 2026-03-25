with (obj_soundtest)
{
	if (hasplayed)
	{
		with (other)
		{
			sprite_index = spr_king2;
			x = lerp(x, wave(obj_player.x - disx, obj_player.x + disx, max_time, 10, timer), 0.1);
			timer += 20;
		}
	}
	else
	{
		with (other)
		{
			x = lerp(x, obj_player.x, 0.1);
			sprite_index = spr_king1;
			timer = max_time * 0.5 * 20;
		}
	}
}
if obj_player.state != states.jump
	y = lerp(y, obj_player.y, 0.1);