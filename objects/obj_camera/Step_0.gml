/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

var randX = random_range(-shake_Amount, shake_Amount);
var randY = random_range(-shake_Amount, shake_Amount);

camera_set_view_pos(view_camera[0], startCam_x+randX, startCam_y+randY);