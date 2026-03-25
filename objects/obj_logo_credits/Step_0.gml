var _speed = 0.01
if !nextroom
	fade_alpha = max(fade_alpha - _speed, 0)
else
{
	if fade_alpha == 1
		room_goto(mainmenu)
	fade_alpha = min(fade_alpha + _speed, 1)
}