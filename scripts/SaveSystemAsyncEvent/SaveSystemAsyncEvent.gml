function SaveSystemAsyncEvent()
{
	var _error  = async_load[? "error" ];
	var _id     = async_load[? "id"    ];
	var _status = async_load[? "status"];
    
	if (ds_map_exists(global.__saveSystemOperations, _id))
	{
        //Figure out which ticket this async ID corresponds to
        var _ticket = global.__saveSystemOperations[? _id];
        ds_map_delete(global.__saveSystemOperations, _id);
        
	    if ((_error != 0) || !_status)
	    {
            // :(
            _ticket.result = "error";
	    }
	    else switch(_ticket.operation)
	    {
            case "load":
                //Since async loads sometimes return empty buffers, even if the file doesn't exist, then we do a quick check on the buffer
    	        var _any_data = false;
    	        var _i = 0;
    	        repeat(min(100, buffer_get_size(_ticket.buffer)))
    	        {
    	            if (buffer_peek(_ticket.buffer, _i, buffer_u8) > 0)
    	            {
    	                _any_data = true;
    	                break;
    	            }
                    
    	            ++_i;
    	        }
                
                _ticket.result = _any_data? "success" : "empty";
            break;
            
            case "save":
                //Push this file to the Steam cloud if needed
                if (global.__saveSystemWantCloudSaves)
                {
    	            steam_file_write_file(_ticket.filename, global.__saveSystemGroupName + "\\" + _ticket.filename);
                }
            break;
            
            case "delete":
                //Clean up the 1-byte buffer
                buffer_delete(_ticket.buffer);
            break;
	    }
        
        if (is_method(_ticket.callback)) _ticket.callback(_ticket);
	}
}