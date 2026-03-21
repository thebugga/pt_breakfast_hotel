var _max_channels = 256
var _flags_core = FMOD_INIT.NORMAL;
var _flags_studio = FMOD_STUDIO_INIT.NORMAL;

#macro USE_FMOD_STUDIO true // Are we using FMOD studio (true) or just core (false)?
#macro USE_DEBUG_CALLBACKS true // Should debugging be initialised?

/* If we enable debug callbacks in the macro above set them ON */
if (USE_DEBUG_CALLBACKS)
{
    fmod_debug_initialize(FMOD_DEBUG_FLAGS.LEVEL_LOG, FMOD_DEBUG_MODE.CALLBACK);
}

/* If we want to use FMOD_STUDIO */
if (USE_FMOD_STUDIO)
{
	/*
		If you are only using Studio you need this.
        It creates the Studio System and prints its result to the Output Log.
        It then initialises the system with the previously set variables, printing the result of that function.

        The FMOD Studio System function also initialises the core FMOD system, which is why you do not need to call fmod_system_create() here.
	*/
	fmod_studio_system_create();
	show_debug_message("fmod_studio_system_create: " + string(fmod_last_result()));

	fmod_studio_system_init(_max_channels, _flags_studio, _flags_core);
	show_debug_message("fmod_studio_system_init: " + string(fmod_last_result()));
	
	/*
		FMOD Studio will create an initialize an underlying core system to work with.
	*/
	fmod_main_system = fmod_studio_system_get_core_system();
	fmod_3d_attributes = fmod_studio_system_get_listener_attributes(0);  
}
// If we want to use FMOD Core only
else
{
	/*
		If you are only using Core you only need this.

        It creates and initialises the core FMOD system, printing the result of each call to the Output Log.
	*/
	fmod_main_system = fmod_system_create()
	fmod_3d_attributes = new Fmod3DAttributes();
	show_debug_message("fmod_system_create: " + string(fmod_last_result()))

	fmod_system_init(_max_channels, _flags_core)
	show_debug_message("fmod_system_init: " + string(fmod_last_result()))
}
global.FMOD_default3DAttributes = 
{
	position: 
	{
		x: 0,
		y: 0,
		z: 0
	},
	velocity: 
	{
		x: 0,
		y: 0,
		z: 0
	},
	forward: 
	{
		x: 0,
		y: 0,
		z: 1
	},
	up: 
	{
		x: 0,
		y: 1,
		z: 0
	}
}
attributes3D = global.FMOD_default3DAttributes
attributes3D.position = 
{
	x: camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2),
	y: camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2),
	z: 0
}
fmod_studio_system_set_num_listeners(1)
fmod_studio_system_set_listener_attributes(0, attributes3D)
fmod_studio_system_set_listener_weight(0, 1)

alarm[0] = 1
