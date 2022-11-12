randomize();
//enumerate states for the state machine
global.phase_deal = 0;
global.phase_computer = 1;
global.phase_select = 2;
global.phase_play= 3;
global.phase_result = 4;
global.phase_cleanup = 5;
global.phase_reshuffle = 6;
global.phase = global.phase_deal;

//a global references so a card can tell us if it's selected
global.selected_card = noone;

//enumerate card types
global.peace = 0;
global.bomb = 1;
global.scissors = 2;

//track scores
computer_score = 0;
player_score = 0;

//timer variables
move_timer = 0;
wait_timer = 0;

deck_size = 18;

//create lists
deck = ds_list_create();
hand_computer = ds_list_create();
hand_player = ds_list_create();
discard_pile = ds_list_create();
//create board list
board1 = ds_list_create();
board2 = ds_list_create();
board3 = ds_list_create();

//single card refs for the play, no need for a list there
play_computer = noone;
play_player = noone;

//create card instances and place in deck for start
for (i=0; i<deck_size; i++) {
	var newcard = instance_create_layer(0,0,"Instances",obj_card);
	newcard.face_up = false;
	if (i<deck_size/3){
		newcard.type = global.peace;
	}
	else if (i<2*deck_size/3){
		newcard.type = global.bomb;
	}
	else {
		newcard.type = global.peace;
	}
	ds_list_add(deck,newcard);	
}
	
	
//shuffle
ds_list_shuffle(deck);

//position them nicely
for (i = 0; i<deck_size; i++){
	deck[| i].x = 40;
	deck[| i].y = 320-(2*i);
	deck[| i].target_x = deck[| i].x;
	deck[| i].target_y = deck[| i].y;
	deck[| i].targetdepth = deck_size-i;
}

