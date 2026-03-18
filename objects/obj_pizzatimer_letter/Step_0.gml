x += hsp
y += vsp
image_angle += hsp * 2
vsp += grav

if touching
{
	if place_meeting(x, y, par_collision)
	{
		touching = false
		hsp = random_range(-5, 5)
		vsp *= -0.25
		ystart = y
		scr_sound(sfx_bumpenemy)
	}
}
else
{
	if y > ystart && !place_meeting(x, y, par_collision)
		touching = true
}

if !bbox_in_camera()
	instance_destroy()