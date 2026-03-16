with obj_player
{
	var can_bump = state == states.normal ||
				   state == states.normal ||
				   state == states.grab ||
				   state == states.tumble
	if place_meeting(x + xscale, y, other) && can_bump
	{
		sprite_index = spr_player_bump
		state = states.bump
		hsp = 5 * -xscale
		vsp = -5
		grounded = false
		scr_sound_3d(sfx_bumpwall, x, y)
		with other
			reset_anim(sprs.bump)
	}
}
