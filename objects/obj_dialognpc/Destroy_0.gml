with (instance_create(x, y, obj_enemycorpse))
	sprite_index = other.deathspr
scr_sound_3d(sfx_killenemy, x, y)
repeat (3)
	particle_create(x, y, particles.hurtstar)
particle_create(x, y, particles.bang)
quick_ini_write_real($"saves/saveData{global.savefile}.ini", "NPC", deathsavename, 1)