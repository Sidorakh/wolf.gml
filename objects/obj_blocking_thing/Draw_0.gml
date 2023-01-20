/// @description 

var w = sprite_get_width(global.resources.things);

var x1 = uvs.x1*w;
var x2 = uvs.x2*w;
var y1 = uvs.y1*w;
var y2 = uvs.y2*w;

var width = x2-x1;

//draw_sprite_part_billboard(global.resources.things,0,x1,y1,x2-x1,y2-y1,x+32,y+32,0,obj_player_3d.id);
var dir = 0;

if (instance_exists(obj_player)) {
	dir = obj_player.angle + 90;
	
}
matrix_set(matrix_world,matrix_build(x,y,0,270,0,dir,1,1,1));

draw_sprite_part_ext(global.resources.things,0,x1,y1,x2-x1,y2-y1,(width/2),0,-1,1,c_white,1);

matrix_set(matrix_world,matrix_build_identity());


draw_sprite(sprite_index,image_index,x-32,y-32);