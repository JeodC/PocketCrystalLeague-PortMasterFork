if trash=true {
	draw_sprite_general(sp_sheet,0,16*37+4,16*0,sprite_width,sprite_height,x,y,1,1,0,c_white,c_white,c_white,c_white,0.5);
}
else if trash=false {
	if instance_exists(ob_event) {
		if mouse_x>=x+4 and mouse_y>=y+4 and mouse_x<x+sprite_width-4 and mouse_y<y+sprite_height-4 { var var_event_alpha=1; }
		else { var var_event_alpha=0.5; }
		//
		if ob_event.event_kind!=ref_event_tribute or ob_event.event_space_id[1]!=id {
			draw_sprite_general(sp_sheet,0,16*(1+ob_event.event_kind*2),16*15,26,26,x+16,y+26,1,1,0,c_white,c_white,c_white,c_white,var_event_alpha);
		}
		//
		if ob_event.event_kind=ref_event_levelup {
			draw_set_font(fn_matchup);
			draw_set_halign(fa_center);
			if occupy_id!=-1 and occupy_id.card_level<ob_main.card_level_player_limit and occupy_id.card_innate>0 and ob_main.event_cost_standby_levelup>0 {
				if ob_main.money-ob_main.event_cost_standby>=ob_main.event_cost_standby_levelup { var money_color=global.color_card_light; }
				else { var money_color=global.color_damage; }
				sc_drawtext(x+28,y-34,"Cost: $" + string(ob_main.event_cost_standby_levelup) + " / $" + string(ob_main.money-ob_main.event_cost_standby),
				money_color,global.color_black,1,1,0,-1);
				//
				with (occupy_id) {
					ob_event.levelup_new_hp=sc_card_level_stats_main(0,card_level+1);
					ob_event.levelup_new_atk=sc_card_level_stats_main(1,card_level+1);
					ob_event.levelup_new_def=sc_card_level_stats_main(2,card_level+1);
				}
				var hp_diff=ob_event.levelup_new_hp-occupy_id.card_full_hp;
				var atk_diff=ob_event.levelup_new_atk-occupy_id.card_full_atk;
				var def_diff=ob_event.levelup_new_def-occupy_id.card_full_def;
				//
				var levelup_info_text="+" + string(hp_diff) + " HP / +" + string(atk_diff) + " ATK / +" + string(def_diff) + " DEF";
				if occupy_id.card_level mod advantage_level_interval = 0 and occupy_id.card_environment=false {
					levelup_info_text=levelup_info_text + " / +1 TYPE BONUS"; }
				sc_drawtext(x+28,y-20,levelup_info_text,global.color_card_mid,global.color_black,1,1,0,-1);
			}
		}
		//
		if ob_event.event_kind=ref_event_glyph {
			draw_sprite_general(sp_sheet,0,16*(ob_event.glyph_add_id+1),16*6,12,11,x+41,y+4,1,1,0,c_white,c_white,c_white,c_white,var_event_alpha);
			//
			draw_set_font(fn_matchup);
			draw_set_halign(fa_center);
			if occupy_id!=-1 and occupy_id.card_innate>0 and ob_event.event_applied=false {
				if occupy_id.card_environment=false and
				(occupy_id.card_glyph_a!=ref_glyph_guru and occupy_id.card_glyph_b!=ref_glyph_guru and occupy_id.card_glyph_c!=ref_glyph_guru) and
				((occupy_id.card_glyph_a=-1) or (occupy_id.card_glyph_a>=glyph_common_amount and occupy_id.card_glyph_b=-1) or
				(occupy_id.card_glyph_a>=glyph_common_amount and occupy_id.card_glyph_b>=glyph_common_amount and occupy_id.card_glyph_c=-1)) {
					//berry costs from sc_card_level_stats_all
					var imaginary_card_cost;
					for (var i=0; i<=2; i++;) {
						imaginary_card_cost[i]=sc_card_cost_map(occupy_id.card_cost_total+1,occupy_id.card_enigma,occupy_id.card_type_a,occupy_id.card_type_b,i);
					}
					var new_card_cost=imaginary_card_cost[occupy_id.card_cost_total], var_card_id=occupy_id.card_id;
					//normal (I), water, (flying), fighting, ice, dragon, steel
					//+igglybuff +porygon2 +blissey +azurill +swablu +happiny +munchlax +lickilicky +porygon-z, -steelix
					if ((new_card_cost=00 and
					(var_card_id<=151 or var_card_id=174 or var_card_id=233 or var_card_id=242 or var_card_id=298 or var_card_id=333 or
					var_card_id=440 or var_card_id=446 or var_card_id=463 or var_card_id=474)) or
					new_card_cost=03 or new_card_cost=05 or new_card_cost=06 or new_card_cost=13 or new_card_cost=14 or new_card_cost=15) and (var_card_id!=208) {
						var new_cost_text="Oran Berry.";
					}
					//normal (II), fire, psychic, fairy, ground, rock, ghost, dark
					//+ambipom +steelix
					else if (new_card_cost=00 and (var_card_id<=251 or var_card_id=424)) or (new_card_cost>=00 and (var_card_id=208)) or
					new_card_cost=02 or new_card_cost=07 or new_card_cost=08 or new_card_cost=09 or new_card_cost=10 or new_card_cost=16 or new_card_cost=17 {
						var new_cost_text="Leppa Berry.";
					}
					//normal (III/IV), grass, electric, bug, poison
					else if (new_card_cost=00 and var_card_id<=493) or new_card_cost=01 or new_card_cost=04 or new_card_cost=11 or new_card_cost=12 {
						var new_cost_text="Lum Berry.";
					}
					//enigma
					else if new_card_cost=20 {
						var new_cost_text="Enigma Berry.";
					}
					//
					sc_drawtext(x+28,y-24,"Card cost: +1 " + new_cost_text,global.color_card_light,global.color_black,1,1,0,-1);
				}
				else if occupy_id.card_glyph_c=-1 {
					sc_drawtext(x+28,y-24,"No extra card cost.",global.color_card_light,global.color_black,1,1,0,-1);
				}
			}
		}
	}
	//
	draw_sprite_general(sp_sheet,0,16*33+4,16*0,sprite_width,sprite_height,x,y,1,1,0,
	global.color_background_tile,global.color_background_tile,global.color_background_tile,global.color_background_tile,1);
	draw_sprite_general(sp_sheet,0,16*33+4,16*0,sprite_width,sprite_height,x,y,1,1,0,c_white,c_white,c_white,c_white,0.4); //to lighten color
	//
	var i=0, var_berries_total;
	var_berries_total[0]=berries_total_type[0];
	var_berries_total[1]=berries_total_type[1];
	var_berries_total[2]=berries_total_type[2];
	var_berries_total[3]=berries_total_type[3];
	repeat (berries_total) {
		var ii=0, berry_drawn=false;
		do {
			if var_berries_total[ii]>0 {
				draw_sprite_general(sp_sheet,0,16*(ii+1),16*4,5,5,x+5+6*i,y+70,1,1,0,c_white,c_white,c_white,c_white,1);
				var_berries_total[ii]--;
				berry_drawn=true;
			}
			ii++;
		} until (berry_drawn=true);
		i++;
	}
}