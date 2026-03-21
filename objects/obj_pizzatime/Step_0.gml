switch state
{
	case 0:
		y = approach(y, 150, 5)
		if y == 150
		{
			if timer < 60
				timer++
			else
			{
				timer = 0
				state++
				mysound = scr_sound(v_xploshi)
			}
		}
		image_index = 0
	break
	case 1:
		for (var i = 0; i < array_length(speech_array); i++)
		{
			if audio_sound_get_track_position(mysound) >= speech_array[i][0]
			{
				image_index = speech_array[i][1]
				if array_length(speech_array[i]) > 2 && event < speech_array[i][2]
				{
					switch speech_array[i][2]
					{
						case 1:
							text_pos[0][2] = 1.5
							text_pos[1][2] = 1.5
							text_pos[2][2] = 1.5
							text_pos[3][2] = 1.5
						break
						case 2:
							text_pos[4][2] = 1.5
						break
						case 3:
							text_pos[5][2] = 1.5
							text_pos[6][2] = 1.5
							text_pos[7][2] = 1.5
							text_pos[8][2] = 1.5
							text_pos[9][2] = 1.5
							text_pos[10][2] = 1.5
						break
						case 4:
							turning = true
						break
						case 5:
							for (var t = 0; t < array_length(text_pos); t++)
							{
								text_pos[t][2] = 0
								with instance_create(obj_camera.campos.x + x + text_pos[t][0], obj_camera.campos.y + y + text_pos[t][1], obj_pizzatimer_letter)
								{
									hsp = other.text_pos[t][0] / 20 + random_range(-2, 2)
									vsp = irandom_range(-8, -4)
									image_index = t
								}
							}
							sprite_index = spr_explosion
							image_index = 0
							image_speed = 0.35
							image_angle = 0
							image_xscale = 2
							image_yscale = 2
							turning = false
							turner = 0
							scr_sound(sfx_explosion)
							
							state++
						break
					}
					event = speech_array[i][2]
				}
			}
		}
		if turning
		{
			turner += 0.5
			image_angle += turner
		}
	break
	case 2:
		if anim_ended()
			instance_destroy()
	break
}
