draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

for (var t = 0; t < array_length(text_pos); t++)
{
	if text_pos[t][2] > 0
		text_pos[t][2] = lerp(text_pos[t][2], 1, 0.1)
	draw_sprite_ext(spr_pizzatime_text, t, x + text_pos[t][0] + irandom_range(-turner / 10, turner / 10), y + text_pos[t][1] + irandom_range(-turner / 10, turner / 10), text_pos[t][2], text_pos[t][2], 0, c_white, 1)
}
