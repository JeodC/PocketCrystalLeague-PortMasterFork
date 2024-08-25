function AI_play(argument0,argument1,argument2,argument3,argument4,argument5) {
/// @param card_id
/// @param oran_berries
/// @param leppa_berries
/// @param lum_berries
/// @param enigma_berries
/// @param discard_id
//————————————————————————————————————————————————————————————————————————————————————————————————————
sc_playsound(sn_card,50,false,false);
var playcard_id=-1;
//
if argument5!=-1 {
	playcard_id=argument5;
	playcard_id.card_trash=true;
	playcard_id.card_played=true;
	sc_card_effect(card_space_id[10].x,card_space_id[10].y,1,false,false);
	//
	enemycard_discardplan_id=-1;
}
else if argument1>0 or argument2>0 or argument3>0 or argument4>0 {
	var i=0;
	do {
		for (var ii=3; ii>=0; ii--;) {
			if enemyberry_playplan[ii]>0 and enemycard_hand[i].card_id=3000+ii {
				playcard_id=enemycard_hand[i];
			}
		}
		i++;
	} until (playcard_id!=-1);
	//
	card_space_id[enemyspace_playplan_slot].berries_total++;
	card_space_id[enemyspace_playplan_slot].berries_total_type[playcard_id.card_id-3000]++;
	enemyberry_playplan[playcard_id.card_id-3000]--;
	playcard_id.card_trash=true;
	playcard_id.card_played=true;
	sc_card_effect(card_space_id[enemyspace_playplan_slot].x,card_space_id[enemyspace_playplan_slot].y,0,true,false);
	//
	if argument0=-1 { enemyspace_playplan_slot=-1; } //when just playing a berry
}
else if argument0!=-1 {
	playcard_id=argument0;
	//
	var var_consumed_berry;
	for (var i=0; i<=3; i++;) {
		var_consumed_berry[i]=sc_card_cost_check(card_space_id[enemyspace_playplan_slot].berries_total_type[0],card_space_id[enemyspace_playplan_slot].berries_total_type[1],
		card_space_id[enemyspace_playplan_slot].berries_total_type[2],card_space_id[enemyspace_playplan_slot].berries_total_type[3],
		playcard_id.card_cost_total_type[0],playcard_id.card_cost_total_type[1],playcard_id.card_cost_total_type[2],playcard_id.card_cost_total_type[3],i);
	}
	//
	if sc_glyph_check(playcard_id,ref_glyph_lucky,true) { //glyph: lucky
		enemycard_draw_points+=2;
	}
	if sc_glyph_check(playcard_id,ref_glyph_mindful,true) { //glyph: mindful
		enemycard_draw_points+=1;
	}
	//
	if sc_glyph_check(playcard_id,ref_glyph_medic,true) { //glyph: medic
		for (var i=0; i<=4; i++;) {
			if card_space_id[i].occupy_id!=-1 {
				var card_to_heal=card_space_id[i].occupy_id;
				card_to_heal.card_hp=card_to_heal.card_full_hp;
				var heal_num_id=instance_create_layer(card_to_heal.x+29,card_to_heal.y+18+15,"instances",ob_damage_num);
				heal_num_id.damage_num=card_to_heal.card_full_hp;
				heal_num_id.text_alpha=heal_num_id.text_alpha_full;
				heal_num_id.text_color=global.color_fullhp;
			}
		}
	}
	//
	if sc_glyph_check(playcard_id,ref_glyph_bulwark,true) { //glyph: bulwark
		var i=0;
		repeat (2) {
			var rock_cardspace_id=-1;
			if enemyspace_playplan_slot>0 and card_space_id[enemyspace_playplan_slot-1].occupy_id=-1 and i=0 { rock_cardspace_id=card_space_id[enemyspace_playplan_slot-1]; }
			else if enemyspace_playplan_slot<4 and card_space_id[enemyspace_playplan_slot+1].occupy_id=-1 and i=1 { rock_cardspace_id=card_space_id[enemyspace_playplan_slot+1]; }
			//
			if rock_cardspace_id!=-1 {
				create_card_cat=0;
				create_card_id=2503; //rock
				create_card_nickname="";
				create_card_level=playcard_id.card_level;
				create_card_glyph_a=ref_glyph_recovery;
				create_card_glyph_b=-1;
				create_card_glyph_c=-1;
				create_card_innate=1;
				create_card_form_value=0;
				create_card_shiny=false;
				create_enemy_randomizer=false;
				create_enemy_costcount=false;
				//
				var rock_spawn_id=instance_create_layer(card_space_id[enemyspace_playplan_slot].x,card_space_id[enemyspace_playplan_slot].y,"instances",ob_card);
				rock_spawn_id.potential_x=rock_cardspace_id.x;
				rock_spawn_id.potential_y=rock_cardspace_id.y;
				rock_spawn_id.card_face=true;
				rock_spawn_id.card_played=true;
				rock_spawn_id.card_enemy=true;
				rock_cardspace_id.occupy_id=rock_spawn_id;
				sc_card_effect(rock_cardspace_id.x,rock_cardspace_id.y,0,true,false);
			}
			//
			i++;
		}
	}
	//
	playcard_id.potential_x=card_space_id[enemyspace_playplan_slot].x;
	playcard_id.potential_y=card_space_id[enemyspace_playplan_slot].y;
	for (var i=0; i<=3; i++;) {
		card_space_id[enemyspace_playplan_slot].berries_total_type[i]-=var_consumed_berry[i];
		playcard_id.consumed_berry[i]=var_consumed_berry[i];
	}
	card_space_id[enemyspace_playplan_slot].berries_total-=var_consumed_berry[0]+var_consumed_berry[1]+var_consumed_berry[2]+var_consumed_berry[3];
	playcard_id.card_face=true;
	playcard_id.card_played=true;
	card_space_id[enemyspace_playplan_slot].occupy_id=playcard_id;
	sc_card_effect(card_space_id[enemyspace_playplan_slot].x,card_space_id[enemyspace_playplan_slot].y,0,true,false);
	//
	enemycard_playplan_id=-1;
	enemyspace_playplan_slot=-1;
}
//
var i=0, lower_hand_num=false;
repeat (enemycard_hand_total) {
	if playcard_id=enemycard_hand[i] {
		lower_hand_num=true;
	}
	if lower_hand_num=true {
		enemycard_hand[i]=enemycard_hand[i+1];
	}
	i++;
}
enemycard_hand_total--;
//
enemy_turn_timer=irandom_range(15,30);
//————————————————————————————————————————————————————————————————————————————————————————————————————
}