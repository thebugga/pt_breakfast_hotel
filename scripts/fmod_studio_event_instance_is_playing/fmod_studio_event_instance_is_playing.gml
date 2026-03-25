function fmod_studio_event_instance_is_playing(arg0)
{
	return fmod_studio_event_instance_get_playback_state(arg0) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING;
}