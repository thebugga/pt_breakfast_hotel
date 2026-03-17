if quick_ini_read_real($"saves/saveData{global.savefile}.ini", "NPC", deathsavename, 0) == 1
	instance_destroy(self, false)