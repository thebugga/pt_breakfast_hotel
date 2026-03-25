event_inherited();
active = true;

func = function()
{
	with (obj_soundtest)
	{
		other.active = false;
		other.alarm[1] = 10;
		music_pos--;
		if (music_pos < 0)
		{
			music_pos = array_length(music_arr) - 1;
		}
		fmod_studio_event_instance_stop(music_event, true);
		music_event = fmod_studio_event_instance_create(music_arr[music_pos][0]);
		if (play)
		{
			fmod_studio_event_instance_start(music_event);
		}
		hasplayed = true;
	}
};