if !instance_exists(ob_control) and !instance_exists(ob_event) and !instance_exists(ob_splash) {
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	// MAIN
	var area_sp_x=location_type[roadmap_area], area_sp_y=0;
	if area_sp_x>=6 and area_sp_x<=11 { area_sp_x-=6; area_sp_y=1; }
	else if area_sp_x>=12 and area_sp_x<=16 { area_sp_x-=12; area_sp_y=2; }
	else if area_sp_x>=17 { area_sp_x-=17; area_sp_y=3; }
	//
	var rel_hud=ceil(moving_hud);
	//
	sc_drawrectangle(road_win_x-2,road_win_y-2,road_win_x+240,road_win_y+112,c_white,global.color_white,2,0,1,0);
	draw_sprite_general(sp_area,0,240*area_sp_x,112*area_sp_y,240,112,road_win_x,road_win_y,1,1,0,c_white,c_white,c_white,c_white,1);
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	if area_zone=area_zone_max-1 and roadmap_area>roadmap_current_max-roadmap_league_max {
		draw_set_font(fn_m3x6);
		draw_set_halign(fa_right);
		sc_drawtext(screen_main_x+cam_w-3,screen_main_y+cam_h-14,"(saving disabled)",global.color_card_light,global.color_black,0.25,0.25,0,-1);
	}
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	draw_set_font(fn_matchup);
	draw_set_halign(fa_center);
	//
	if event_kind[2][roadmap_area]=-1 { var var_event_num=2; }
	else { var var_event_num=3; }
	//
	var i=0;
	repeat (var_event_num) {
		var event_sprite_x=16*(1+event_kind[i][roadmap_area]*2);
		if event_kind[i][roadmap_area]=ref_event_gymbattle or event_kind[i][roadmap_area]=ref_event_elitebattle or event_kind[i][roadmap_area]=ref_event_championbattle {
			event_sprite_x=16*(1+13*2); }
		else if event_kind[i][roadmap_area]=ref_event_tutorial { event_sprite_x=16*(1+0*2); }
		else if event_kind[i][roadmap_area]=ref_event_grass { event_sprite_x=16*(1+10*2); }
		else if event_kind[i][roadmap_area]=ref_event_fire { event_sprite_x=16*(1+11*2); }
		else if event_kind[i][roadmap_area]=ref_event_water { event_sprite_x=16*(1+12*2); }
		//
		sc_drawrectangle(event_button_x[i],event_button_y[i],event_button_x[i]+42,event_button_y[i]+42,global.color_black,global.color_white,2,0.8,0.5,0);
		draw_sprite_general(sp_sheet,0,event_sprite_x,16*13,26,27,event_button_x[i]+9,event_button_y[i]+9-rel_hud,1,1,0,c_white,c_white,c_white,c_white,1);
		sc_drawtext(event_button_x[i]+22,event_button_y[i]+51,event_name[i][roadmap_area],global.color_white,global.color_black,1,1,0,-1);
		//
		if event_kind[i][roadmap_area]=ref_event_battle or event_kind[i][roadmap_area]=ref_event_gymbattle or event_kind[i][roadmap_area]=ref_event_elitebattle or
		event_kind[i][roadmap_area]=ref_event_championbattle or event_kind[i][roadmap_area]=ref_event_tutorial {
			if trainer_sprite[roadmap_area]<=playericon_max {
				draw_sprite_general(sp_sheet,0,16*((trainer_sprite[roadmap_area] mod 2)+1),16*(11+trainer_skin[roadmap_area]),16,16,
				event_button_x[i]+25,event_button_y[i]+27,1,1,0,c_white,c_white,c_white,c_white,1);
				draw_sprite_general(sp_sheet,0,16*(trainer_sprite[roadmap_area]+3),16*11,16,16,event_button_x[i]+25,event_button_y[i]+27,1,1,0,
				trainer_hair_color[roadmap_area],trainer_hair_color[roadmap_area],trainer_hair_color[roadmap_area],trainer_hair_color[roadmap_area],1);
				draw_sprite_general(sp_sheet,0,16*(trainer_sprite[roadmap_area]+3),16*12,16,16,event_button_x[i]+25,event_button_y[i]+27,1,1,0,
				c_white,c_white,c_white,c_white,1);
			}
			else {
				draw_sprite_general(sp_sheet,0,16*(trainer_sprite[roadmap_area]+3),16*11,16,16,event_button_x[i]+25,event_button_y[i]+27,1,1,0,
				c_white,c_white,c_white,c_white,1);
			}
		}
		if event_kind[i][roadmap_area]=ref_event_glyph {
			draw_sprite_general(sp_sheet,0,16*(event_glyph_add[i][roadmap_area]+1),16*6,12,11,event_button_x[i]+29,event_button_y[i]+3,1,1,0,c_white,c_white,c_white,c_white,0.8);
		}
		//
		i++;
	}
	//
	draw_set_halign(fa_right);
	var money_x=road_win_x+237, money_y=road_win_y+2+rel_hud, money_color=global.color_card_light;
	if effect_money_error>0 { money_x+=irandom_range(-2,2); money_y+=irandom_range(-2,2); money_color=global.color_damage; }
	sc_drawtext(money_x,money_y,"$" + string(money_show),money_color,global.color_black,1,1,0,-1);
	//
	draw_set_halign(fa_center);
	var zone_name_text="";
	if roadmap_area=roadmap_current_max-1 or area_zone=area_zone_max-1 or (area_zone=0 and roadmap_area<roadmap_lab_max and zone_first_lap=true) { zone_name_text=zone_name; }
	else if zone_first_lap=true { zone_name_text="Road to: " + zone_name; }
	else if zone_first_lap=false { zone_name_text="Outskirts: " + zone_name; }
	sc_drawtext(road_win_x+120,road_win_y+120,zone_name_text,global.color_card_light,global.color_black,0.6,0.5,0,-1);
	//
	if (area_zone<area_zone_max-1 and roadmap_area=roadmap_current_max-1) or (area_zone=area_zone_max-1 and roadmap_area>=roadmap_current_max-roadmap_league_max) {
		if area_zone>0 { var fly_alpha=0.5, fly_color=make_color_hsv(fly_hue,100,255); } else { var fly_alpha=0.1, fly_color=c_white; }
		draw_sprite_general(sp_sheet,0,16*29,16*7,16,16,fly_prev_x,fly_prev_y,1,1,0,fly_color,fly_color,fly_color,fly_color,fly_alpha);
		if area_zone<area_zone_max-1 and latest_zone>area_zone { var fly_alpha=0.5, fly_color=make_color_hsv(fly_hue,100,255); } else { var fly_alpha=0.1, fly_color=c_white; }
		draw_sprite_general(sp_sheet,0,16*29,16*8,16,16,fly_next_x,fly_next_y,1,1,0,fly_color,fly_color,fly_color,fly_color,fly_alpha);
	}
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	draw_set_alpha(1);
	//
	var bar_amount=(roadmap_area*100)/(roadmap_current_max-1);
	draw_healthbar(road_win_x+2,road_win_y-17-rel_hud,road_win_x+237,road_win_y-14-rel_hud,bar_amount,
	global.color_roadmap_bar_back,global.color_character_light,global.color_character_light,0,true,false);
	//
	for (var i=0; i<roadmap_current_max; i++;) {
		var dot_pos_percentage=(i*100)/(roadmap_current_max-1);
		draw_sprite_general(sp_sheet,0,16*6,16*15,16,16,road_win_x-2+(dot_pos_percentage*228)/100,road_win_y-23-rel_hud,1,1,0,c_white,c_white,c_white,c_white,0.2);
	}
	//
	if area_zone=area_zone_max-1 {
		for (var i=4; i>=1; i--;) {
			var elite_pos_percentage=((roadmap_current_max-i-1)*100)/(roadmap_current_max-1);
			draw_sprite_general(sp_sheet,0,16*4,16*15,16,16,road_win_x-2+(elite_pos_percentage*228)/100,road_win_y-24-rel_hud,1,1,0,c_white,c_white,c_white,c_white,1);
		}
	}
	//
	draw_sprite_general(sp_sheet,0,16*4,16*15,16,16,road_win_x-2+(100*228)/100,road_win_y-24-rel_hud,1,1,0,c_white,c_white,c_white,c_white,1);
	//
	draw_sprite_general(sp_sheet,0,16*((option_state[opt_playericon] mod 2)+1),16*11,16,16,road_win_x-2+(bar_amount*228)/100,road_win_y-23-rel_hud,1,1,0,
	c_white,c_white,c_white,c_white,1);
	draw_sprite_general(sp_sheet,0,16*(option_state[opt_playericon]+3),16*11,16,16,road_win_x-2+(bar_amount*228)/100,road_win_y-23-rel_hud,1,1,0,
	global.color_character,global.color_character,global.color_character,global.color_character,1);
	draw_sprite_general(sp_sheet,0,16*(option_state[opt_playericon]+3),16*12,16,16,road_win_x-2+(bar_amount*228)/100,road_win_y-23-rel_hud,1,1,0,c_white,c_white,c_white,c_white,1);
	//
	for (var i=0; i<=7; i++;) {
		if area_zone=i { var zone_icon_alpha=0.8; } else { var zone_icon_alpha=0.4; }
		//
		if i<=latest_city {
			draw_sprite_general(sp_sheet,0,16*(i+playericon_max+5),16*12,16,16,road_win_x+56+16*i,road_win_y+133,1,1,0,c_white,c_white,c_white,c_white,zone_icon_alpha); }
		else {
			draw_sprite_general(sp_sheet,0,16*(playericon_max+4),16*12,16,16,road_win_x+56+16*i,road_win_y+133,1,1,0,c_white,c_white,c_white,c_white,zone_icon_alpha/1.6); }
	}
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	draw_set_font(fn_m6x11);
	draw_set_halign(fa_center);
	//
	if menu_options_hover=true { var menu_alpha=1; } else { var menu_alpha=0.5; }
	draw_sprite_general(sp_sheet,0,16*7,16*9,16,16,screen_main_x+32-rel_hud*2,screen_main_y+126,1,1,0,c_white,c_white,c_white,c_white,menu_alpha);
	sc_drawtext(screen_main_x+40-rel_hud*2,screen_main_y+126+21,"Options",global.color_white,global.color_black,menu_alpha,menu_alpha,0,-1);
	if menu_deck_hover=true { var menu_alpha=1; } else { var menu_alpha=0.5; }
	draw_sprite_general(sp_sheet,0,16*8,16*9,16,16,screen_main_x+cam_w-48+rel_hud*2,screen_main_y+126,1,1,0,c_white,c_white,c_white,c_white,menu_alpha);
	sc_drawtext(screen_main_x+cam_w-39+rel_hud*2,screen_main_y+126+21,"Deck",global.color_white,global.color_black,menu_alpha,menu_alpha,0,-1);
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	// OPTIONS
	if menu_back_options_hover=true { var menu_alpha=1; } else { var menu_alpha=0.5; }
	draw_sprite_general(sp_sheet,0,16*8,16*9,16,16,screen_options_x+cam_w-32+rel_hud*2,screen_main_y+136,1,1,0,c_white,c_white,c_white,c_white,menu_alpha);
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	draw_set_font(fn_matchup); //must be the same font as in mouse check for string width
	draw_set_halign(fa_left);
	//
	var i=0;
	repeat (options_total) {
		if option_focus[i]=true { var option_alpha=1; }
		else { var option_alpha=0.5; }
		sc_drawtext(screen_options_x+option_x[i],screen_main_y+option_y[i],option_name[i],global.color_white,global.color_black,option_alpha,option_alpha,0,-1);
		sc_drawtext(screen_options_x+option_x[i]+string_width(option_name[i])+rel_hud*2,screen_main_y+option_y[i],option_state_text[i],
		global.color_white,global.color_black,option_alpha,option_alpha,0,-1);
		if i=opt_playericon {
			draw_sprite_general(sp_sheet,0,16*((option_state[i] mod 2)+1),16*11,16,16,
			screen_options_x+option_x[i]+string_width(option_name[i])+rel_hud*2,screen_main_y+option_y[i]-1,1,1,0,c_white,c_white,c_white,c_white,1);
			draw_sprite_general(sp_sheet,0,16*(option_state[i]+3),16*11,16,16,
			screen_options_x+option_x[i]+string_width(option_name[i])+rel_hud*2,screen_main_y+option_y[i]-1,1,1,0,
			global.color_character,global.color_character,global.color_character,global.color_character,1);
			draw_sprite_general(sp_sheet,0,16*(option_state[i]+3),16*12,16,16,
			screen_options_x+option_x[i]+string_width(option_name[i])+rel_hud*2,screen_main_y+option_y[i]-1,1,1,0,c_white,c_white,c_white,c_white,1);
		}
		i++;
	}
	//
	var i=0;
	repeat (colorsetup_total) {
		sc_drawtext(screen_options_x+colorsetup_main_x[i],screen_main_y+colorsetup_y[i],colorsetup_name[i],
		make_colour_rgb(colorsetup_r[i],colorsetup_g[i],colorsetup_b[i]),global.color_black,1,1,0,-1);
		//
		if colorsetup_focus_r[i]=true { var option_alpha=1; }
		else { var option_alpha=0.5; }
		sc_drawtext(screen_options_x+colorsetup_r_x[i]+rel_hud*2,screen_main_y+colorsetup_y[i],"R " + string(colorsetup_r[i]),
		global.color_white,global.color_black,option_alpha,option_alpha,0,-1);
		//
		if colorsetup_focus_g[i]=true { var option_alpha=1; }
		else { var option_alpha=0.5; }
		sc_drawtext(screen_options_x+colorsetup_g_x[i]+rel_hud*2,screen_main_y+colorsetup_y[i],"G " + string(colorsetup_g[i]),
		global.color_white,global.color_black,option_alpha,option_alpha,0,-1);
		//
		if colorsetup_focus_b[i]=true { var option_alpha=1; }
		else { var option_alpha=0.5; }
		sc_drawtext(screen_options_x+colorsetup_b_x[i]+rel_hud*2,screen_main_y+colorsetup_y[i],"B " + string(colorsetup_b[i]),
		global.color_white,global.color_black,option_alpha,option_alpha,0,-1);
		//
		i++;
	}
	//
	if option_state[opt_bg_type]!=3 { var option_alpha=1; }
	else { var option_alpha=0.5; }
	var bg_preview_x=screen_options_x+356, bg_preview_y=screen_main_y+option_y[opt_bg_type]+5;
	sc_drawrectangle(bg_preview_x-2,bg_preview_y-2,bg_preview_x+96,bg_preview_y+64,global.color_black,c_white,0,option_alpha,0,0);
	draw_sprite_general(sp_back_pixel,0,0,0,1,1,bg_preview_x,bg_preview_y,96,64,0,
	global.color_background_a,global.color_background_b,global.color_background_a,global.color_background_b,option_alpha);
	for (var i=0; i<=2; i+=2;) {
		draw_sprite_ext(sp_back_pixel,0,bg_preview_x+16*0,bg_preview_y+16*i,16,16,0,global.color_background_tile,option_alpha);
		draw_sprite_ext(sp_back_pixel,0,bg_preview_x+16*2,bg_preview_y+16*i,16,16,0,global.color_background_tile,option_alpha);
		draw_sprite_ext(sp_back_pixel,0,bg_preview_x+16*4,bg_preview_y+16*i,16,16,0,global.color_background_tile,option_alpha);
		draw_sprite_ext(sp_back_pixel,0,bg_preview_x+16*1,bg_preview_y+16*(i+1),16,16,0,global.color_background_tile,option_alpha);
		draw_sprite_ext(sp_back_pixel,0,bg_preview_x+16*3,bg_preview_y+16*(i+1),16,16,0,global.color_background_tile,option_alpha);
		draw_sprite_ext(sp_back_pixel,0,bg_preview_x+16*5,bg_preview_y+16*(i+1),16,16,0,global.color_background_tile,option_alpha);
	}
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	// DECK
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	if menu_back_deck_hover=true { var menu_alpha=1; } else { var menu_alpha=0.5; }
	draw_sprite_general(sp_sheet,0,16*7,16*9,16,16,screen_deck_x+16-rel_hud*2,screen_main_y+136,1,1,0,c_white,c_white,c_white,c_white,menu_alpha);
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	// TOOLTIP
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	sc_draw_tooltip_text(camera_get_view_x(view_camera[0])+cam_w);
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	// CHALLENGE MESSAGE
	//————————————————————————————————————————————————————————————————————————————————————————————————————
	if area_zone=0 and zone_first_lap=true and roadmap_area=0 { //same conditions for setting challenge mode
		draw_set_font(fn_matchup);
		draw_set_halign(fa_center);
		//
		sc_drawtext(screen_main_x+256,screen_main_y+9,"Challenges can only be set before picking a Starter Deck.\nIf you want to set a challenge, go to the Options menu.",
		global.color_white,global.color_black,0.6,0.5,0,-1);
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if type_chart=true {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_black,c_white,0,0.9,0,0);
	draw_sprite_ext(sp_type_chart,0,camera_get_view_x(view_camera[0])+102,camera_get_view_y(view_camera[0])+26,1,1,0,c_white,1);
}
//
if credits_screen=true {
	draw_set_halign(fa_center);
	draw_set_font(fn_matchup);
	//
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_black,c_white,0,0.9,0,0);
	sc_drawtext(screen_options_x+cam_w/2,screen_main_y+53,
	"Pokemon belongs to Nintendo and The Pokemon Company." + "\n" +
	"This is a fangame made just for fun and it's in no way related to Nintendo." + "\n\n" +
	"Official art/sprites by GAME FREAK." + "\n" +
	"Official music by ICHIRO SHIMAKURA (HUDSON SOFT)." + "\n" +
	"Custom art/sprites by MOODYTAIL and POKESPRITE." + "\n" +
	"Sound effects by MOODYTAIL and TOM VIAN." + "\n" +
	"Fonts by DANIEL LINSSEN and EEVE SOMEPX." + "\n\n" +
	"Created by MOODYTAIL." + "\n" +
	"https://moodytail.itch.io/" + "\n\n" +
	"Special thanks to all my friends, testers and supporters. <3" + "\n" +
	"(" + game_version + ")",
	global.color_white,global.color_black,1,1,0,-1);
}
//
if statistics_screen=true {
	draw_set_halign(fa_center);
	draw_set_font(fn_matchup);
	//
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_black,c_white,0,0.9,0,0);
	//
	var timeplayed_var=stats_timeplayed, timeplayed_hours=0, timeplayed_minutes=0, timeplayed_seconds=0, timeplayed_text="";
	timeplayed_var=floor(timeplayed_var/60);
	timeplayed_hours=floor(timeplayed_var/3600);
	timeplayed_minutes=floor(timeplayed_var/60)-(timeplayed_hours*60);
	timeplayed_seconds=timeplayed_var-(timeplayed_hours*3600)-(timeplayed_minutes*60);
	timeplayed_text=string(timeplayed_hours) + "h " + string(timeplayed_minutes) + "m " + string(timeplayed_seconds) + "s.";
	//
	var timeleague_var=stats_league_won_firsttime, timeleague_hours=0, timeleague_minutes=0, timeleague_seconds=0, timeleague_text="";
	timeleague_var=floor(timeleague_var/60);
	timeleague_hours=floor(timeleague_var/3600);
	timeleague_minutes=floor(timeleague_var/60)-(timeleague_hours*60);
	timeleague_seconds=timeleague_var-(timeleague_hours*3600)-(timeleague_minutes*60);
	if stats_league_won_firsttime=0 { timeleague_text="-"; }
	else { timeleague_text=string(timeleague_hours) + "h " + string(timeleague_minutes) + "m " + string(timeleague_seconds) + "s."; }
	//
	if statistics_disabled=false {
		sc_drawtext(screen_options_x+cam_w*0.28,screen_main_y+72,
		"Time played: " + timeplayed_text + "\n" +
		"Total battles: " + string(stats_battles_total) + ".\n" +
		"Total battles won: " + string(stats_battles_won) + ".\n" +
		"Total battles lost: " + string(stats_battles_lost) + ".\n" +
		"Battles against trainers: " + string(stats_battles_trainers) + ".\n" +
		"Battles against gym leaders: " + string(stats_battles_gyms) + ".\n" +
		"Battles in Crystal League: " + string(stats_battles_league) + ".\n" +
		"Crystal League victories: " + string(stats_league_won) + ".\n" +
		"1st Crystal League victory: " + timeleague_text + "\n" +
		"Opponent's cards defeated: " + string(stats_cards_defeated) + ".\n" +
		"Player's cards defeated: " + string(stats_cards_lost) + ".",
		global.color_white,global.color_black,1,1,0,-1);
		//
		sc_drawtext(screen_options_x+cam_w*0.72,screen_main_y+72,
		"Total money: $" + string(stats_money_total) + ".\n" +
		"Total cards sold: " + string(stats_cards_sold) + ".\n" +
		"Payouts acquired: " + string(stats_payouts) + ".\n" +
		"Card packs opened: " + string(stats_cardpacks) + ".\n" +
		"Berry packs opened: " + string(stats_berrypacks) + ".\n" +
		"Free cards acquired: " + string(stats_freecards) + ".\n" +
		"Glyphs acquired: " + string(stats_glyphs_added) + ".\n" +
		"Level ups performed: " + string(stats_levelups) + ".\n" +
		"Evolutions performed: " + string(stats_evolutions) + ".\n" +
		"Tributes performed: " + string(stats_tributes) + ".\n" +
		"Times \"not ready\": " + string(stats_notready) + ".",
		global.color_white,global.color_black,1,1,0,-1);
	}
	else {
		// SAVE COMPATIBILITY (v1.7.0.0)
		sc_drawtext(screen_options_x+cam_w/2,screen_main_y+137,"Player stats disabled: save data is incompatible. :(",global.color_white,global.color_black,1,1,0,-1);
	}
}
//
if nickname_screen=true {
	draw_set_halign(fa_center);
	draw_set_font(fn_matchup);
	//
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_black,c_white,0,0.9,0,0);
	sc_drawtext(screen_deck_x+cam_w/2,screen_main_y+122,"Input new nickname.\n[Enter] to confirm, [Escape] to cancel.",global.color_white,global.color_black,1,1,0,-1);
	sc_drawtext(screen_deck_x+cam_w/2,screen_main_y+152,nickname_input,global.color_character_light,global.color_black,1,1,0,-1);
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if ending_screen=true {
	draw_sprite_general(sp_area,0,240*3,112*2,240,112,screen_main_x-104,screen_main_y-24,3,3,0,c_white,c_white,c_white,c_white,1); //city
	//
	if ending_static_timer>0 {
		var noise_size=16;
		for (var i=0; i<ceil(cam_w/noise_size); i++;) {
			for (var ii=0; ii<ceil(cam_h/noise_size); ii++;) {
				draw_sprite_general(sp_noise,0,noise_size*irandom((512/noise_size)-1),noise_size*irandom((512/noise_size)-1),noise_size,noise_size,
				screen_main_x+(i*noise_size),screen_main_y+(ii*noise_size),1,1,0,c_white,c_white,c_white,c_white,1);
			}
		}
		//
		draw_set_font(fn_m3x6);
		draw_set_halign(fa_right);
		sc_drawtext(screen_main_x+cam_w-3,screen_main_y+cam_h-14,"PHOENIX: 35.176861, 158.977194",global.color_white,global.color_black,0.75,0.25,0,-1);
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if fade_black>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_black,c_white,0,fade_black,1,0);
}
if fade_black_exit>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_black,c_white,0,fade_black_exit,1,0);
}
if fade_red_delete>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_delete_save,c_white,0,fade_red_delete,1,0);
}
if fade_white_load_01>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_white,c_white,0,fade_white_load_01,1,0);
}
if fade_white_load_02>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_white,c_white,0,fade_white_load_02,1,0);
}
if fade_white_load_03>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_white,c_white,0,fade_white_load_03,1,0);
}
if fade_white_load_04>0 {
	sc_drawrectangle(-2,-2,room_width+2,room_height+2,global.color_white,c_white,0,fade_white_load_04,1,0);
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if event_transition=ref_event_victory or event_transition=ref_event_defeat {
	draw_set_halign(fa_center);
	//
	if event_transition=ref_event_victory and playing_champion=false {
		if playing_gym=false or latest_zone>area_zone { var victory_text_y=screen_main_y+cam_h/2-17; }
		else { var victory_text_y=screen_main_y+cam_h/2-29; }
		//
		draw_set_font(fn_m6x11_XL);
		sc_drawtext(screen_main_x+cam_w/2,victory_text_y,"VICTORY",global.color_friendly,global.color_black,1,1,0,-1);
		draw_set_font(fn_matchup);
		sc_drawtext(screen_main_x+cam_w/2,victory_text_y+22,"Received $" + string(money_prize),global.color_card_light,global.color_black,1,1,0,-1);
		if playing_gym=true and latest_zone=area_zone {
			sc_drawtext(screen_main_x+cam_w/2,victory_text_y+22,"\nDeck size increased!\nMax card level increased!",global.color_card_light,global.color_black,1,1,0,-1); }
	}
	else if event_transition=ref_event_defeat {
		draw_set_font(fn_m6x11_XL);
		sc_drawtext(screen_main_x+cam_w/2,screen_main_y+cam_h/2-10,"DEFEAT",global.color_enemy,global.color_black,1,1,0,-1);
	}
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
if textbox_string[textbox_current]!="" {
	draw_set_font(fn_matchup);
	draw_set_halign(fa_left);
	//
	sc_drawrectangle(screen_main_x+5,screen_main_y+cam_h-51,screen_main_x+cam_w-6,screen_main_y+cam_h-6,global.color_black,global.color_character,1,0.9,1,1);
	sc_drawtext(screen_main_x+11,screen_main_y+cam_h-48,textbox_show,global.color_white,global.color_black,1,0.5,0,492);
}
//————————————————————————————————————————————————————————————————————————————————————————————————————
draw_sprite_ext(sp_border_shading,0,camera_get_view_x(view_camera[0]),camera_get_view_y(view_camera[0]),1,1,0,c_white,option_state[opt_edge]/100);
//————————————————————————————————————————————————————————————————————————————————————————————————————
if cursor_hide=false { var mouse_alpha=1; } else { var mouse_alpha=0.5; }
draw_sprite_general(sp_sheet,0,16*(mouse_cursor+1),16*0,16,16,mouse_x-5,mouse_y-5,1,1,0,c_white,c_white,c_white,c_white,mouse_alpha);