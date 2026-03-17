function quick_ini_read_real(inistr, section, key, value)
{
	ini_open(inistr)
	var b = ini_read_real(section, key, value)
	ini_close()
	return b
}

function quick_ini_write_real(inistr, section, key, value)
{
	ini_open(inistr)
	ini_write_real(section, key, value)
	ini_close()
}