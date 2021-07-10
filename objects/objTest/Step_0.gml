if (keyboard_check_pressed(ord("S")))
{
    var _string = "test string";
    var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    
    SaveBufferToFile(_buffer, "test.txt", 0, buffer_get_size(_buffer), function(_ticket)
    {
        show_message("Saved \"" + _ticket.filename + "\"");
    });
}

if (keyboard_check_pressed(ord("L")))
{
    LoadBufferFromFile(buffer_create(1, buffer_grow, 1), "test.txt", function(_ticket)
    {
        if (_ticket.result == "success")
        {
            var _string = buffer_read(_ticket.buffer, buffer_text);
            show_message(_string);
        }
        else
        {
            show_message("An error occurred");
        }
        
        buffer_delete(_ticket.buffer);
    });
}

if (keyboard_check_pressed(ord("D")))
{
    DeleteFile("test.txt", function(_ticket)
    {
        if (_ticket.result == "success")
        {
            show_message("File deleted");
        }
        else
        {
            show_message("An error occurred");
        }
    });
}