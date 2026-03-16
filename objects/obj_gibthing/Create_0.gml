collide_init()

image_index = irandom(image_number - 1)
image_angle = random(180)

hsp = lengthdir_x(4, image_angle)
vsp = lengthdir_y(8, image_angle)
savedvsp = 0
bounces = 4