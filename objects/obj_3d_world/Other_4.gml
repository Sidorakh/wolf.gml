/// @description 


var world = vbuff;
var is_block = function (inst) {
	return (inst != noone && inst.object_index == obj_block);
}

var is_door = function (inst) {
	return (inst != noone && object_is_ancestor(inst.object_index,obj_door));
}

vertex_begin(vbuff,format)

with (obj_block) {
	if (object_index == obj_push_block) {
		continue;
	}
	if (object_is_ancestor(object_index,obj_door)) {
		continue;
	}
	if (object_is_ancestor(object_index,obj_thing)) {
		continue;	
	}
	// skip any things and dynamic blocks
	
	var north = instance_place(x,y-1,obj_block);
	var south = instance_place(x,y+1,obj_block);
	var east = instance_place(x-1,y,obj_block);
	var west = instance_place(x+1,y,obj_block);
	
	var uvs = get_wall_uvs(global.resources.walls,texture);
	var ns_uvs = get_wall_uvs(global.resources.walls,texture);
	var ew_uvs = get_wall_uvs(global.resources.walls,texture+1);
	var o_ns_uvs = ns_uvs;
	var o_ew_uvs = ew_uvs;
	
	if (!is_block(north) || is_door(north)) {

		if (is_door(north)) {
			ns_uvs = get_wall_uvs(global.resources.walls,north.side);
		}
		// bottom right
		vertex_position_3d(world,x,y,64);
		vertex_texcoord(world,ns_uvs.x2,ns_uvs.y2);
		vertex_color(world,c_white,1);
		// bottom left
		vertex_position_3d(world,x+64,y,64);
		vertex_texcoord(world,ns_uvs.x1,ns_uvs.y2);
		vertex_color(world,c_white,1);
		// top left
		vertex_position_3d(world,x+64,y,0);
		vertex_texcoord(world,ns_uvs.x1,ns_uvs.y1);
		vertex_color(world,c_white,1);
		
		// bottom right
		vertex_position_3d(world,x,y,64);
		vertex_texcoord(world,ns_uvs.x2,ns_uvs.y2);
		vertex_color(world,c_white,1);
		// top right
		vertex_position_3d(world,x,y,0);
		vertex_texcoord(world,ns_uvs.x2,ns_uvs.y1);
		vertex_color(world,c_white,1);
		// top left
		vertex_position_3d(world,x+64,y,0);
		vertex_texcoord(world,ns_uvs.x1,ns_uvs.y1);
		vertex_color(world,c_white,1);
		
		ns_uvs = o_ns_uvs;
	}
	if (!is_block(south) || is_door(south)) {
		if (is_door(south)) {
			ns_uvs = get_wall_uvs(global.resources.walls,south.side);
		}
		// bottom right
		vertex_position_3d(world,x+64,y+64,64);
		vertex_texcoord(world,ns_uvs.x2,ns_uvs.y2);
		vertex_color(world,c_white,1);
		// bottom left
		vertex_position_3d(world,x,y+64,64);
		vertex_texcoord(world,ns_uvs.x1,ns_uvs.y2);
		vertex_color(world,c_white,1);
		// top right
		vertex_position_3d(world,x+64,y+64,0);
		vertex_texcoord(world,ns_uvs.x2,ns_uvs.y1);
		vertex_color(world,c_white,1);
		
		// top left
		vertex_position_3d(world,x,y+64,0);
		vertex_texcoord(world,ns_uvs.x1,ns_uvs.y1);
		vertex_color(world,c_white,1);
		// top right
		vertex_position_3d(world,x+64,y+64,0);
		vertex_texcoord(world,ns_uvs.x2,ns_uvs.y1);
		vertex_color(world,c_white,1);
		// bottom left
		vertex_position_3d(world,x,y+64,64);
		vertex_texcoord(world,ns_uvs.x1,ns_uvs.y2);
		vertex_color(world,c_white,1);
		
		ns_uvs = o_ns_uvs;
	}
	if (!is_block(east) || is_door(east)) {
		if (is_door(east)) {
			ew_uvs = get_wall_uvs(global.resources.walls,east.side);
		}
		// bottom left
		vertex_position_3d(world,x,y,64);
		vertex_texcoord(world,ew_uvs.x1,ew_uvs.y2);
		vertex_color(world,c_white,1);
		// bottom right
		vertex_position_3d(world,x,y+64,64);
		vertex_texcoord(world,ew_uvs.x2,ew_uvs.y2);
		vertex_color(world,c_white,1);
		// top right
		vertex_position_3d(world,x,y+64,0);
		vertex_texcoord(world,ew_uvs.x2,ew_uvs.y1);
		vertex_color(world,c_white,1);
		
		// bottom left
		vertex_position_3d(world,x,y,64);
		vertex_texcoord(world,ew_uvs.x1,ew_uvs.y2);
		vertex_color(world,c_white,1);
		// top right
		vertex_position_3d(world,x,y+64,0);
		vertex_texcoord(world,ew_uvs.x2,ew_uvs.y1);
		vertex_color(world,c_white,1);
		// top left
		vertex_position_3d(world,x,y,0);
		vertex_texcoord(world,ew_uvs.x1,ew_uvs.y1);
		vertex_color(world,c_white,1);
		
		ew_uvs = o_ew_uvs;
	}
	if (!is_block(west) || is_door(west)) {
		if (is_door(west)) {
			ew_uvs = get_wall_uvs(global.resources.walls,west.side);
		}
		// bottom right
		vertex_position_3d(world,x+64,y,64);
		vertex_texcoord(world,ew_uvs.x2,ew_uvs.y2);
		vertex_color(world,c_white,1);
		// bottom left
		vertex_position_3d(world,x+64,y+64,64);
		vertex_texcoord(world,ew_uvs.x1,ew_uvs.y2);
		vertex_color(world,c_white,1);
		// top left
		vertex_position_3d(world,x+64,y+64,0);
		vertex_texcoord(world,ew_uvs.x1,ew_uvs.y1);
		vertex_color(world,c_white,1);
		
		// bottom right
		vertex_position_3d(world,x+64,y,64);
		vertex_texcoord(world,ew_uvs.x2,ew_uvs.y2);
		vertex_color(world,c_white,1);
		// top left
		vertex_position_3d(world,x+64,y+64,0);
		vertex_texcoord(world,ew_uvs.x1,ew_uvs.y1);
		vertex_color(world,c_white,1);
		// top right
		vertex_position_3d(world,x+64,y,0);
		vertex_texcoord(world,ew_uvs.x2,ew_uvs.y1);
		vertex_color(world,c_white,1);
		
		ew_uvs = o_ew_uvs;
	}
	
}
vertex_end(vbuff);
vertex_freeze(vbuff);


with (obj_push_block) {

	var ns_uvs = get_wall_uvs(global.resources.walls,texture);
	var ew_uvs = get_wall_uvs(global.resources.walls,texture+1);
	vbuff = vertex_create_buffer();
	vertex_begin(vbuff,other.format);
		
	// bottom right
	vertex_position_3d(vbuff,0,0,64);
	vertex_texcoord(vbuff,ns_uvs.x2,ns_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// bottom left
	vertex_position_3d(vbuff,64,0,64);
	vertex_texcoord(vbuff,ns_uvs.x1,ns_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top left
	vertex_position_3d(vbuff,64,0,0);
	vertex_texcoord(vbuff,ns_uvs.x1,ns_uvs.y1);
	vertex_color(vbuff,c_white,1);
		
	// bottom right
	vertex_position_3d(vbuff,0,0,64);
	vertex_texcoord(vbuff,ns_uvs.x2,ns_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top right
	vertex_position_3d(vbuff,0,0,0);
	vertex_texcoord(vbuff,ns_uvs.x2,ns_uvs.y1);
	vertex_color(vbuff,c_white,1);
	// top left
	vertex_position_3d(vbuff,64,0,0);
	vertex_texcoord(vbuff,ns_uvs.x1,ns_uvs.y1);
	vertex_color(vbuff,c_white,1);
	
	// bottom right
	vertex_position_3d(vbuff,64,64,64);
	vertex_texcoord(vbuff,ns_uvs.x2,ns_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// bottom left
	vertex_position_3d(vbuff,0,64,64);
	vertex_texcoord(vbuff,ns_uvs.x1,ns_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top right
	vertex_position_3d(vbuff,64,64,0);
	vertex_texcoord(vbuff,ns_uvs.x2,ns_uvs.y1);
	vertex_color(vbuff,c_white,1);
		
	// top left
	vertex_position_3d(vbuff,0,64,0);
	vertex_texcoord(vbuff,ns_uvs.x1,ns_uvs.y1);
	vertex_color(vbuff,c_white,1);
	// top right
	vertex_position_3d(vbuff,64,64,0);
	vertex_texcoord(vbuff,ns_uvs.x2,ns_uvs.y1);
	vertex_color(vbuff,c_white,1);
	// bottom left
	vertex_position_3d(vbuff,0,64,64);
	vertex_texcoord(vbuff,ns_uvs.x1,ns_uvs.y2);
	vertex_color(vbuff,c_white,1);
	
	
	// bottom left
	vertex_position_3d(vbuff,0,0,64);
	vertex_texcoord(vbuff,ew_uvs.x1,ew_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// bottom right
	vertex_position_3d(vbuff,0,64,64);
	vertex_texcoord(vbuff,ew_uvs.x2,ew_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top right
	vertex_position_3d(vbuff,0,64,0);
	vertex_texcoord(vbuff,ew_uvs.x2,ew_uvs.y1);
	vertex_color(vbuff,c_white,1);
		
	// bottom left
	vertex_position_3d(vbuff,0,0,64);
	vertex_texcoord(vbuff,ew_uvs.x1,ew_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top right
	vertex_position_3d(vbuff,0,64,0);
	vertex_texcoord(vbuff,ew_uvs.x2,ew_uvs.y1);
	vertex_color(vbuff,c_white,1);
	// top left
	vertex_position_3d(vbuff,0,0,0);
	vertex_texcoord(vbuff,ew_uvs.x1,ew_uvs.y1);
	vertex_color(vbuff,c_white,1);
	// bottom right
	vertex_position_3d(vbuff,64,0,64);
	vertex_texcoord(vbuff,ew_uvs.x2,ew_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// bottom left
	vertex_position_3d(vbuff,64,64,64);
	vertex_texcoord(vbuff,ew_uvs.x1,ew_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top left
	vertex_position_3d(vbuff,64,64,0);
	vertex_texcoord(vbuff,ew_uvs.x1,ew_uvs.y1);
	vertex_color(vbuff,c_white,1);
		
	// bottom right
	vertex_position_3d(vbuff,64,0,64);
	vertex_texcoord(vbuff,ew_uvs.x2,ew_uvs.y2);
	vertex_color(vbuff,c_white,1);
	// top left
	vertex_position_3d(vbuff,64,64,0);
	vertex_texcoord(vbuff,ew_uvs.x1,ew_uvs.y1);
	vertex_color(vbuff,c_white,1);
	// top right
	vertex_position_3d(vbuff,64,0,0);
	vertex_texcoord(vbuff,ew_uvs.x2,ew_uvs.y1);
	vertex_color(vbuff,c_white,1);
		
	vertex_end(vbuff);
	vertex_freeze(vbuff);
		
	array_push(other.dynamic,vbuff);
}