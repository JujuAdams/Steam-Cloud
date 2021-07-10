#macro  SAVE_SYSTEM_ON_DESKTOP  ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))

global.__saveSystemWantCloudSaves = false;
global.__saveSystemOperations     = ds_map_create();

var _steam_id = SAVE_SYSTEM_ON_DESKTOP? steam_get_user_steam_id() : -1;
if (_steam_id >= 0)
{
    //Different save folders per user
    global.__saveSystemGroupName = string(_steam_id);
    show_debug_message("Set group name to \"" + global.__saveSystemGroupName + "\"");
    
    global.__saveSystemWantCloudSaves = steam_is_cloud_enabled_for_app() && steam_is_cloud_enabled_for_account();
}
else
{
    //Steam's not booted or there's been some other problem
    global.__saveSystemGroupName = "default";
    show_debug_message("Using fallback group name \"" + global.__saveSystemGroupName + "\"");
}

if (SAVE_SYSTEM_ON_DESKTOP) show_debug_message(global.__saveSystemWantCloudSaves? "Steam Cloud enabled" : "Steam Cloud disabled");