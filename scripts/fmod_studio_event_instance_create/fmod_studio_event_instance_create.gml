function fmod_studio_event_instance_create(event) {
	var event_description = fmod_studio_system_get_event(event)
	var event_instance = fmod_studio_event_description_create_instance(event_description)
	return event_instance;
}