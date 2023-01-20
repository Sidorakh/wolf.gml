

function WolfMap(ep,m) constructor {
	episode = ep;
	mission = m;
	tiles = array_create_ext(64,function(){return array_create(64,0)});
	things = array_create_ext(64,function(){return array_create(64,0)});
	offset = 0;
	name = "";
	planes = [
		{offset:-4,length:-5},
		{offset:-4,length:-5},
		{offset:-4,length:-5},
	];
	width = 64;
	height = 64;
}

/// @description Decodes all available maps, returns arrays that can construct levels
/// @param fname_maphead {String} Path to MAPHEAD.WL* file
/// @param fname_gamemaps {String} Path to MAPFILE.WL* file

function wolf_decode_map_files(fname_maphead,fname_gamemaps) {
	var maps = [];
	var maphead = buffer_load(fname_maphead);
	var gamemaps = buffer_load(fname_gamemaps);
	var rlew = buffer_read(maphead,buffer_u16);
	
	var i = 0;
	repeat (100) {	// 100 missions maximum
		i++;
		var offset = buffer_read(maphead,buffer_u32);
		if (offset == 0) break; // break @ blank offset
		var map = new WolfMap(i div 10, i mod 10);
		map.offset = offset;
		array_push(maps,map);
	}
	i = 0;
	repeat (array_length(maps)) {
		var map = maps[i];
		buffer_seek(gamemaps,buffer_seek_start,map.offset);
		var p = 0;
		repeat (3) {
			map.planes[p].offset = buffer_read(gamemaps,buffer_u32);
			p++;
		}
		p = 0;
		repeat (3) {
			map.planes[p].length = buffer_read(gamemaps,buffer_u16);
			p++;
		}
		map.width = buffer_read(gamemaps,buffer_u16);
		map.height = buffer_read(gamemaps,buffer_u16);
		var name_finished = false;
		repeat (16) {
			if (name_finished == false) {
				var c = buffer_read(gamemaps,buffer_u8);
				if (c == 0) {
					name_finished = true;
				} else {
					map.name += chr(c);
				}
			}
		}
		
		// and now to decompress the map
		var level_buffer_carmack = buffer_create(map.planes[0].length,buffer_fixed,1);
		buffer_copy(gamemaps,map.planes[0].offset,map.planes[0].length,level_buffer_carmack,0);
		
		var level_buffer_rlew = carmack_decompress(level_buffer_carmack);
		var level_buffer = rlew_decompress(level_buffer_rlew,rlew);
		
		var thing_buffer_carmack = buffer_create(map.planes[1].length,buffer_fixed,1);
		buffer_copy(gamemaps,map.planes[1].offset,map.planes[1].length,thing_buffer_carmack,0);
		
		var thing_buffer_rlew = carmack_decompress(thing_buffer_carmack);
		var thing_buffer = rlew_decompress(thing_buffer_rlew,rlew);
		
		show_message(buffer_tell(level_buffer));
		
		var b = 0;
		repeat (map.width * map.height) {
			var tx = b mod map.width;
			var ty = b div map.height;
			var tile = buffer_read(level_buffer,buffer_u16);
			var thing = buffer_read(thing_buffer,buffer_u16);
			map.tiles[ty][tx] = tile;
			map.things[ty][tx] = thing;
			b++;
		}
		
		buffer_delete(level_buffer_carmack);
		buffer_delete(level_buffer_rlew);
		buffer_delete(level_buffer);
		buffer_delete(thing_buffer_carmack);
		buffer_delete(thing_buffer_rlew);
		buffer_delete(thing_buffer);
		
	}
	
	return maps;
}

function build_map(map) {
	
	for (var ty = 0; ty < map.height; ty += 1) {
		for (var tx = 0; tx < map.width; tx += 1) {
			var inst = noone;
			var tile = map.tiles[ty][tx];
			var thing = map.things[ty][tx];
			if (tile < 64) {
				if (thing == 98) {
					// pushwall
					inst = instance_create_layer(tx*64,ty*64,layer,obj_push_block);
				} else {
					inst = instance_create_layer(tx*64,ty*64,layer,obj_block);
				}
				inst.change_texture(tile * 2);
			}
			if (tile == 90) {
				// door - north/south
				inst = instance_create_layer(tx*64,ty*64,layer,obj_door_ns);
			}
			if (tile == 91) {
				// door - east/west
				inst = instance_create_layer(tx*64,ty*64,layer,obj_door_ew);
			}
			if (thing == 19 || thing == 20 || thing == 21 || thing == 22) {
				inst = instance_create_layer(tx*64,ty*64,layer,obj_player_spawn);
			}
		}
	}
	
}