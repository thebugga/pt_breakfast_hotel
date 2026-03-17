var currenttext = dialog[currentdialog][0]

if (textbuffer > 0)
    textbuffer--
else if displaytext != currenttext
{
	var nextletter = string_char_at(currenttext, string_length(displaytext) + 1)
	if nextletter == "{"
	{
		var chopoff = 0
		do 
			chopoff++
		until string_char_at(currenttext, string_length(displaytext) + 1 + chopoff) == "}"
		displaytext += string_copy(currenttext, string_length(displaytext) + 1, 1 + chopoff)
	}
	else if nextletter == "["
	{
		var chopoff = 0
		do 
			chopoff++
		until string_char_at(currenttext, string_length(displaytext) + 1 + chopoff) == "]"
		displaytext += string_copy(currenttext, string_length(displaytext) + 1, 1 + chopoff)
	}
	else if nextletter == "<"
	{
		var chopoff = 0
		do 
			chopoff++
		until string_char_at(currenttext, string_length(displaytext) + 1 + chopoff) == ">"
		displaytext += string_copy(currenttext, string_length(displaytext) + 1, 1 + chopoff)
	}
	else if nextletter == "|"
	{
		var chopoff = 0
		do 
			chopoff++
		until string_char_at(currenttext, string_length(displaytext) + 1 + chopoff) == "|"
		displaytext += string_copy(currenttext, string_length(displaytext) + 1, 1 + chopoff)
	}
	else
		displaytext += nextletter
	textbuffer = textspeed
}
if obj_player.input.jump.pressed
{
	if displaytext != currenttext
		displaytext = currenttext
	else
	{
	    if (array_length(dialog[currentdialog]) == 5)
	    {
			var func = dialog[currentdialog][4]
	        if (npcID != noone && instance_exists(npcID))
	        {
	            with (npcID)
	                method(id, func)()
	        }
	        else
	            method(id, func)()
	    }
	    if (currentdialog < (array_length(dialog) - 1))
	    {
	        currentdialog += 1
	        textbuffer = textspeed
	        displaytext = ""
			effect_shake = 0
			if array_length(dialog[currentdialog]) >= 4
			{
				switch dialog[currentdialog][3]
				{
					case "angershake":
					effect_shake = 1
					break
				}
			}
	    }
	    else
	        instance_destroy()
	}
}
