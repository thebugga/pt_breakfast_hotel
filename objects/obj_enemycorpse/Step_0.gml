x += hsp
y += vsp
vsp += grav

if !bbox_in_camera()
	instance_destroy()

	
var randomsprite = spr_paintSplatterTest_big
array_push(obj_backbloodhandler.bloods, {
	myroom: room,
	sprite: spr_paintSplatterTest_big,
	index: irandom(sprite_get_number(spr_paintSplatterTest_big) - 1),
	x: x,
	y: y,
	scale: random_range(0.1,1.5),
	rotate: irandom(360),
	depth: depth 
})