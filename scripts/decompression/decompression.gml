function carmack_decompress(input) {
	var output = buffer_create(buffer_get_size(input),buffer_grow,1);
	var get_word = method({input: input},function(){return buffer_read(input, buffer_u16)});
	var get_byte = method({input: input},function(){return buffer_read(input, buffer_u8)});
	var put_word = method({output: output},function(word){return buffer_write(output, buffer_u16,word)});
	var put_byte = method({output: output},function(byte){return buffer_write(output, buffer_u8,byte)});
	
	while (buffer_get_distance(input) >= 2) {
		var v = get_word();
		if (v >> 8 == 0xA7) {
			var count = v & 0xFF;
			var distance = get_byte();
			if (count == 0) {	// escaped word
				put_word((v & 0xFF00) | distance);
			} else {
				repeat (count * 2) {
					var byte = buffer_peek(output,buffer_tell(output) - distance*2,buffer_u8);
					put_byte(byte);
				}
			}
		} else if (v >> 8 == 0xA8) {
			var count = v & 0xFF;
			if (count == 0) {
				var low = get_byte();
				put_word((v & 0xFF00) | low);
			} else {
				var distance = get_word();
				repeat (count * 2) {
					var byte = buffer_peek(output,buffer_tell(output) - distance*2,buffer_u8);
					put_byte(byte);
				}
				
			}
		} else {
			put_word(v);	
		}
	}
	return output;
}

function rlew_decompress(input,codeword=0xFEFE) {
	buffer_seek(input,buffer_seek_start,0);
	var output = buffer_create(1,buffer_grow,1);
	while (buffer_get_distance(input) > 1) {
		var v = buffer_read(input,buffer_u16);
		if (v == codeword) {
			if (buffer_get_distance(input) < 4) {
				// EOF here
				break;
			}
			var count = buffer_read(input,buffer_u16);
			var value = buffer_read(input,buffer_u16);
			repeat (count) {
				buffer_write(output,buffer_u16,value);
			}
		} else {
			buffer_write(output,buffer_u16,v);
		}
	}
	if (buffer_get_distance(input) == 1) {
		var byte = buffer_read(input,buffer_u8);
		buffer_write(output,buffer_u8,byte);
	}
	//buffer_seek(output,buffer_seek_start,0);
	return output;
}

function buffer_get_distance(buffer) {
	return buffer_get_size(buffer)-buffer_tell(buffer);
}