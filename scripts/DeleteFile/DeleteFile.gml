function DeleteFile(_filename, _callback)
{
    //Delete the file! This bit's important
    file_delete(global.__saveSystemGroupName + "\\" + _filename);
    
    //If we're on Steam then delete this file off of the cloud
    if (global.__saveSystemWantCloudSaves)
    {
        steam_file_delete(_filename);
    }
    else if (SAVE_SYSTEM_ON_DESKTOP)
    {
        show_debug_message("Failed to sync deletion of \"" + _filename + "\" with Steam, check Steam is initialized and cloud permissions are enabled for the user and the app");
    }
    
    //Create a dummy ticket to use for the callback
    var _ticket = {
        id: undefined,
        groupName: global.__saveSystemGroupName,
        operation: "delete",
        result: "success",
        filename: _filename,
        callback: _callback,
    };
    
    //Execute the callback
    if (is_method(_callback)) _callback(_ticket);
    
    return _ticket;
}