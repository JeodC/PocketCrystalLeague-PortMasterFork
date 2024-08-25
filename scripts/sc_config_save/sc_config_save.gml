function sc_config_save() {
//————————————————————————————————————————————————————————————————————————————————————————————————————
var savemap=ds_map_create();
//
ds_map_add(savemap,"fullscreen",option_state[opt_fullscreen]);
ds_map_add(savemap,"vsync",option_state[opt_vsync]);
ds_map_add(savemap,"filter",option_state[opt_filter]);
ds_map_add(savemap,"window_scaling",option_state[opt_scaling]);
ds_map_add(savemap,"music",option_state[opt_music]);
ds_map_add(savemap,"sound",option_state[opt_sound]);
ds_map_add(savemap,"autodeck",option_state[opt_autodeck]);
ds_map_add(savemap,"dexnumber",option_state[opt_dexnumber]);
ds_map_add(savemap,"edge_shading",option_state[opt_edge]);
ds_map_add(savemap,"player_icon",option_state[opt_playericon]);
ds_map_add(savemap,"background_type",option_state[opt_bg_type]);
//
ds_map_add(savemap,"color_a_r",colorsetup_r[opt_bg_a]);
ds_map_add(savemap,"color_a_g",colorsetup_g[opt_bg_a]);
ds_map_add(savemap,"color_a_b",colorsetup_b[opt_bg_a]);
ds_map_add(savemap,"color_b_r",colorsetup_r[opt_bg_b]);
ds_map_add(savemap,"color_b_g",colorsetup_g[opt_bg_b]);
ds_map_add(savemap,"color_b_b",colorsetup_b[opt_bg_b]);
ds_map_add(savemap,"color_tile_r",colorsetup_r[opt_bg_tile]);
ds_map_add(savemap,"color_tile_g",colorsetup_g[opt_bg_tile]);
ds_map_add(savemap,"color_tile_b",colorsetup_b[opt_bg_tile]);
ds_map_add(savemap,"color_char_r",colorsetup_r[opt_c_char]);
ds_map_add(savemap,"color_char_g",colorsetup_g[opt_c_char]);
ds_map_add(savemap,"color_char_b",colorsetup_b[opt_c_char]);
//
ds_map_secure_save(savemap,config_file + file_format);
ds_map_destroy(savemap);
//————————————————————————————————————————————————————————————————————————————————————————————————————
}