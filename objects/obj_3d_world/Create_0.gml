/// @description 

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();
format = vertex_format_end() ;

vbuff = vertex_create_buffer();

dynamic = [];


if (room != rm_test) {
	build_map(global.maps[global.current_map]);
}
