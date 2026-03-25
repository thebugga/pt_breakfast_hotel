if (!play)
{
	if (!fmod_channel_control_get_paused(music_event))
	{
		fmod_channel_control_set_paused(music_event, true);
	}
}
if room != hotel_soundtest
	fmod_studio_event_instance_stop(music_event, true);