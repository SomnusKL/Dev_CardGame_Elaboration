if (global.phase == global.phase_select)&&(in_hand == true){
	
	//raise the card to highlight it if it's in the hand and the mouse is over it
	if (position_meeting(mouse_x, mouse_y, id)){
		show_debug_message("find id");
		//also set this variable so we know which card to play if there's a click
		global.selected_card = id;
	}
	else if (global.selected_card == id){

		global.selected_card = noone;
	}
	
	
}