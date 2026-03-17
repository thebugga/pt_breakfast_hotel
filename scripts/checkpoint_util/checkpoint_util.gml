function scr_savecheckpoints()
{
	var savethestuff = [obj_lapportal.t_room, //0 (you can change this variable if the function is called after you enter a new room instead of before a new room)
	global.laps, //1
	global.panic.active, //2
	global.level_data.toppins.shroom, //3
	global.level_data.toppins.cheese, //4
	global.level_data.toppins.tomato, //5
	global.level_data.toppins.sausage, //6
	global.level_data.toppins.pineapple, //7
	obj_player.hasgerome, //8
	obj_levelcontroller.killed_enemy, //9
	global.secret, //10
	global.score, //11
	global.combo.timer, //12
	global.combo.count, //13
	obj_followerhandler.followers, //14
	global.combo.wasted, //15
	global.doorshut, //16
	global.score, //17
	global.combo, //18
	obj_music.lap2, //19
	global.panicbg, // 20
	obj_music.lap2_init, //21
	global.panic.active]; //22
	
	global.checkpointdata = savethestuff;
	
	ds_list_copy(global.checkpointsaveroom, global.ds_saveroom);
}

function scr_loadcheckpoints()
{
	var loadthestuff = 0;
	if global.checkpointdata != -4
		loadthestuff = global.checkpointdata; //load variables
	else
		exit; //stop incase theres no checkpoint data
	
	do_fade(loadthestuff[0], "LAP", fade_types.generic)
	obj_player.targetDoor = "LAP"
	
	global.laps = loadthestuff[1];
	
	
	if global.laps >= 2
	{
		global.panic.timer = 0;
		if !instance_exists(obj_pizzaface)
			instance_create(obj_player.x, obj_player.y, obj_pizzaface);
	}
	
	//toppins moment
	if loadthestuff[3]
	{
		if !global.level_data.toppins.shroom
		{
			var shroom_sprs = {
				idle: spr_shroomtoppin_idle,
				move: spr_shroomtoppin_move,
				panic: spr_shroomtoppin_panic,
				taunt: spr_shroomtoppin_taunt,
				intro: spr_shroomtoppin_intro,
			}

			with obj_followerhandler
				array_push(followers, create_follower(other.x, other.y, shroom_sprs.idle, shroom_sprs.move, shroom_sprs.panic, shroom_sprs.taunt, shroom_sprs.intro))
		}
		global.level_data.toppins.shroom = true
	}
	if loadthestuff[4]
	{
		if !global.level_data.toppins.cheese
		{
			var cheese_sprs = {
				idle: spr_cheesetoppin_idle,
				move: spr_cheesetoppin_move,
				panic: spr_cheesetoppin_panic,
				taunt: spr_cheesetoppin_taunt,
				intro: spr_cheesetoppin_intro,
			}

			with obj_followerhandler
				array_push(followers, create_follower(other.x, other.y, cheese_sprs.idle, cheese_sprs.move, cheese_sprs.panic, cheese_sprs.taunt, cheese_sprs.intro))
		}
		global.level_data.toppins.cheese = true
	}
	if loadthestuff[5]
	{
		if !global.level_data.toppins.tomato
		{
			var tomato_sprs = {
				idle: spr_tomatotoppin_idle,
				move: spr_tomatotoppin_move,
				panic: spr_tomatotoppin_panic,
				taunt: spr_tomatotoppin_taunt,
				intro: spr_tomatotoppin_intro,
			}

			with obj_followerhandler
				array_push(followers, create_follower(other.x, other.y, tomato_sprs.idle, tomato_sprs.move, tomato_sprs.panic, tomato_sprs.taunt, tomato_sprs.intro))
		}
		global.level_data.toppins.tomato = true
	}
	if loadthestuff[6]
	{
		if !global.level_data.toppins.sausage
		{
			var sausage_sprs = {
				idle: spr_sausagetoppin_idle,
				move: spr_sausagetoppin_move,
				panic: spr_sausagetoppin_panic,
				taunt: spr_sausagetoppin_taunt,
				intro: spr_sausagetoppin_intro,
			}

			with obj_followerhandler
				array_push(followers, create_follower(other.x, other.y, sausage_sprs.idle, sausage_sprs.move, sausage_sprs.panic, sausage_sprs.taunt, sausage_sprs.intro))
		}
		global.level_data.toppins.sausage = true
	}
	if loadthestuff[7]
	{
		if !global.level_data.toppins.pineapple
		{
			var pineapple_sprs = {
				idle: spr_pineappletoppin_idle,
				move: spr_pineappletoppin_move,
				panic: spr_pineappletoppin_panic,
				taunt: spr_pineappletoppin_taunt,
				intro: spr_pineappletoppin_intro,
			}

			with obj_followerhandler
				array_push(followers, create_follower(other.x, other.y, pineapple_sprs.idle, pineapple_sprs.move, pineapple_sprs.panic, pineapple_sprs.taunt, pineapple_sprs.intro))
		}
		global.level_data.toppins.pineapple = true
	}
	
	if loadthestuff[8] //gerome
	{
		with obj_followerhandler
			array_push(followers, create_follower(other.x, other.y, spr_gerome_keyidle, spr_gerome_keymove, spr_gerome_keyidle, spr_gerome_taunt, spr_gerome_collected))
		obj_player.hasgerome = true;
	}

	obj_levelcontroller.killed_enemy = loadthestuff[9];
	global.secret = loadthestuff[10];
	global.score = loadthestuff[11];
	global.combo.timer = loadthestuff[12];
	global.combo.count = loadthestuff[13];
	obj_followerhandler.followers = loadthestuff[14];
	global.combo.wasted = loadthestuff[15];
	global.doorshut  = loadthestuff[16];
	global.score  = loadthestuff[17];
	global.combo = loadthestuff[18];
	obj_music.lap2 = loadthestuff[19];
	global.panicbg = loadthestuff[20];
	//obj_music.lap2_init = loadthestuff[21];
	global.panic.active = loadthestuff[22];

	global.didcheckpoint = true;
	
	ds_list_copy(global.ds_saveroom, global.checkpointsaveroom);
}

function scr_resetcheckpoints()
{
	global.checkpointdata = -4;
	global.didcheckpoint = false;
	ds_list_clear(global.checkpointsaveroom);
}

