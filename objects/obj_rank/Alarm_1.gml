room_goto(hotel_placeholder)
reset_level()
scr_resetcheckpoints()

with obj_player
{
	x = return_location.x
	y = return_location.y
	spawn = noone
	state = states.actor
	room_goto(return_location.room)
	reset_anim(spr_player_walkfront)
}

global.doorshut = true
global.in_level = false
instance_destroy()
