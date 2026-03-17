function draw_special_text(_x, _y, _text)
{
	var saved_h = draw_get_halign()
	var saved_v = draw_get_valign()
	var saved_font = draw_get_font()
	var saved_col = draw_get_color()
	var text_arr = string_split(_text, "\n")
	var cur_modify = 0
	var cur_color = [saved_col]
	for (var t = 0; t < array_length(text_arr); t++)
	{
		var tempcol = 0
		var xx = _x
		if saved_h == fa_center
			xx -= (string_width(text_arr[t]) / 2)
		if saved_h == fa_right
			xx -= string_width(text_arr[t])
			
		var yy = _y + (string_height(text_arr[t]) * t)
		if saved_v == fa_middle
			yy -= (string_height(_text) / 2)
		if saved_v == fa_bottom
			yy -= string_height(_text)
		
		for (var i = 1; i < string_length(text_arr[t]) + 1; i++)
		{
			draw_set_align(fa_left, fa_top)
			draw_set_font(saved_font)
			draw_set_color(cur_color[tempcol % array_length(cur_color)])
			
			var modifX = 0
			var modifY = 0
			switch cur_modify
			{
				case 1:
					modifX = irandom_range(-1, 1)
					modifY = irandom_range(-1, 1)
					break
				case 2:
					modifX = 0
					modifY = wave(-2, 2, 1, (i / 10) % 10)
					break
			}
			
			var letter = string_char_at(text_arr[t], i)
			if letter == "{"
			{
				var chopoff = 0
				do 
					chopoff++
				until string_char_at(text_arr[t], i + chopoff) == "}"
				
				if string_char_at(text_arr[t], i + 1) == "n"
					cur_modify = 0
				else if string_char_at(text_arr[t], i + 1) == "s"
					cur_modify = 1
				else if string_char_at(text_arr[t], i + 1) == "w"
					cur_modify = 2
				
				i += chopoff
			}
			else if letter == "|"
			{
				var chopoff = 0
				do 
					chopoff++
				until string_char_at(text_arr[t], i + chopoff) == "|"
				
				var colors = string_split(string_copy(text_arr[t], i + 1, chopoff - 1), ",")
				
				for (var c = 0; c < array_length(colors); c++)
				{
					if string_pos("-", colors[c]) > 0
					{
						var hex = string_split(colors[c], "-")
						colors[c] = make_color_rgb(hex[0], hex[1], hex[2])
					}
					else
					{
						switch colors[c]
						{
							default:
								colors[c] = saved_col
								break
							case "red":
								colors[c] = c_red
								break
							case "orange":
								colors[c] = c_orange
								break
							case "yellow":
								colors[c] = c_yellow
								break
							case "green":
								colors[c] = c_green
								break
							case "blue":
								colors[c] = c_blue
								break
							case "purple":
								colors[c] = c_purple
								break
						}
					}
				}
				cur_color = colors
				
				i += chopoff
			}
			else if letter == "["
			{
				var keymap = ds_map_create()
				ds_map_set(keymap, "[l]", global.keybinds[0].left)
				ds_map_set(keymap, "[r]", global.keybinds[0].right)
				ds_map_set(keymap, "[u]", global.keybinds[0].up)
				ds_map_set(keymap, "[d]", global.keybinds[0].down)
				ds_map_set(keymap, "[j]", global.keybinds[0].jump)
				ds_map_set(keymap, "[g]", global.keybinds[0].grab)
				ds_map_set(keymap, "[m]", global.keybinds[0].dash)
				ds_map_set(keymap, "[t]", global.keybinds[0].taunt)
				ds_map_set(keymap, "[L]", global.keybinds[0].ui_left)
				ds_map_set(keymap, "[R]", global.keybinds[0].ui_right)
				ds_map_set(keymap, "[U]", global.keybinds[0].ui_up)
				ds_map_set(keymap, "[D]", global.keybinds[0].ui_down)
				ds_map_set(keymap, "[A]", global.keybinds[0].ui_accept)
				ds_map_set(keymap, "[R]", global.keybinds[0].ui_deny)
				
				cc_draw_key(xx + modifX, yy + (string_height("A") / 2) - 16 + modifY, ds_map_find_value(keymap, string_copy(text_arr[t], i, 3)))
				xx += 32
				
				ds_map_destroy(keymap)
				i += 2
			}
			else if letter == "<"
			{
				var chopoff = 0
				do 
					chopoff++
				until string_char_at(text_arr[t], i + chopoff) == ">"
				
				var spr = asset_get_index(string_copy(text_arr[t], i + 1, chopoff - 1))
				if spr
				{
					draw_sprite(spr, sprite_get_number(spr) == 1 ? 0 : wrap(sprite_get_number(spr), current_time * 0.0175), xx + modifX, yy + modifY)
					xx += sprite_get_width(spr)
				}
				i += chopoff
			}
			else
			{
				draw_text(xx + modifX, yy + modifY, letter)
				xx += string_width(letter)
				if letter != " "
					tempcol++
			}
		}
		draw_set_halign(saved_h)
		draw_set_valign(saved_v)
	}
	draw_set_color(saved_col)
}

function scr_separate_text(text, width)
{
	text += " "
	var widths = 0
	var fullon_widths = 0
	var _sizer = ""
	var finaltext = ""
	for (var t = 1; t < string_length(text) + 1; t++)
	{
		var letter = string_copy(text, t, 1)
		if letter == "{"
		{
			var chopoff = 0
			do 
				chopoff++
			until string_char_at(text, t + chopoff) == "}"
			_sizer += string_copy(text, t, 1 + chopoff)
			t += chopoff
		}
		else if letter == "|"
		{
			var chopoff = 0
			do 
				chopoff++
			until string_char_at(text, t + chopoff) == "|"
			_sizer += string_copy(text, t, 1 + chopoff)
			t += chopoff
		}
		else if letter == "["
		{
			widths += 32
			_sizer += string_copy(text, t, 3)
			t += 2
		}
		else if letter == "<"
		{
			var chopoff = 0
			do 
				chopoff++
			until string_char_at(text, t + chopoff) == ">"
				
			var spr = asset_get_index(string_copy(text, t + 1, chopoff - 1))
			if spr
				widths += sprite_get_width(spr)
			_sizer += string_copy(text, t, 1 + chopoff)
			t += chopoff
		}
		else
		{
			if letter == " "
			{
				if fullon_widths + widths > width
				{
					widths -= string_width(letter)
					finaltext += string_replace(_sizer, " ", "\n")
					fullon_widths = widths
				}
				else
				{
					finaltext += _sizer
					fullon_widths += widths
				}
				_sizer = letter
				widths = string_width(letter)
			}
			else
			{
				_sizer += letter
				widths += string_width(letter)
			}
		}
	}
	return finaltext
}

function do_dialog(texts = dialog, chars = dialogchars) //do_dialog
{
    with (instance_create(x, y, obj_dialogcontroller))
    {
        npcID = other.id
        dialog = texts
		for (var xx = 0; xx < 2; xx++)
		{
			for (var yy = 0; yy < 4; yy++)
			{
				if chars[xx][yy] != -4
					dialogchars[xx][yy] = {
						sprite: 0,
						index: 0,
						character: chars[xx][yy],
						expression: 0,
						blinktime: irandom(500)
					}
			}
		}
    }
    with (obj_player)
    {
        sprite_index = spr_player_idle
        image_speed = 0.35
        state = states.actor
        hsp = 0
        vsp = 0
        movespeed = 0
    }
}
