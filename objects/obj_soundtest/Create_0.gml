music_pos = 0;
play = false;
hasplayed = false;
global.leveltorestart = noone;
music_arr = 
[
	["event:/music/hub", "Quintessence - ClascyJitto"],
	["event:/music/World1/kitchen", "Krazy Kitchen - TheGregEver"],
]
index = 0;
music_event = fmod_studio_event_instance_create(music_arr[0][0]);