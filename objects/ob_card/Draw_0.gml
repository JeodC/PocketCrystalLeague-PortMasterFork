draw_set_alpha(1);
//
if instance_exists(ob_control) { var reference_id=ob_control; }
else if instance_exists(ob_deckbuild) { var reference_id=ob_deckbuild; }
else if instance_exists(ob_event) { var reference_id=ob_event; }
//————————————————————————————————————————————————————————————————————————————————————————————————————
if effect_damaged>0 { var draw_x=x+irandom_range(-2,2), draw_y=y+irandom_range(-2,2); }
else { var draw_x=x, draw_y=y; }
//
var rel_hud=ceil(ob_main.moving_hud);
//
var in_view=false;
if reference_id=ob_control or
(reference_id=ob_event and x>=screen_main_x-60 and x<=screen_main_x+cam_w+60) or
(reference_id=ob_deckbuild and x>=screen_deck_x-60 and x<=screen_deck_x+cam_w+60) {
	in_view=true;
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if card_cat=0 and card_face=true and in_view=true {
	var card_color=c_white, namebar_color=c_white;
	//
	if card_type_a=00 { namebar_color=make_colour_rgb(169,182,214); }
	else if card_type_a=01 { namebar_color=make_colour_rgb(174,214,170); }
	else if card_type_a=02 { namebar_color=make_colour_rgb(219,181,174); }
	else if card_type_a=03 { namebar_color=make_colour_rgb(170,191,214); }
	else if card_type_a=04 { namebar_color=make_colour_rgb(214,207,170); }
	else if card_type_a=05 { namebar_color=make_colour_rgb(170,177,214); }
	else if card_type_a=06 { namebar_color=make_colour_rgb(214,170,183); }
	else if card_type_a=07 { namebar_color=make_colour_rgb(214,170,171); }
	else if card_type_a=08 { namebar_color=make_colour_rgb(214,170,210); }
	else if card_type_a=09 { namebar_color=make_colour_rgb(214,186,170); }
	else if card_type_a=10 { namebar_color=make_colour_rgb(214,202,170); }
	else if card_type_a=11 { namebar_color=make_colour_rgb(200,214,170); }
	else if card_type_a=12 { namebar_color=make_colour_rgb(199,170,213); }
	else if card_type_a=13 { namebar_color=make_colour_rgb(172,214,208); }
	else if card_type_a=14 { namebar_color=make_colour_rgb(173,196,214); }
	else if card_type_a=15 { namebar_color=make_colour_rgb(175,205,214); }
	else if card_type_a=16 { namebar_color=make_colour_rgb(176,186,214); }
	else if card_type_a=17 { namebar_color=make_colour_rgb(191,177,214); }
	//
	if card_innate=0 { card_color=global.color_card_light; }
	else if card_innate=innate_max { card_color=namebar_color; }
	else if card_delete_timer>0 { card_color=global.color_gray; }
	//
	//CARD BASE
	if card_enigma=false and card_secret=false {
		draw_sprite_general(sp_sheet,0,16*5+4,16*0,sprite_width,sprite_height,draw_x,draw_y,1,1,0,card_color,card_color,card_color,card_color,1);
	}
	else { draw_sprite_general(sp_sheet,0,16*13+4,16*0,sprite_width,sprite_height,draw_x,draw_y,1,1,0,card_color,card_color,card_color,card_color,1); }
	//
	//INNATE LEVEL
	if card_innate>1 {
		var i=0;
		repeat (card_innate-1) {
			draw_sprite_general(sp_sheet,0,16*1,16*1,3,3,draw_x+27-((card_innate-2)*2)+(i*4),draw_y+3,1,1,0,card_color,card_color,card_color,card_color,1);
			i++;
		}
	}
	else if card_innate=0 {
		draw_sprite_general(sp_sheet,0,16*2,16*1,3,3,draw_x+27,draw_y+3,1,1,0,card_color,card_color,card_color,card_color,1);
	}
	//
	//NAMEBAR
	draw_sprite_general(sp_sheet,0,16*1,16*2,53,10,draw_x+2,draw_y+41,1,1,0,namebar_color,global.color_white,global.color_white,namebar_color,1);
	//
	//SHINY
	if card_shiny=true { draw_sprite_general(sp_sheet,0,16*3,16*1,7,6,draw_x+25,draw_y+33,1,1,0,c_white,c_white,c_white,c_white,1); }
	//
	//SPRITE
	var secret_sprite_x=0, secret_sprite_y=0;
	if card_nickname!="" {
		if string_lower(card_nickname)="moody" and card_id=447 { secret_sprite_x=1; secret_sprite_y=13; } //riolu
		else if string_lower(card_nickname)="moody" and card_id=448 { secret_sprite_x=2; secret_sprite_y=13; } //lucario
		else if card_nickname="176861" and card_id=035 { secret_sprite_x=3; secret_sprite_y=13;  } //clefairy
		else if card_nickname="977194" and card_id=158 { secret_sprite_x=4; secret_sprite_y=13;  } //totodile
		else if string_lower(card_nickname)="sapporo" and card_id=250 { secret_sprite_x=5; secret_sprite_y=13;  } //ho-oh
		else if string_lower(card_nickname)="daffy" and card_id=197 { secret_sprite_x=1; secret_sprite_y=12; } //umbreon
		else if (string_lower(card_nickname)="side b" or string_lower(card_nickname)="sideb") and card_id=403 { secret_sprite_x=2; secret_sprite_y=12; } //shinx
		else if string_lower(card_nickname)="yuki" and card_id=151 { secret_sprite_x=3; secret_sprite_y=12; } //mew
		else if string_lower(card_nickname)="sunset" and card_id=448 { secret_sprite_x=4; secret_sprite_y=12; } //lucario
		else if string_lower(card_nickname)="harley" and card_id=133 { secret_sprite_x=5; secret_sprite_y=12; } //eevee
		else if string_lower(card_nickname)="north" and card_id=445 { secret_sprite_x=6; secret_sprite_y=12; } //garchomp
		else if string_lower(card_nickname)="cupid" and card_id=135 { secret_sprite_x=7; secret_sprite_y=12; } //jolteon
		else if (string_lower(card_nickname)="night" or string_lower(card_nickname)="nightcore") and card_id=059 { secret_sprite_x=8; secret_sprite_y=12; } //arcanine
		else if string_lower(card_nickname)="ace" and card_id=448 { secret_sprite_x=9; secret_sprite_y=12; } //lucario
		else if (string_lower(card_nickname)="mr wolf" or string_lower(card_nickname)="mrwolf") and card_id=448 { secret_sprite_x=10; secret_sprite_y=12; } //lucario
		else if string_lower(card_nickname)="jessico" and card_id=162 { secret_sprite_x=11; secret_sprite_y=12; } //furret
		else if (string_lower(card_nickname)="kotaro" or string_lower(card_nickname)="kota") and card_id=150 { secret_sprite_x=12; secret_sprite_y=12; } //mewtwo
		else if (string_lower(card_nickname)="koby" or string_lower(card_nickname)="kobault" or string_lower(card_nickname)="kris") and card_id=417 { secret_sprite_x=13; secret_sprite_y=12; } //pachirisu
		else if string_lower(card_nickname)="seagull" and card_id=282 { secret_sprite_x=1; secret_sprite_y=11; } //gardevoir
		else if string_lower(card_nickname)="knight" and card_id=134 { secret_sprite_x=2; secret_sprite_y=11; } //vaporeon
		else if string_lower(card_nickname)="milachu" and card_id=025 { secret_sprite_x=3; secret_sprite_y=11; } //pikachu
		else if string_lower(card_nickname)="solar" and card_id=157 { secret_sprite_x=4; secret_sprite_y=11; } //typhlosion
	}
	//
	if secret_sprite_x=0 { draw_sprite_general(card_sheet,0,65*(card_grid_x-1)+1,33*(card_grid_y-1)+1,64,32,draw_x-4,draw_y+3,1,1,0,c_white,c_white,c_white,c_white,1); }
	else if secret_sprite_x>0 { draw_sprite_general(sp_poke_c,0,65*(secret_sprite_x-1)+1,33*(secret_sprite_y-1)+1,64,32,draw_x-4,draw_y+3,1,1,0,c_white,c_white,c_white,c_white,1); }
	//
	//TYPES
	draw_sprite_general(sp_sheet,0,16*(card_type_a+1),16*5,12,11,draw_x+2,draw_y+2,1,1,0,c_white,c_white,c_white,c_white,1);
	if card_type_b>=0 { draw_sprite_general(sp_sheet,0,16*(card_type_b+1),16*5,12,11,draw_x+2,draw_y+12,1,1,0,c_white,c_white,c_white,c_white,1); }
	//
	//GLYPHS
	if card_glyph_a>=0 and card_glyph_a<glyph_common_amount {
		draw_sprite_general(sp_sheet,0,16*(card_glyph_a+1),16*6,12,11,draw_x+43,draw_y+2,1,1,0,c_white,c_white,c_white,c_white,1);
	}
	else if card_glyph_a>=glyph_common_amount {
		draw_sprite_general(sp_sheet,0,16*(card_glyph_a-100+11),16*18,12,11,draw_x+43,draw_y+2,1,1,0,c_white,c_white,c_white,c_white,1);
	}
	if card_glyph_b>=0 and card_glyph_b<glyph_common_amount {
		draw_sprite_general(sp_sheet,0,16*(card_glyph_b+1),16*6,12,11,draw_x+43,draw_y+12,1,1,0,c_white,c_white,c_white,c_white,1);
	}
	else if card_glyph_b>=glyph_common_amount {
		draw_sprite_general(sp_sheet,0,16*(card_glyph_b-100+11),16*18,12,11,draw_x+43,draw_y+12,1,1,0,c_white,c_white,c_white,c_white,1);
	}
	if card_glyph_c>=0 and card_glyph_c<glyph_common_amount {
		draw_sprite_general(sp_sheet,0,16*(card_glyph_c+1),16*6,12,11,draw_x+43,draw_y+22,1,1,0,c_white,c_white,c_white,c_white,1);
	}
	else if card_glyph_c>=glyph_common_amount {
		draw_sprite_general(sp_sheet,0,16*(card_glyph_c-100+11),16*18,12,11,draw_x+43,draw_y+22,1,1,0,c_white,c_white,c_white,c_white,1);
	}
	//
	//COST
	var i=0;
	repeat (3) {
		if card_cost[i]>=0 { draw_sprite_general(sp_sheet,0,16*(card_cost[i]+1),16*3,4,4,draw_x+3+4*i,draw_y+35,1,1,0,c_white,c_white,c_white,c_white,1); }
		i++;
	}
	//
	//ATTACK
	if reference_id=ob_control {
		if already_attacked=false and card_environment=false and card_played=true and card_trash=false and card_enemy=false and ob_control.battler_turn=1 and ob_control.turn_num>2 {
			var opposite_card=-1;
			for (var i=5; i<=9; i++;) {
				if ob_control.card_space_id[i].occupy_id=id and ob_control.card_space_id[i-5].occupy_id!=-1 {
					opposite_card=ob_control.card_space_id[i-5].occupy_id;
				}
			}
			if opposite_card!=-1 and sc_type_bonus(card_type_a,card_type_b,opposite_card.card_type_a,opposite_card.card_type_b) {
				draw_sprite_general(sp_sheet,0,16*2,16*15,16,16,draw_x+20,draw_y-8,1,1,0,c_white,c_white,c_white,c_white,1);
			}
			else {
				draw_sprite_general(sp_sheet,0,16*1,16*15,16,16,draw_x+20,draw_y-8,1,1,0,c_white,c_white,c_white,c_white,1);
			}
		}
	}
	//
	//STATS
	if card_environment=false { var var_level_rank=ceil(card_level/advantage_level_interval); } else { var var_level_rank=0; }
	draw_sprite_general(sp_sheet,0,16*17,16*var_level_rank,49,2,draw_x+4,draw_y+56,1,1,0,card_color,card_color,card_color,card_color,1);
	//
	draw_set_font(fn_m3x6);
	draw_set_halign(fa_center);
	var card_name_show=card_nickname, card_name_color=global.color_character_light;
	if card_name_show="" {
		card_name_show=card_name;
		card_name_color=global.color_white;
	}
	sc_drawtext(draw_x+29,draw_y+39,card_name_show,card_name_color,global.color_black,1,(1/1.5),0,-1);
	sc_drawtext(draw_x+29,draw_y+50,"lv " + string(card_level),global.color_gray,global.color_black,1,(1/1.7),0,-1);
	//sc_drawtext(draw_x+29,draw_y+4,"#" + string(card_id) + "\nv " + string(card_value) + "\nfv " + string(card_form_value) + "\ns " + string(card_serial),c_aqua,c_black,1,1,0,-1);
	//
	draw_set_halign(fa_left);
	if card_id<=normal_poke_id_max and ob_main.option_state[opt_dexnumber]=true { sc_drawtext(draw_x+8,draw_y+24,string(card_id),global.color_white,global.color_black,(1/4),0,0,-1); }
	//
	var num_color=c_white;
	draw_set_halign(fa_left);
	if card_atk<card_full_atk { num_color=global.color_damage; }
	else if card_atk>card_full_atk { num_color=global.color_friendly; }
	else { num_color=global.color_white; }
	sc_drawtext(draw_x+5,draw_y+66,string(card_atk),num_color,global.color_black,1,(1/1.7),0,-1);
	draw_set_halign(fa_center);
	if card_hp<card_full_hp { num_color=global.color_damage; }
	else { num_color=global.color_fullhp; }
	sc_drawtext(draw_x+29,draw_y+60,string(card_hp),num_color,global.color_black,1,(1/1.7),0,-1);
	draw_set_halign(fa_right);
	if card_def<card_full_def { num_color=global.color_damage; }
	else if card_def>card_full_def { num_color=global.color_friendly; }
	else { num_color=global.color_white; }
	sc_drawtext(draw_x+53,draw_y+66,string(card_def),num_color,global.color_black,1,(1/1.7),0,-1);
	//
	//DELETE
	if card_delete_timer>0 {
		draw_sprite_general(sp_sheet,0,16*37+4,16*0,57,80,draw_x,draw_y,1,1,0,c_white,c_white,c_white,c_white,1);
		draw_healthbar(draw_x+8,draw_y+55,draw_x+48,draw_y+58,card_delete_timer*100/card_delete_timer_max,global.color_black,global.color_damage,global.color_damage,0,true,false);
		//
		draw_set_font(fn_matchup);
		draw_set_halign(fa_center);
		sc_drawtext(draw_x+29,draw_y+28,"$" + string(sell_value),global.color_card_light,global.color_black,1,1,0,-1);
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
else if card_cat=1 and card_face=true and in_view=true {
	var card_color=c_white;
	if reference_id=ob_deckbuild and mouse_x>=x and mouse_y>=y and mouse_x<x+sprite_width and mouse_y<y+sprite_height { card_color=global.color_gray; }
	//
	draw_sprite_general(sp_sheet,0,16*9+4,16*0,sprite_width,sprite_height,draw_x,draw_y,1,1,0,card_color,card_color,card_color,card_color,1);
	draw_sprite_general(sp_sheet,0,16*1,16*2,53,10,draw_x+2,draw_y+41,1,1,0,
	global.color_card_mid,global.color_card_light,global.color_card_light,global.color_card_mid,1);
	draw_sprite_general(sp_berries,0,32*(card_id-3000)+1,1,32,32,draw_x+12,draw_y+4,1,1,0,card_color,card_color,card_color,card_color,1);
	//
	draw_set_font(fn_m3x6);
	draw_set_halign(fa_center);
	sc_drawtext(draw_x+29,draw_y+39,card_name,global.color_white,global.color_black,1,(1/1.5),0,-1);
	//
	draw_sprite_general(sp_sheet,0,16*(card_id-3000+1),16*3,4,4,draw_x+26,draw_y+63,1,1,0,card_color,card_color,card_color,card_color,1);
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	draw_set_font(fn_m6x11);
	draw_set_halign(fa_right);
	//
	if reference_id=ob_deckbuild and ob_deckbuild.deck_berry_total[card_id-3000]>0 {
		if ob_deckbuild.deck_berry_used[card_id-3000]=ob_deckbuild.deck_berry_total[card_id-3000] { var num_color=global.color_fullhp; }
		else if ob_deckbuild.deck_berry_used[card_id-3000]=0 { var num_color=global.color_damage; }
		else { var num_color=global.color_white; }
		//
		if ob_deckbuild.deck_berry_used[card_id-3000]<ob_deckbuild.deck_berry_total[card_id-3000] {
			draw_sprite_general(sp_sheet,0,16*9,16*9,16,16,draw_x+42,draw_y+53-rel_hud,1,1,0,c_white,c_white,c_white,c_white,0.8);
		}
		if ob_deckbuild.deck_berry_used[card_id-3000]>0 {
			draw_sprite_general(sp_sheet,0,16*10,16*9,16,16,draw_x+42,draw_y+72+rel_hud,1,1,0,c_white,c_white,c_white,c_white,0.8);
		}
		sc_drawtext(draw_x+54,draw_y+64,string(ob_deckbuild.deck_berry_used[card_id-3000]),num_color,global.color_black,1,0.8,0,-1);
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
else if card_face=false {
	if card_trash=false { var overlay_color=c_white; } else { var overlay_color=global.color_gray; }
	if card_cat=0 or card_enemy=true {
		draw_sprite_general(sp_sheet,0,16*25+4,16*0,sprite_width,sprite_height,draw_x,draw_y,1,1,0,overlay_color,overlay_color,overlay_color,overlay_color,1);
	}
	else if card_cat=1 {
		draw_sprite_general(sp_sheet,0,16*29+4,16*0,sprite_width,sprite_height,draw_x,draw_y,1,1,0,overlay_color,overlay_color,overlay_color,overlay_color,1);
	}
}