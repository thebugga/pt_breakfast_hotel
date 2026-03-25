if (other.input.up.pressed && other.grounded && other.vsp > 0 && func != noone)
{
	//fmod_event_one_shot_3d("event:/sfx/fakepep/step", x, y);
	func();
}