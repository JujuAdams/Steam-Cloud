function LoadBufferFromFile(_buffer, _filename, _callback)
{
    //Save our buffer but using our previously established group name
    //If we're using Steam, this'll be the user ID
    buffer_async_group_begin(global.__saveSystemGroupName);
    buffer_load_async(_buffer, _filename, 0, -1);
    var _id = buffer_async_group_end();
    
    //Create a ticket that contains information about this operation
    var _ticket = {
        id: _id,
        operation: "load",
        groupName: global.__saveSystemGroupName,
        buffer: _buffer,
        result: "pending",
        filename: _filename,
        callback: _callback,
    };
    
    global.__saveSystemOperations[? _id] = _ticket;
    return _ticket;
}