if instance_exists(ob_control) { var reference_id=ob_control; }
else if instance_exists(ob_deckbuild) { var reference_id=ob_deckbuild; }
else if instance_exists(ob_event) { var reference_id=ob_event; }
//————————————————————————————————————————————————————————————————————————————————————————————————————
if potential_x!=x {
	if potential_x>x {
		var step_x=ceil((potential_x-x)/5);
		x+=step_x;
	}
	else if potential_x<x {
		var step_x=ceil((x-potential_x)/5);
		x-=step_x;
	}
}
if potential_y!=y {
	if potential_y>y {
		var step_y=ceil((potential_y-y)/5);
		y+=step_y;
	}
	else if potential_y<y {
		var step_y=ceil((y-potential_y)/5);
		y-=step_y;
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if effect_damaged>0 { effect_damaged-=0.1; }
//————————————————————————————————————————————————————————————————————————————————————————————————————
if reference_id=ob_control {
	if card_played=true and card_trash=false and y!=potential_y { //attacking
		depth=-100;
	}
	else if card_played=true and card_trash=false and y=potential_y {
		depth=200;
	}
}
//
if reference_id=ob_event and (y>screen_main_y+cam_h or y<screen_main_y) { //getting card
	instance_destroy();
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if card_rename=true {
	var key_input=sc_text_get_input();
	if key_input!="" {
		sc_playsound(sn_click,50,false,false);
		//
		if key_input="+" or key_input="-" {
			if key_input="+" {
				if ob_main.nickname_input!=card_name { card_nickname=ob_main.nickname_input; }
				else { card_nickname=""; }
				//
				var i=-1;
				do {
					i++;
					if ob_main.main_card_serial[i]=card_serial {
						ob_main.main_card_nickname[i]=card_nickname;
					}
				} until (ob_main.main_card_serial[i]=card_serial);
			}
			//
			ob_main.nickname_input="";
			ob_main.nickname_screen=false;
			card_rename=false;
		}
		else if key_input="<" {
			ob_main.nickname_input=string_delete(ob_main.nickname_input,string_length(ob_main.nickname_input),1);
		}
		else if key_input="#" {
			ob_main.nickname_input="";
		}
		else {
			if string_length(ob_main.nickname_input + key_input)<=10 {
				ob_main.nickname_input=ob_main.nickname_input + key_input;
			}
		}
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if card_trash=true {
	card_face=false;
	x=ob_control.card_space_id[10].x;
	y=ob_control.card_space_id[10].y;
	potential_x=x;
	potential_y=y;
	depth=300;
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if reference_id=ob_control and card_cat=0 {
	var vs_card=-1;
	//
	if card_played=true {
		if card_enemy=true { var i=0; } else { var i=5; }
		repeat (5) {
			if ob_control.card_space_id[i].occupy_id=id {
				if (card_enemy=false and ob_control.card_space_id[i-5].occupy_id!=-1) {
					vs_card=ob_control.card_space_id[i-5].occupy_id;
				}
				if (card_enemy=true and ob_control.card_space_id[i+5].occupy_id!=-1) {
					vs_card=ob_control.card_space_id[i+5].occupy_id;
				}
			}
			i++;
		}
	}
	//
	if any_natural_glyph=true {
		if sc_glyph_check(id,ref_glyph_imposter,false) and card_played=true { //glyph: imposter (ditto only)
			if sc_glyph_check(id,ref_glyph_imposter,true) and vs_card!=-1 and vs_card.card_environment=false {
				//transforms only if there's no mist
				if card_id!=vs_card.card_id {
					card_id=vs_card.card_id;
					card_form_value=vs_card.card_form_value;
					sc_pokelist();
					sc_card_level_stats_all(false,false);
					card_name="Ditto";
					effect_damaged=1;
				}
			}
			else if card_id!=132 {
				//transforms back even if there's mist
				card_id=132;
				sc_pokelist();
				sc_card_level_stats_all(false,false);
				effect_damaged=1;
			}
		}
		else if sc_glyph_check(id,ref_glyph_imposter,false) and card_played=false {
			if card_id!=132 {
				card_id=132;
				sc_pokelist();
				sc_card_level_stats_all(false,false);
			}
		}
		//
		if sc_glyph_check(id,ref_glyph_palette,false) and card_played=true { //glyph: palette (smeargle/kecleon)
			if sc_glyph_check(id,ref_glyph_palette,true) and vs_card!=-1 and vs_card.card_environment=false {
				//copies types only if there's no mist
				if card_type_a!=vs_card.card_type_a or card_type_b!=vs_card.card_type_b {
					card_type_a=vs_card.card_type_a;
					card_type_b=vs_card.card_type_b;
					effect_damaged=1;
				}
			}
			else if card_type_a!=00 or card_type_b!=-1 {
				//restores types even if there's mist
				card_type_a=00;
				card_type_b=-1;
				effect_damaged=1;
			}
		}
		else if sc_glyph_check(id,ref_glyph_palette,false) and card_played=false {
			if card_type_a!=00 or card_type_b!=-1 {
				card_type_a=00;
				card_type_b=-1;
			}
		}
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if reference_id=ob_control and card_cat=0 and ((card_enemy=false and card_face=true) or card_enemy=true) {
	var base_atk_multiplier=1, base_atk_divisor=1, base_atk_boost=0, base_def_boost=0, base_atk_divisor_setback=1;
	//
	if any_common_glyph=true {
		if sc_glyph_check(id,ref_glyph_berserk,true) and (card_hp<=(card_full_hp/3) or (card_hp=1 and card_hp!=card_full_hp)) { base_atk_multiplier=2; } //glyph: berserk
		if sc_glyph_check(id,ref_glyph_fork,true) { base_atk_divisor=1.5; } //glyph: fork attack
		if sc_glyph_check(id,ref_glyph_motivation,true) and card_hp=card_full_hp { base_atk_boost+=2; base_def_boost+=2; } //glyph: motivation
	}
	//
	if any_natural_glyph=true {
		if sc_glyph_check(id,ref_glyph_sunlight,true) and card_hp=card_full_hp { //glyph: sunlight (cherubi/cherrim)
			base_atk_boost+=1; base_def_boost+=1;
			if card_id=421 and card_grid_x=12 {
				card_grid_x=13;
				if card_face=true { effect_damaged=1; }}}
		else if card_id=421 and card_grid_x=13 {
			card_grid_x=12;
			if card_face=true { effect_damaged=1; }}
		//
		if sc_glyph_check(id,ref_glyph_might,true) { base_atk_boost+=1; } //glyph: might (azurill/marill/azumarill/meditite/medicham)
		if sc_glyph_check(id,ref_glyph_aegis,true) { base_def_boost+=250; } //glyph: aegis (shedinja)
		if sc_glyph_check(id,ref_glyph_setback,true) { base_atk_divisor_setback=1.5; } //glyph: setback (slakoth/vigoroth/slaking/regigigas)
	}
	//
	if card_played=false and card_trash=false {
		card_atk=ceil(card_full_atk*base_atk_multiplier/base_atk_divisor/base_atk_divisor_setback)+base_atk_boost;
		card_def=card_full_def+base_def_boost;
		if card_def>99 { card_def=99; }
	}
	else if card_played=true and card_trash=false {
		if any_paired_glyph=true {
			if card_enemy=true { var i=0; } else { var i=5; }
			var active_plusle=false, active_minun=false;
			repeat (5) {
				if ob_control.card_space_id[i].occupy_id!=id and ob_control.card_space_id[i].occupy_id!=-1 {
					if ob_control.card_space_id[i].occupy_id.card_id=311 { active_plusle=true; }
					else if ob_control.card_space_id[i].occupy_id.card_id=312 { active_minun=true; }
				}
				i++;
			}
			//
			if sc_glyph_check(id,ref_glyph_magnetism_p,true) and active_minun=true { base_atk_boost+=2; } //glyph: magnetism (plusle)
			else if sc_glyph_check(id,ref_glyph_magnetism_m,true) and active_plusle=true { base_atk_boost+=2; } //glyph: magnetism (minun)
		}
		//
		if card_enemy=true { var i=0; } else { var i=5; }
		repeat (5) {
			if ob_control.card_space_id[i].occupy_id=id {
				card_atk=ceil(card_full_atk*base_atk_multiplier/base_atk_divisor/base_atk_divisor_setback)+
				ob_control.card_space_id[i].card_bonus_atk-ob_control.card_space_id[i].card_penalty_atk+base_atk_boost;
				card_def=card_full_def+ob_control.card_space_id[i].card_bonus_def-ob_control.card_space_id[i].card_penalty_def+base_def_boost;
				if card_atk<0 or card_environment=true { card_atk=0; }
				if card_def<0 { card_def=0; }
				if card_def>99 { card_def=99; }
			}
			i++;
		}
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if card_trash=false and card_enemy=false and reference_id=ob_control {
	if ((mouse_x>=x and mouse_y>=y and mouse_x<x+sprite_width and mouse_y<y+sprite_height) or
	((keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))) and num_in_berrydeck>=0) or
	((keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))) and num_in_maindeck>=0)) {
		if (mouse_x>=x and mouse_y>=y and mouse_x<x+sprite_width and mouse_y<y+sprite_height) {
			if ob_control.card_hold=-1 { ob_main.mouse_cursor=1; }
			else { ob_main.mouse_cursor=2; }
		}
		//
		if (mouse_check_button_pressed(mb_left) or
		((keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))) and num_in_berrydeck>=0) or
		((keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))) and num_in_maindeck>=0)) and
		ob_control.card_draw_click=false and ob_main.cursor_hide=false and card_face=false and ob_control.battler_turn=1 and ob_control.card_hold=-1 and
		((num_in_maindeck>=0 and num_in_maindeck=ob_control.card_maindeck_total-1 and ob_control.card_draw_points>=ob_control.card_drawcost_main) or
		(num_in_berrydeck>=0 and num_in_berrydeck=ob_control.card_berrydeck_total-1 and ob_control.card_draw_points>=ob_control.card_drawcost_berry)) {
			sc_playsound(sn_card,50,false,false);
			ob_control.card_draw_click=true;
			//
			if ob_control.card_hand_total<ob_control.card_hand_max {
				if ob_main.playing_tutorial=false or (ob_main.playing_tutorial=true and
				((num_in_maindeck>=0 and sc_tutorial_conditions(1,-1)) or (num_in_berrydeck>=0 and sc_tutorial_conditions(2,-1)))) {
					ob_control.card_hand_total++;
					ob_control.card_hand[ob_control.card_hand_total-1]=id;
					card_face=true;
					//
					if num_in_maindeck>=0 and num_in_maindeck=ob_control.card_maindeck_total-1 {
						ob_control.card_maindeck_total--;
						ob_control.card_maindeck[num_in_maindeck]=-1;
						num_in_maindeck=-1;
						ob_control.card_draw_points-=ob_control.card_drawcost_main;
					}
					else if num_in_berrydeck>=0 and num_in_berrydeck=ob_control.card_berrydeck_total-1 {
						ob_control.card_berrydeck_total--;
						ob_control.card_berrydeck[num_in_berrydeck]=-1;
						num_in_berrydeck=-1;
						ob_control.card_draw_points-=ob_control.card_drawcost_berry;
					}
				}
			}
			else {
				ob_control.hand_full_draw_warning=true;
				ob_control.tooltip_timer=ob_control.tooltip_timer_max;
			}
		}
	}
	//
	if !mouse_check_button_pressed(mb_left) and
	!(keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))) and
	!(keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))) {
		ob_control.card_draw_click=false;
	}
}
//
else if ((mouse_x>=x and mouse_y>=y and mouse_x<x+sprite_width and mouse_y<y+sprite_height) or auto_turn_add=true) and reference_id=ob_event {
	ob_main.mouse_cursor=1;
	//
	if ((mouse_check_button_pressed(mb_left) and ob_main.cursor_hide=false) or auto_turn_add=true) and y=potential_y and x=potential_x {
		sc_playsound(sn_card,50,false,false);
		//
		if ob_event.show_deck=false {
			if card_face=false {
				if card_cat=0 and (card_enigma=true or card_secret=true or card_shiny=true) {
					sc_playsound(sn_rare_2,50,false,false);
					sc_card_effect(x,y,0,false,true);
				}
				else if (card_cat=1 and card_id=3003) or
				(card_cat=0 and ((card_glyph_a!=-1 and card_glyph_a<glyph_common_amount) or
				(card_glyph_b!=-1 and card_glyph_b<glyph_common_amount) or (card_glyph_c!=-1 and card_glyph_c<glyph_common_amount))) {
					sc_playsound(sn_rare,50,false,false);
					sc_card_effect(x,y,0,false,true);
				}
				else {
					sc_card_effect(x,y,0,false,false);
				}
				//
				card_face=true;
			}
			else {
				//ADD CARD
				if card_cat=0 and ob_main.maindeck_total<maindeck_total_max and ob_event.card_prize>0 {
					ob_main.main_card_id[ob_main.maindeck_total]=card_id;
					ob_main.main_card_nickname[ob_main.maindeck_total]="";
					ob_main.main_card_level[ob_main.maindeck_total]=card_level;
					ob_main.main_card_glyph_a[ob_main.maindeck_total]=card_glyph_a;
					ob_main.main_card_glyph_b[ob_main.maindeck_total]=card_glyph_b;
					ob_main.main_card_glyph_c[ob_main.maindeck_total]=card_glyph_c;
					ob_main.main_card_innate[ob_main.maindeck_total]=card_innate;
					ob_main.main_card_form_value[ob_main.maindeck_total]=card_form_value;
					ob_main.main_card_shiny[ob_main.maindeck_total]=card_shiny;
					for (var i=0; i<=deck_setup_max; i++;) {
						ob_main.serial_card_indeck[ob_main.serial_count][i]=false;
					}
					//
					ob_main.main_card_serial[ob_main.maindeck_total]=ob_main.serial_count;
					ob_main.serial_count++;
					//
					ob_main.maindeck_total++;
					potential_y=screen_main_y+cam_h+2;
				}
				else if card_cat=1 and ob_event.deck_berry_total[card_id-3000]<berrydeck_total_max and ob_event.card_prize>0 and
				(ob_main.option_state[opt_challenge]!=ch_barrenness or ob_main.berrydeck_total<30) {
					ob_main.berry_card_id[ob_main.berrydeck_total]=card_id;
					ob_main.berrydeck_total++;
					potential_y=screen_main_y+cam_h+2;
					//
					//count berries (same as ob_event)
					for (var i=0; i<=3; i++;) {
						ob_event.deck_berry_total[i]=0;
					}
					for (var i=0; i<ob_main.berrydeck_total; i++;) {
						ob_event.deck_berry_total[ob_main.berry_card_id[i]-3000]++;
					}
				}
				else {
					potential_y=screen_main_y-82;
				}
				//
				ob_event.card_prize--;
			}
		}
		else {
			if card_played=false {
				var i=0;
				do {
					if ob_event.event_space_id[i].occupy_id=-1 {
						card_played=true;
						potential_x=ob_event.event_space_id[i].x;
						potential_y=ob_event.event_space_id[i].y;
						ob_event.event_space_id[i].occupy_id=id;
						sc_card_effect(ob_event.event_space_id[i].x,ob_event.event_space_id[i].y,0,true,false);
						//
						if ob_event.event_kind=ref_event_evolution {
							for (var ii=0; ii<8; ii++;) {
								ob_event.evo_list[ii]=card_evo[ii];
							}
						}
						//
						i=ob_event.event_space_total;
					}
					else { i++; }
				} until (i=ob_event.event_space_total);
			}
			else {
				card_played=false;
				instance_position(x,y,ob_card_space).occupy_id=-1;
				ob_event.evolution_retry=false;
			}
		}
	}
	//
	auto_turn_add=false;
}
//
else if mouse_x>=x and mouse_y>=y and mouse_x<x+sprite_width and mouse_y<y+sprite_height and reference_id=ob_deckbuild {
	ob_main.mouse_cursor=1;
	//
	if card_cat=0 {
		if mouse_check_button_pressed(mb_left) and ob_main.cursor_hide=false {
			sc_playsound(sn_card,50,false,false);
			//
			if card_indeck[0]=false and ob_deckbuild.deck_build_used_total<ob_main.maindeck_size_max {
				card_indeck[0]=true;
				ob_deckbuild.reorder_swap_standby=ob_deckbuild.reorder_selected;
				ob_deckbuild.reorder_selected=0; //pokemon id
				ob_deckbuild.reorder_type=ob_deckbuild.reorder_selected;
			}
			else if card_indeck[0]=true {
				card_indeck[0]=false;
				ob_deckbuild.reorder_swap_standby=ob_deckbuild.reorder_selected;
				ob_deckbuild.reorder_selected=0; //pokemon id
				ob_deckbuild.reorder_type=ob_deckbuild.reorder_selected;
			}
			card_delete_timer=0;
		}
		else if mouse_check_button(mb_right) and ob_deckbuild.deck_build_all_total>ob_main.maindeck_size_min_full and card_indeck[0]=false and ob_main.cursor_hide=false {
			if mouse_check_button_pressed(mb_right) { sc_playsound(sn_card,50,false,false); }
			//
			card_delete_timer++;
			//
			sell_value=card_value*sell_value_multiplier;
			if (card_glyph_a!=-1 and card_glyph_a<glyph_common_amount) or (card_glyph_b!=-1 and card_glyph_b<glyph_common_amount) or
			(card_glyph_c!=-1 and card_glyph_c<glyph_common_amount) {
				sell_value*=sell_glyphed_multiplier;
			}
			if card_enigma=true or card_secret=true { sell_value*=sell_enigma_multiplier; }
			if card_shiny=true { sell_value*=sell_shiny_multiplier; }
			sell_value=round(sell_value); //bankers rounding
			//
			if card_delete_timer=card_delete_timer_max {
				sc_playsound(sn_faint,50,false,false);
				ob_main.money+=sell_value;
				ob_main.stats_money_total+=sell_value;
				ob_main.stats_cards_sold++;
				//
				ob_deckbuild.reorder_swap_standby=ob_deckbuild.reorder_selected;
				ob_deckbuild.reorder_type=5;
				instance_destroy();
			}
		}
		else if mouse_check_button_pressed(mb_right) and card_indeck[0]=true and ob_main.cursor_hide=false {
			sc_playsound(sn_click,50,false,false);
			//
			if card_nickname="" { ob_main.nickname_input=card_name; }
			else { ob_main.nickname_input=card_nickname; }
			ob_main.nickname_screen=true;
			card_rename=true;
		}
		else {
			card_delete_timer=0;
		}
	}
	else if card_cat=1 {
		var berry_common_used=ob_deckbuild.deck_berry_used[0]+ob_deckbuild.deck_berry_used[1]+ob_deckbuild.deck_berry_used[2];
		var berry_enigma_used=ob_deckbuild.deck_berry_used[3];
		//
		if mouse_check_button_pressed(mb_left) and ob_main.cursor_hide=false {
			sc_playsound(sn_click,50,false,false);
			if ((card_id!=3003) or (card_id=3003 and ob_deckbuild.deck_berry_total[3]<=berry_common_used)) {
				ob_deckbuild.deck_berry_used[card_id-3000]=ob_deckbuild.deck_berry_total[card_id-3000];
			}
			else if card_id=3003 and ob_deckbuild.deck_berry_total[3]>berry_common_used {
				ob_deckbuild.deck_berry_used[card_id-3000]=berry_common_used;
			}
		}
		else if mouse_check_button_pressed(mb_right) and ob_main.cursor_hide=false {
			sc_playsound(sn_click,50,false,false);
			ob_deckbuild.deck_berry_used[card_id-3000]=0;
			//
			berry_common_used=ob_deckbuild.deck_berry_used[0]+ob_deckbuild.deck_berry_used[1]+ob_deckbuild.deck_berry_used[2];
			berry_enigma_used=ob_deckbuild.deck_berry_used[3];
			if berry_enigma_used>berry_common_used { ob_deckbuild.deck_berry_used[3]=berry_common_used; }
		}
		else if (mouse_wheel_up() or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))) and ob_main.cursor_hide=false {
			if ob_deckbuild.deck_berry_used[card_id-3000]<ob_deckbuild.deck_berry_total[card_id-3000] and
			((card_id!=3003) or (card_id=3003 and berry_enigma_used+1<=berry_common_used)) {
				sc_playsound(sn_click,50,false,false);
				ob_deckbuild.deck_berry_used[card_id-3000]++;
			}
		}
		else if (mouse_wheel_down() or keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))) and ob_main.cursor_hide=false {
			if ob_deckbuild.deck_berry_used[card_id-3000]>0 {
				sc_playsound(sn_click,50,false,false);
				ob_deckbuild.deck_berry_used[card_id-3000]--;
				//
				berry_common_used=ob_deckbuild.deck_berry_used[0]+ob_deckbuild.deck_berry_used[1]+ob_deckbuild.deck_berry_used[2];
				berry_enigma_used=ob_deckbuild.deck_berry_used[3];
				if berry_enigma_used>berry_common_used { ob_deckbuild.deck_berry_used[3]=berry_common_used; }
			}
		}
	}
}
else {
	card_delete_timer=0;
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if ((reference_id=ob_control and ob_control.card_focus=id) or reference_id=ob_event or reference_id=ob_deckbuild) and card_face=true and card_cat=0 and ob_main.cursor_hide=false {
	if (mouse_x>=x+2 and mouse_y>=y+2 and mouse_x<=x+13 and mouse_y<=y+12) or
	(card_type_b>=0 and mouse_x>=x+2 and mouse_y>=y+12 and mouse_x<=x+13 and mouse_y<=y+22) {
		if card_type_b>=0 and mouse_x>=x+2 and mouse_y>=y+12 and mouse_x<=x+13 and mouse_y<=y+22 { var switch_var=card_type_b; }
		else if mouse_x>=x+2 and mouse_y>=y+2 and mouse_x<=x+13 and mouse_y<=y+12 { var switch_var=card_type_a; }
		switch (switch_var) {
			case 00: reference_id.tooltip_text="Normal"; break;
			case 01: reference_id.tooltip_text="Grass"; break;
			case 02: reference_id.tooltip_text="Fire"; break;
			case 03: reference_id.tooltip_text="Water"; break;
			case 04: reference_id.tooltip_text="Electric"; break;
			case 05: reference_id.tooltip_text="Flying"; break;
			case 06: reference_id.tooltip_text="Fighting"; break;
			case 07: reference_id.tooltip_text="Psychic"; break;
			case 08: reference_id.tooltip_text="Fairy"; break;
			case 09: reference_id.tooltip_text="Ground"; break;
			case 10: reference_id.tooltip_text="Rock"; break;
			case 11: reference_id.tooltip_text="Bug"; break;
			case 12: reference_id.tooltip_text="Poison"; break;
			case 13: reference_id.tooltip_text="Ice"; break;
			case 14: reference_id.tooltip_text="Dragon"; break;
			case 15: reference_id.tooltip_text="Steel"; break;
			case 16: reference_id.tooltip_text="Ghost"; break;
			case 17: reference_id.tooltip_text="Dark"; break;
		}
		reference_id.tooltip_lines=1;
	}
	else if (card_glyph_a>=0 and mouse_x>=x+43 and mouse_y>=y+2 and mouse_x<=x+54 and mouse_y<=y+12) or
	(card_glyph_b>=0 and mouse_x>=x+43 and mouse_y>=y+12 and mouse_x<=x+54 and mouse_y<=y+22) or
	(card_glyph_c>=0 and mouse_x>=x+43 and mouse_y>=y+22 and mouse_x<=x+54 and mouse_y<=y+32) {
		if card_glyph_c>=0 and mouse_x>=x+43 and mouse_y>=y+22 and mouse_x<=x+54 and mouse_y<=y+32 { var switch_var=card_glyph_c; }
		else if card_glyph_b>=0 and mouse_x>=x+43 and mouse_y>=y+12 and mouse_x<=x+54 and mouse_y<=y+22 { var switch_var=card_glyph_b; }
		else if card_glyph_a>=0 and mouse_x>=x+43 and mouse_y>=y+2 and mouse_x<=x+54 and mouse_y<=y+12 { var switch_var=card_glyph_a; }
		reference_id.tooltip_text=sc_glyph_text(switch_var,false);
		reference_id.tooltip_lines=sc_glyph_text(switch_var,true);
	}
	else if card_cost_total>0 and mouse_x>=x+3 and mouse_y>=y+35 and mouse_x<=x+2+(4*card_cost_total) and mouse_y<=y+38 {
		reference_id.tooltip_text="Cost: ";
		if card_cost_total_type[0]>=1 {
			reference_id.tooltip_text=reference_id.tooltip_text + string(card_cost_total_type[0]) + "x Oran";
		}
		if card_cost_total_type[1]>=1 {
			if card_cost_total_type[0]>=1 { reference_id.tooltip_text=reference_id.tooltip_text + ", "; }
			reference_id.tooltip_text=reference_id.tooltip_text + string(card_cost_total_type[1]) + "x Leppa";
		}
		if card_cost_total_type[2]>=1 {
			if card_cost_total_type[0]>=1 or card_cost_total_type[1]>=1 { reference_id.tooltip_text=reference_id.tooltip_text + ", "; }
			reference_id.tooltip_text=reference_id.tooltip_text + string(card_cost_total_type[2]) + "x Lum";
		}
		if card_cost_total_type[3]>=1 {
			if card_cost_total_type[0]>=1 or card_cost_total_type[1]>=1 or card_cost_total_type[2]>=1 { reference_id.tooltip_text=reference_id.tooltip_text + ", "; }
			reference_id.tooltip_text=reference_id.tooltip_text + string(card_cost_total_type[3]) + "x Enigma";
		}
		reference_id.tooltip_text=reference_id.tooltip_text + ".";
		reference_id.tooltip_lines=1;
	}
}
else if reference_id=ob_deckbuild and card_cat=1 and ob_main.cursor_hide=false {
	if mouse_x>=x and mouse_y>=y and mouse_x<x+sprite_width and mouse_y<y+sprite_height {
		if card_id=3003 { //enigma berries
			reference_id.tooltip_text="Can be used as any Berry.\nTotal amount cannot exceed half of Berry Deck.";
			reference_id.tooltip_lines=2;
		}
	}
}
