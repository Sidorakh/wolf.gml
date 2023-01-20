
function get_wall_uvs(walls,index) {
	// wall textures are 64x64
	// wall sprite is 1024x1024
	
	// test with 1, 17, 50
	// generated texture is square, width and height are identical
	var tex = sprite_get_texture(walls,0);
	var width = texture_get_width(tex);
	var size = (64/1024);
	
	var x1 = (index mod 16) * size;
	var y1 = (index div 16) * size;
	var x2 = x1 + size;
	var y2 = y1 + size;
	return {
		x1: x1,
		y1: y1,
		x2: x2, 
		y2: y2,
	}
	
}


function get_thing_uvs(things,index) {
	var tex = sprite_get_texture(things,0);
	var width = texture_get_width(tex);
	var size = (64/2048);
	var x1 = (index mod 32) * size;
	var y1 = (index div 32) * size;
	var x2 = x1 + size;
	var y2 = y1 + size;
	
	return {
		x1: x1,
		y1: y1,
		x2: x2, 
		y2: y2,
	}
	
}