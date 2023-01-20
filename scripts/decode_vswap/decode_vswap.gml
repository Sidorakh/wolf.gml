function decode_vswap(vswap_fname){
	var vswap = buffer_load(vswap_fname);
	var num_chunks = buffer_read(vswap,buffer_u16);
	var first_sprite= buffer_read(vswap,buffer_u16);
	var first_sound = buffer_read(vswap,buffer_u16);
	
	var chunks = [];
	
	var c = 0;
	var type = WOLF_CHUNK_TYPE.WALL;
	repeat (num_chunks) {
		if (c < first_sprite) {
			type = WOLF_CHUNK_TYPE.WALL;
		} else if (c < first_sound) {
			type = WOLF_CHUNK_TYPE.SPRITE;
		} else {
			type = WOLF_CHUNK_TYPE.SOUND;
		}
		
		var chunk = {
			offset: 0,
			length: 0,
			type: type,
		};
		chunk.offset = buffer_read(vswap,buffer_u32);
		array_push(chunks,chunk);
		c++;
	}
	c = 0;
	repeat (num_chunks) {
		chunks[c].length = buffer_read(vswap,buffer_u16);
		c++;
	}
	
	// decode all the wals
	
	var wall_size = 1024;
	var walls = surface_create(wall_size,wall_size);
	surface_set_target(walls);
	draw_clear(c_white)
	var i = 0;
	c = 0;
	
	repeat (first_sprite) {
		var chunk = chunks[c++];
		buffer_seek(vswap,buffer_seek_start,chunk.offset);
		repeat (chunk.length) {
			var xoff = 0;
			var yoff = 0;
			if (i div 64 >= wall_size)  {
				xoff = ((i div 64) div wall_size) * wall_size;
				yoff = ((i div 64) div wall_size) * 64;
			}
			draw_set_color(PALETTE[buffer_read(vswap,buffer_u8)]);
			draw_point((i div 64) - xoff, i mod 64 + yoff);
			i++;
		}
	}
	surface_reset_target();
	//surface_save(walls,"E:\\dev\\id\\wolfenstein\\walls.png");
	var spr_walls = sprite_create_from_surface(walls,0,0,wall_size,wall_size,0,0,0,0);
	surface_free(walls);
	
	// things!
	var thing_size = 2048;
	var things = surface_create(thing_size,thing_size);
	
	surface_set_target(things);
	draw_clear_alpha(c_white,0);
	
	var num_sprites = first_sound - first_sprite;
	i = 0;
	repeat(num_sprites) {
		var xoff = (i*64 mod thing_size);
		var yoff = (i*64 div thing_size)*64;
		
		var chunk = chunks[first_sprite + i];
		buffer_seek(vswap,buffer_seek_start,chunk.offset);
		var left_col = buffer_peek(vswap,chunk.offset,buffer_u16);
		var right_col = buffer_peek(vswap,chunk.offset+2,buffer_u16);

		var data_min = buffer_peek(vswap,chunk.offset+4,buffer_u16);
		var data_max = buffer_peek(vswap,chunk.offset+6,buffer_u16);
		var pool_offset = chunk.offset + 4 + 2 * ((right_col - left_col) + 1)

		for (var col = left_col; col <= right_col; col++) {
			var col_offset = chunk.offset + buffer_peek(vswap,chunk.offset + 4 + 2 * (col-left_col),buffer_u16);
			var end_row = -1;
			while (end_row != 0) {
				end_row = floor(buffer_peek(vswap,col_offset,buffer_u16) / 2);
				if (end_row == 0) break;
				var start_row = floor(buffer_peek(vswap, col_offset + 4,buffer_u16) / 2);
				col_offset += 6;
				for (var row = start_row;row < end_row; row++) {
					draw_set_color(PALETTE[buffer_peek(vswap,pool_offset,buffer_u8)]);
					draw_point(xoff + ~~col,yoff + ~~row);
					pool_offset += 1;
				}
			}
		}
		i++;
	}
	surface_reset_target();
	//surface_save(things,"E:\\dev\\id\\wolfenstein\\things.png");
	var spr_things = sprite_create_from_surface(things,0,0,thing_size,thing_size,0,0,0,0);
	surface_free(things);
	
	// and now.. sounds!
	// TODO: sounds
	// info can be found here: https://web.archive.org/web/20201206195550/http://gaarabis.free.fr/_sites/specs/wlspec_index.html
	var sounds = [];
	
	
	// and return it all 
	return {walls: spr_walls, things: spr_things, sounds: []}
	

}

