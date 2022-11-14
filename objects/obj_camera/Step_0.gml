/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

if (shake == true){
	var ran_x = random_range(-15,15);
	var ran_y = random_range(-15,15);
	camera_set_view_pos(view_camera[0], 0+ran_x, 0 + ran_y);
	view_x = camera_get_view_x (view_camera[0]);
	view_y = camera_get_view_y (view_camera[0]);
}