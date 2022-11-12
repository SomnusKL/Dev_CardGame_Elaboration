//lerp to the target x and y, but snap if we're close 
if (abs(x - target_x) > 1) {
	x = lerp(x,target_x,0.3);
	depth = -1000;
}
else {
	x = target_x;
	depth = targetdepth;
}
if (abs(y - target_y) > 1) {
	y = lerp(y,target_y,0.3);
	depth = -1000;
}
else {
	y = target_y;
	depth = targetdepth;
}

//set the appearance based on the state of the card
if (type == global.rock) sprite_index = spr_rock;
if (type == global.paper) sprite_index = spr_paper;
if (type == global.scissors) sprite_index = spr_scissors;


//add two more sprites
if (type == global.bomb) sprite_index = spr_bomb;
if (type == global.peace) sprite_index = spr_peace;
if (face_up == false) sprite_index = spr_back;

//actually draw it
draw_sprite(sprite_index, image_index, x, y);
