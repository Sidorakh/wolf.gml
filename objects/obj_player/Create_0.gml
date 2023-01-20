/// @description 

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);

cam = camera_create();
proj_mat = matrix_build_projection_perspective_fov(-60,960/540,1,16000);
camera_set_proj_mat(cam,proj_mat);

view_enabled = true;
view_visible[0] = true;
view_camera[0] = cam;

angle = 0;
spd = 0
strafespd = 0;

maxspd = 5;

height = 32;


tex = 0;