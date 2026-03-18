if !grounded
    image_speed = 0
else if floor(image_index) != 8
    image_speed = 0.35
else
    image_speed = 0

if collidema
	collide_simple()

if vsp > 10
	vsp = 10
