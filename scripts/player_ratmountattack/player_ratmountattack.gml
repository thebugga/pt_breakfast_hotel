function player_ratmountattack()
{
    image_speed = abs(movespeed) / 12
    hsp = movespeed * xscale
    sprite_index = spr_player_finishingblow1
    if grounded
        movespeed = approach(movespeed, 4, 0.1)
    punchtimer--
    if (punchtimer < 0 && ((!input.grab.check) || Ghitwall))
    {
        state = states.normal
        if (hsp != 0)
            xscale = sign(hsp)
    }
    if scr_hitwall(x + xscale, y)
    {
        fmod_studio_event_instance_oneshot_3d("event:/sfx/misc/enemybump", x, y)
        punchtimer = 10
        Ghitwall = true
        create_effect(x, y, spr_bumpeffect)
        movespeed /= 1.5
		xscale *= -1
    }
    if ((input.down.check && grounded && !Ghitwall) || scr_solid(x, y))
        state = states.ratmountcrouch
    if ((input.down.pressed || input.groundpound.pressed) && !grounded && !Ghitwall)
    {
        movespeed = hsp
        state = states.ratmountgroundpound
        image_index = 0
        sprite_index = spr_lonegustavo_groundpoundstart
    }
    
	aftimg_timers.mach.do_it = true
	instakill = true
}