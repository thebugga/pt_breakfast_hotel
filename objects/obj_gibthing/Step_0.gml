if grounded
{
	bounces--
	if bounces > 0
		vsp = savedvsp * (bounces / 4)
	else
		hsp = 0
}
else
{
	if bounces == 4
		savedvsp = -vsp
	image_angle += bounces
}

collide_simple()