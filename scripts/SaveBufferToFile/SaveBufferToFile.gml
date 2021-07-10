function SaveBufferToFile(_buffer, _filename, _offset, _size, _callback)
{
    //Save our buffer but using our previously established group name
    //If we're using Steam, this'll be the user ID
    buffer_async_group_begin(global.__saveSystemGroupName);
    buffer_save_async(_buffer, _filename, _offset, _size);
    var _id = buffer_async_group_end();
    
    //Create a ticket that contains information about this operation
    var _ticket = {
        id: _id,
        groupName: global.__saveSystemGroupName,
        operation: "save",
        result: "pending",
        filename: _filename,
        callback: _callback,
    };
    
    global.__saveSystemOperations[? _id] = _ticket;
    return _ticket;
}