/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

global.screen_sizes = [
    // --- 16:9 самые популярные ---
    [1280, 720],     // HD
    [1366, 768],     // ноутбуки
    [1600, 900],     // HD+
    [1920, 1080],    // Full HD
    [2560, 1440],    // 2K (QHD)
    [3200, 1800],    // QHD+ (HiDPI ноуты)
    [3840, 2160],    // 4K

    // --- 16:10 (часто в играх на ноутбуках) ---
    [1280, 800],
    [1440, 900],
    [1680, 1050],
    [1920, 1200],
    [2560, 1600],
    [2880, 1800],    // MacBook Retina
    [3840, 2400],

    // --- 4:3 (редко, но совместимость) ---
    [1024, 768],
    [1280, 960],
    [1400, 1050],
    [1600, 1200],

    // --- 21:9 ультраширокие ---
    [2560, 1080],
    [3440, 1440],
    [3840, 1600],

    // --- 32:9 супер ультраширокие ---
    [3840, 1080],
    [5120, 1440]
];

enum SETTINGS_CONST{ SETTINGS, FULLSKRIN, VIBRO, LANGUAGE_SETINGS,
	VOLUM_SETINGS, VOL_MASTER, VOL_MUSIK, VOL_FX }


global.vol = ds_map_create()
ini_open("Settings.ini")

	window_set_fullscreen(ini_read_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.FULLSKRIN,false))
	global.skrinSize = ini_read_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.FULLSKRIN,3)

	global.vibro = ini_read_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.VIBRO,1)
	global.language = (ini_read_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.LANGUAGE_SETINGS,LANGUAGE.ENGLISH))

	ds_map_add(global.vol, SETTINGS_CONST.VOL_MASTER,	ini_read_real(SETTINGS_CONST.VOLUM_SETINGS,	SETTINGS_CONST.VOL_MASTER,	0.5));
	ds_map_add(global.vol, SETTINGS_CONST.VOL_MUSIK,	ini_read_real(SETTINGS_CONST.VOLUM_SETINGS,	SETTINGS_CONST.VOL_MUSIK,	0.5));
	ds_map_add(global.vol, SETTINGS_CONST.VOL_FX,		ini_read_real(SETTINGS_CONST.VOLUM_SETINGS,	SETTINGS_CONST.VOL_FX,		0.5));

ini_close()	

fun_set_skrin()
	

global.ui_status = UI_STATUS.PLAY
has_focus = true

ini_open("StaySave.ini")
//global.progres = ini_read_real(CONST.PROGRES, CONST.PHASECLEAR, 0)
//var tutorial = ini_read_real(CONST.PROGRES, CONST.TUTORIAL, true)
ini_close()	

window_set_cursor(cr_none)

enum UI_STATUS{
	PLAY, PAUS_MENU, SETINGS_MENU, VOLUM_SETINGS_MENU
}


function pres_pause(_ui_status=noone,_active= noone){
		
	
	switch (global.ui_status){
			
		
		case UI_STATUS.PLAY:
			
			global.ui_status = UI_STATUS.PAUS_MENU
			window_set_cursor(cr_default)
			instance_deactivate_all(true);
			instance_create_layer(0, 0, "GUI", obj_pause_menu);
			instance_activate_layer(layer_get_id("GUI"))	
					
					show_debug_message("pause")
					
			noise = layer_create(-150)
			var fx = fx_create("_filter_fractal_noise"); 
			fx_set_parameter(fx, "g_FractalNoiseTintColour", [0.098, 0.098, 0.121, 1]);
			fx_set_parameter(fx, "g_FractalNoiseSpeed", 0.5 );
			layer_set_fx(noise, fx);
			
		break;
		
		case UI_STATUS.PAUS_MENU:
			
			instance_activate_all()
			
			window_set_cursor(cr_none)
			
			instance_destroy(obj_pause_menu);
						
			layer_destroy(noise)
			
			global.ui_status = UI_STATUS.PLAY
			
			show_debug_message("unpause")
		break;
		
	}
    
	if(_ui_status!=noone){
		global.ui_status = _ui_status
	}
	
	if(_active!=noone){
		instance_activate_object(_active)
	}
	
}