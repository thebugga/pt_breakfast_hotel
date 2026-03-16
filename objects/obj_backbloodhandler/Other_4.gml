surface_free(blood_surf)
blood_surf = surface_create(room_width, room_height)

depth = layer_get_depth(layer_get_id("Instances")) + 50