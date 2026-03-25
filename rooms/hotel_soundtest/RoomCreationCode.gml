if obj_music.mu != noone
	fmod_studio_event_instance_stop(obj_music.mu, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
if obj_music.secret_mu != noone
	fmod_studio_event_instance_stop(obj_music.secret_mu, FMOD_STUDIO_STOP_MODE.IMMEDIATE)