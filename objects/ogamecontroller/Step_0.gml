/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码 

if(mouse_check_button(mb_left)){
	//audio_play_sound(snd_click,3,false);
	part_particles_create(global.partSystem, mouse_x, mouse_y, global.ptBasic, 1);
}


if(mouse_check_button_pressed(mb_left)){
audio_play_sound(snd_bubble,2,false);
}