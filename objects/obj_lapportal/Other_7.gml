if (sprite_index == spr_pizzaportalend && !obj_fade.fade)
{
	image_speed = 0
	image_index = image_number - 1
	do_fade(t_room, "LAP", fade_types.generic)
	ds_list_add(global.ds_saveroom, id)
	ds_list_clear(global.ds_escapesaveroom)
	global.laps++
	obj_music.lap2 = true
	if global.laps <= 2
		obj_music.lap2_init = false
	if global.laps == 2
		global.panic.timer = 0
	global.level_data.lap2 = true
	scr_savecheckpoints()
}
