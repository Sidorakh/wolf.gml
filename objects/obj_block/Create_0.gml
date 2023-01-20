texture = choose(0);
if (object_index == obj_push_block) {
	texture = 8;
}

ns_uvs = get_wall_uvs(global.resources.walls,texture);
ew_uvs = get_wall_uvs(global.resources.walls,texture+1);


function change_texture(tex) {
	texture = tex;
	ns_uvs = get_wall_uvs(global.resources.walls,texture);
	ew_uvs = get_wall_uvs(global.resources.walls,texture+1);
}