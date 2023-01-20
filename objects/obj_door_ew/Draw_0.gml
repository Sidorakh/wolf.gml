
var width = sprite_get_width(global.resources.walls);

var identity = matrix_build_identity();
//matrix_set(matrix_world,matrix_build(x,y,0,270,-32,90,1,1,1));
matrix_set(matrix_world,matrix_build(x+32,y+(64-door_offset),0,270,90,0,1,1,1));

var x1 = uvs.x1*width;
var x2 = uvs.x2*width;
var y1 = uvs.y1*width;
var y2 = uvs.y2*width;

var w = x2-x1;
var h = y2-y1;

draw_sprite_part(global.resources.walls,0,x1,y1,w,h,0,0);
//draw_sprite(sprite_index,0,0,0);

matrix_set(matrix_world,identity);

