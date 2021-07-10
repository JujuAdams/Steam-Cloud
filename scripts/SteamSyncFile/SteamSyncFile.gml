/// @param filename

function SteamSyncFile(_filename)
{
    if (global.__saveSystemWantCloudSaves)
    {
        var _local_filename = global.__saveSystemGroupName + "\\" + _filename;
        
        if (steam_file_exists(_filename))
        {
            //If the desired file is on the Steam cloud then grab it and save it
            var _string = steam_file_read(_filename);
            var _size = string_byte_length(_string);
            show_debug_message("Received \"" + _filename + "\" as string, size=" + string(_size));
            
            if (_size > 0)
            {
                var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
                buffer_write(_buffer, buffer_text, _string);
                buffer_save(_buffer, _local_filename);
                buffer_delete(_buffer);
                
                show_debug_message("Downloaded \"" + _filename + "\" to \"" + _local_filename + "\"");
            }
        }
        else
        {
            //If the file *doesn't* exist on the cloud but it exists locally then we should delete the local file
            if (file_exists(_local_filename))
            {
                show_debug_message("\"" + _filename + "\" not found on Steam Cloud, deleting \"" + _local_filename + "\"");
                file_delete(_local_filename);
            }
        }
    }
    else
    {
        show_debug_message("Failed to sync \"" + _filename + "\" with Steam, check Steam is initialized and cloud permissions are enabled for the user and the app");
    }
}