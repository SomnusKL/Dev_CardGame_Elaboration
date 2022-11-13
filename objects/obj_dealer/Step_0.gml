//STATE MACHINE
switch (global.phase){
	//deal out the cards, three per player
	case global.phase_deal:
		//move_timer kicks over to 0 every 16 frames
		show_debug_message("enter deal phase");
		if (move_timer == 0){
			
			

			//deal a 3*3 board
			if (ds_list_size(board) < 9){

				var card = deck[| ds_list_size(deck)-1];
				ds_list_delete(deck,ds_list_size(deck)-1);
				card.in_hand=true;
				ds_list_add(board,card);
				
				card.target_x = 220 + 100*count;
				card.target_y = 80 + 150*row;
				count ++;
				audio_play_sound(snd_flip2,0,0);
			}
			if(count == 3){
				row ++;
				count = 0;
			}
			if(ds_list_size(board) == 9){
				wait_timer = 0;
				global.phase = global.phase_select;
				
			}

			
			/*//first deal until the computer hand is full
			if (ds_list_size(hand_computer) < 3){
				var card = deck[| ds_list_size(deck)-1];
				ds_list_delete(deck,ds_list_size(deck)-1);
				ds_list_add(hand_computer,card);
				
				card.target_x = 120 + 100*ds_list_size(hand_computer);
				card.target_y = 80;
			}
			//then deal until player hand is full
			else if (ds_list_size(hand_player) < 3){
				var card = deck[| ds_list_size(deck)-1];
				ds_list_delete(deck,ds_list_size(deck)-1);
				
				card.target_x = 220 + 100*ds_list_size(hand_player);
				card.target_y = 550;
				card.in_hand=true;
				
				ds_list_add(hand_player,card);
			}
			
			//then flip the player cards up and change state
			else {
				for (i=0; i<3; i++){
					hand_player[| i].face_up = true;	
				}
				wait_timer=0;
				global.phase = global.phase_computer;	
			}*/
			
		
		
		}
		break;
		
	
	case global.phase_select:
		show_debug_message("enter select phase");
		
		if (mouse_check_button_pressed(mb_left)){
			//this selected_card variable is set by the card itself
			if (global.selected_card != noone){
				show_debug_message("select");
				//play the card
				var hand_index = ds_list_find_index(board, global.selected_card);
				play_player = board[| hand_index];
				play_player.face_up = true;

				audio_play_sound(snd_flip2,0,0);
				global.phase = global.phase_play;
				global.selected_card = noone;
				wait_timer = 10;
				
			}
		}
		break;
		
	//resolve the winner or loser after a delay	
	
	case global.phase_play:
		show_debug_message("enter play phase");
		wait_timer++;
		if (wait_timer > 100){
			
			global.phase = global.phase_result;
			
			if(play_player.type == global.bomb){
				computer_score ++;
				player_score --;
				audio_play_sound(snd_lose,0,0);
			}
			else if(play_player.type == global.peace){
				player_score ++;
				audio_play_sound(snd_win,0,0);
			}
			/*
			if (play_computer.type == global.paper){
				if (play_player.type == global.rock){
					computer_score ++;
					audio_play_sound(snd_lose,0,0);
				}
				else if (play_player.type == global.scissors){
					player_score ++;
					audio_play_sound(snd_win,0,0);
				}
			}
			else if (play_computer.type == global.rock){
				if (play_player.type == global.scissors){
					computer_score ++;
					audio_play_sound(snd_lose,0,0);
				}
				else if (play_player.type == global.paper){
					player_score ++;
					audio_play_sound(snd_win,0,0);
				}
			}
			if (play_computer.type == global.scissors){
				if (play_player.type == global.paper){
					computer_score ++;
					audio_play_sound(snd_lose,0,0);
				}
				else if (play_player.type == global.rock){
					player_score ++;
					audio_play_sound(snd_win,0,0);
				}
			}*/
			wait_timer = 10;
		}
		break;
		
	//move the cards over to the discard pile after a delay
	case global.phase_result:
		wait_timer++;
		if (move_timer == 0) && (wait_timer>60){
			if (play_computer != noone){
				ds_list_add(discard_pile,play_computer);
				play_computer.target_x = 600;
				play_computer.target_y = 320 - ds_list_size(discard_pile)*2;
				play_computer.targetdepth = deck_size-ds_list_size(discard_pile);
				play_computer = noone;
				audio_play_sound(snd_flip2, 0,0);
			}
			else if (play_player != noone){
				ds_list_add(discard_pile,play_player);
				play_player.target_x = 600;
				play_player.target_y = 320 - ds_list_size(discard_pile)*2;
				play_player.targetdepth= deck_size-ds_list_size(discard_pile);
				play_player.in_hand = false;
				play_player = noone;
				audio_play_sound(snd_flip2, 0,0);
				
			}
			else if (ds_list_size(hand_computer) > 0){
				var card = hand_computer[| 0];
				ds_list_delete(hand_computer, 0);
				ds_list_add(discard_pile, card);
				card.target_y = 320 - ds_list_size(discard_pile)*2;
				card.target_x = 600;
				card.face_up = true;
				card.targetdepth = deck_size-ds_list_size(discard_pile);
				audio_play_sound(snd_flip2, 0,0);
			}
			else if (ds_list_size(hand_player) > 0){
				var card = hand_player[| 0];
				ds_list_delete(hand_player, 0);
				ds_list_add(discard_pile, card);
				card.target_y = 320 - ds_list_size(discard_pile)*2;
				card.target_x = 600;
				card.targetdepth = deck_size-ds_list_size(discard_pile);
				card.in_hand = false;
				audio_play_sound(snd_flip2, 0,0);
			}
			//if there are still cards in the deck, deal them
			else if (ds_list_size(deck) > 0) {
				global.phase = global.phase_deal;	
				wait_timer = 0;
			}
			//...or reshuffle and replace the deck from the discard pile
			else {
				global.phase = global.phase_cleanup;
				wait_timer = 0;
			}
		}
	
		break;
		
	//reshuffle and replace the deck	
	case global.phase_cleanup:
		//first move 'em back into the deck
		if (move_timer%4 == 0){
			audio_play_sound(snd_flip2,0,0);
			var index = ds_list_size(discard_pile)-1;
			if (index >= 0){
				var card = discard_pile[| index];
				
				ds_list_add(deck,card);
				ds_list_delete(discard_pile, index);
				
				card.face_up = false;
				card.target_x = 40;
				card.target_y = 320 - 2*ds_list_size(deck);
				card.targetdepth = deck_size - ds_list_size(deck);
			}
				
		}
		wait_timer++;
		//after a delay, randomize the deck and switch phase to do an animation for it
		if (ds_list_size(deck) == deck_size)&&(wait_timer > 100){
			//reshuffle actual deck 
			ds_list_shuffle(deck);
			// play shuffle anim
			current_card = 0;
			global.phase = global.phase_reshuffle;	
		}
		break;
		
	//this last state just animates the cards into their new shuffled index positions
	case global.phase_reshuffle:
	
		if (move_timer%4 == 0){
			audio_play_sound(snd_flip2,0,0);
			var card = deck[| current_card];
			card.target_y = 320 - 2*current_card;
			card.y = 320 - 5;
			card.targetdepth = deck_size - current_card-1;
			current_card ++;
			
			//ready to deal
			if (current_card == ds_list_size(deck)){
				global.phase = global.phase_deal;
			}	
		
		}

		break;
}

//increment main timer
move_timer++;
if (move_timer ==16){
	move_timer = 0;
}
