
var width = sprite_get_width(global.resources.walls);

var identity = matrix_build_identity();
matrix_set(matrix_world,matrix_build(x+0,y+32,0,270,0,0,1,1,1));

var x1 = uvs.x1*width;
var x2 = uvs.x2*width;
var y1 = uvs.y1*width;
var y2 = uvs.y2*width;

var w = x2-x1;
var h = y2-y1;

draw_sprite_part(global.resources.walls,0,x1,y1,w,h,-door_offset,0);

matrix_set(matrix_world,identity);