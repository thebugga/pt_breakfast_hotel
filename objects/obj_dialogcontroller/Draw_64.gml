draw_clear_alpha(c_black, 0.5)
draw_set_font(global.tutorialfont)
textheight = lerp(textheight, string_height(scr_separate_text(dialog[currentdialog][0], screen_w - (rpadding * 2))), 0.1)
var x1 = rpadding
var y1 = screen_h - (((textheight + rpadding) + (padding * 2)))
draw_set_halign(fa_left)
draw_set_valign(fa_top)
for (var xx = 0; xx < 2; xx++)
{
	for (var yy = 3; yy > -1; yy--)
	{
		var dia = dialogchars[xx][yy]
		if is_struct(dia)
		{
			var thetalker = dialog[currentdialog][1] == dia.character
			var isspeaking = false
			var babbler = talk_sprites[dia.character][dia.expression]
			
			if thetalker && displaytext != dialog[currentdialog][0] && babbler.talk != -4
			{
				isspeaking = true
				dia.expression = dialog[currentdialog][2]
			}
			
			if dia.blinktime > 0
				dia.blinktime--
			else
			{
				if displaytext != dialog[currentdialog][0] && babbler.talkblink != -4
					dia.sprite = babbler.talkblink
				else if babbler.idleblink != -4
					dia.sprite = babbler.idleblink
				dia.index = 0
				dia.blinktime = irandom_range(20, 1000)
			}
			
			if dia.sprite != babbler.idleblink && dia.sprite != babbler.talkblink
				dia.sprite = isspeaking ? babbler.talk : babbler.idle
			
			dia.index += 0.35
			if floor(dia.index) > (sprite_get_number(dia.sprite) - 1)
			{
				if dia.sprite == babbler.idleblink || dia.sprite == babbler.talkblink
					dia.sprite = babbler.idle
				dia.index = 0
			}
			
			draw_sprite_ext(dia.sprite, dia.index, xx ? (screen_w - rpadding - (75 * yy)) : (rpadding + (75 * yy)) + (irandom_range(-effect_shake, effect_shake) * thetalker), y1 + (irandom_range(-effect_shake, effect_shake) * thetalker), xx ? -1 : 1, 1, 0, thetalker ? c_white : c_gray, 1)
		}
	}
}
var bw = ((screen_w - rpadding) - x1)
var bh = ((screen_h - rpadding) - y1)
draw_sprite(spr_dialogue_rope, 0, (rpadding * 2), screen_h - 6)
draw_sprite(spr_dialogue_rope, 0, (screen_w - (rpadding * 2)), screen_h - 6)
if (!surface_exists(surf))
    surf = surface_create(screen_w, screen_h)
if (!surface_exists(clip))
    clip = surface_create(screen_w, screen_h)
gpu_set_blendmode(bm_normal) 
surface_set_target(clip)
draw_set_alpha(1)
draw_clear(c_white)
gpu_set_blendmode(bm_subtract)
draw_sprite_ext(spr_dialogue_bubble, 0, x1, y1 - 8, (bw / sprite_get_width(spr_dialogue_bubble)), (bh / sprite_get_height(spr_dialogue_bubble)), 0, c_white, 1)
surface_reset_target()
gpu_set_blendmode(bm_normal) 
surface_set_target(surf)
draw_sprite_tiled(bg_secret, 0, 0, 0)
gpu_set_blendmode(bm_subtract)
draw_surface(clip, 0, 0)
gpu_set_blendmode(bm_normal)
surface_reset_target()
draw_set_alpha(1)
draw_surface(surf, 0, 0)
draw_sprite_ext(spr_dialogue_bubble, 1, x1, y1- 8, (bw / sprite_get_width(spr_dialogue_bubble)), (bh / sprite_get_height(spr_dialogue_bubble)), 0, c_white, 1)
draw_set_color(c_black)
draw_special_text((x1 + padding), y1, scr_separate_text(displaytext, screen_w - (rpadding * 2)))
