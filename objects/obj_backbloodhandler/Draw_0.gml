if !surface_exists(blood_surf)
	blood_surf = surface_create(room_width, room_height)

var temp_surf2 = surface_create(screen_w, screen_h)
var cam_pos = obj_camera.campos

surface_set_target(temp_surf2)
draw_clear_alpha(c_white, 1)

gpu_set_blendmode(bm_subtract)
for (var b = 0; b < array_length(bloods); b++)
{
	with bloods[b]
	{
		if room == myroom
			draw_sprite_ext(sprite, index, x - cam_pos.x, y - cam_pos.y, scale, scale, rotate, c_white, 1)
	}
}
gpu_set_blendmode(bm_normal)

surface_reset_target()

surface_set_target(blood_surf)
draw_clear_alpha(c_black, 0)

shader_set(shd_colourise)

var s_intensity = shader_get_uniform(shd_colourise, "g_Intensity");
var s_color = shader_get_uniform(shd_colourise, "g_TintCol");
shader_set_uniform_f(s_intensity, 1.0);
shader_set_uniform_f(s_color, 1, 0, 0, 1);

var lays = array_reverse(layer_get_all())
for (var l = 0; l < array_length(lays); l++)
{
	if layer_get_depth(lays[l]) < layer_get_depth(layer_get_id("Instances")) || layer_get_depth(lays[l]) < layer_get_depth(layer_get_id("Instances_1"))
	{
		var layelements = layer_get_all_elements(lays[l])
		for (var L = 0; L < array_length(layelements); L++)
		{
			if layer_get_element_type(layelements[L]) == layerelementtype_tilemap
				draw_tilemap(layelements[L], 0, 0)
		}
	}
}

shader_reset();

gpu_set_blendmode(bm_subtract)
draw_surface(temp_surf2, cam_pos.x, cam_pos.y)
gpu_set_blendmode_normal_fixed()

surface_reset_target()

surface_free(temp_surf2)

draw_surface(blood_surf, 0, 0)