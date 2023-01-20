/// @description 
vertex_submit(vbuff,pr_trianglelist,sprite_get_texture(global.resources.walls,0));


with (obj_push_block) {
    var offset = matrix_build(x,y,0,0,0,0,1,1,1);
    matrix_set(matrix_world,offset);
    vertex_submit(vbuff,pr_trianglelist,sprite_get_texture(global.resources.walls,0));
}
matrix_set(matrix_world,matrix_build_identity());