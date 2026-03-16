surface_free(blood_surf)
blood_surf = surface_create(room_width, room_height)

if layer_exists("Instances")
	depth = layer_get_depth(layer_get_id("Instances")) + 10
if layer_exists("Instances_1")
	depth = layer_get_depth(layer_get_id("Instances_1")) + 10