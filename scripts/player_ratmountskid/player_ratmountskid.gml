function player_ratmountskid()
{
	var default_jump = brick ? spr_player_ratjump : spr_player_jump
	if (movespeed >= 12 || gusdashpadbuffer > 0)
		default_jump = brick ? spr_player_ratmach3jump : spr_player_mach3jump
    else if input.dash.check
		default_jump = brick ? spr_player_ratmach2jump : spr_player_mach2jump
	if has_shotgun
		default_jump = spr_player_shotgun_jump
		
	if global.panic.active && global.panic.timer <= 0
			default_jump = spr_player_hurtjump
	
    hsp = xscale * movespeed
    movespeed = approach(movespeed, 0, 0.8)
    sprite_index = brick ? spr_player_ratskid : spr_player_skid
    gustavodash = 0
    image_speed = 0.4
    if movespeed <= 0
    {
        movespeed = 0
		xscale *= -1
        state = states.normal
    }
	if (input_buffers.jump > 0 && coyote_time && sprite_index != spr_player_ratswallow)
    {
        input_buffers.jump = 0
		fmod_studio_event_instance_oneshot_3d("event:/sfx/player/jump", x, y)
		particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
        reset_anim(default_jump)
        if (state != states.normal)
            xscale *= -1
        state = states.ratmountjump
        vsp = -11
        jumpstop = false
    }
	
	do_ratattack()
	
    if (!particle_contains_sprite(spr_jumpdust) && grounded)
        particle_create(x, y, particles.genericpoof, xscale, 1, spr_jumpdust)
}