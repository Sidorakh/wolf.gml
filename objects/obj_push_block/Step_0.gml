/// @description 



if (pushed) {
	image_blend = c_red;
	if (x != push_target_x || y != push_target_y) {
		x += push_x * push_speed;
		y += push_y * push_speed;
	}
}