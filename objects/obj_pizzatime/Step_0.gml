if up
	y -= 5;
if (y <= -50)
	instance_destroy();
if (y == screen_h / 2)
{
	up = false;
	image_yscale = twerp(TwerpType.out_bounce, image_yscale, 1.5, 0.1);
	image_xscale = twerp(TwerpType.out_bounce, image_xscale, 1.5, 0.1);
	if (image_angle < 360)
		image_angle = min(image_angle + 5, 360);
	alarm_thing--
}
if alarm_thing = 0
{
	image_yscale = twerp(TwerpType.inout_quad, image_yscale, 1,  0.08);
	image_xscale = twerp(TwerpType.inout_quad, image_xscale, 1,  0.08);
	up = true
}