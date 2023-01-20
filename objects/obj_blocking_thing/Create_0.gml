/// @description 

function set_thing(index) {
	texture = index;
	uvs = get_thing_uvs(global.resources.things,texture);
}


texture = choose(0,71,105);

uvs = get_thing_uvs(global.resources.things,texture);

set_thing(texture);

// centre on the grid
x += 32;
y += 32;