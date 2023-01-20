texture = choose(24,25,98,99,102,103,104,105);
side = 100;
uvs = get_wall_uvs(global.resources.walls,texture);

open_door = instance_create_layer(x,y,layer,obj_door_open)
open_door.sprite_index = sprite_index;
open_door.parent = self;

function change_texture(tex) {
	texture = tex;
	uvs = get_wall_uvs(global.resources.walls,texture);
}

key = WOLF_KEYS.NONE;

open = false;
door_offset = 0;

function use() {
	open = !open;
}