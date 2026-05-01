
prev_mouse_x = 0
prev_mouse_y = 0
spr_back = Spr_menu_puzle
spr_buton = Spr_buton
horved_color = $F4C6F8
buttons = [];
uping = true

x = display_get_gui_width()/4
y = display_get_gui_height()/2

function fun_volumSetings(){
	global.ui_status = UI_STATUS.VOLUM_SETINGS_MENU
	set_buttons()
}

function open_settings() {
	
	global.ui_status = UI_STATUS.SETINGS_MENU	
	set_buttons()
}

function set_vibro(){
	
	if(uping){
		 global.vibro += 0.1
		 
		 if(global.vibro > 1){
			global.vibro = 1
			return;
		}
	}else{
		
		global.vibro -= 0.1
		 
		if(	global.vibro < 0){
			global.vibro = 0
			return;
		}
	}
	
	ini_open("Settings.ini")
		ini_write_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.VIBRO, global.vibro)
	ini_close()	
	
	set_buttons()
}

function back(){
	global.ui_status = UI_STATUS.PAUS_MENU
	set_buttons()
}

function set_skrin(){
	
	window_set_fullscreen(!window_get_fullscreen())
	ini_open("Settings.ini")
		ini_write_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.FULLSKRIN,window_get_fullscreen())
	ini_close()	
	set_buttons()
}

function set_skrin_size(){
	
	if(uping){
		global.skrinSize++	
		
		if(	global.skrinSize >= array_length(global.screen_sizes)){
			global.skrinSize = array_length(global.screen_sizes)-1
			return;
		}
	
	}else{
			global.skrinSize--
		
		if(	global.skrinSize < 0){
			global.skrinSize = 0
			return;
		}
	}
	
	ini_open("Settings.ini")
		ini_write_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.FULLSKRIN,global.skrinSize)
	ini_close()	
	
	fun_set_skrin()
	set_buttons()
}

function set_vol(_key){
	var _vol = ds_map_find_value(global.vol,_key)

	if(uping){
		_vol += 0.1	
		
		if(	_vol >= 1){
			_vol = 1
		}
	
	}else{
			_vol -= 0.1	
		
		if(	_vol < 0){
			_vol = 0
		}
	}
	
	ds_map_replace(global.vol,_key,_vol)
	
	ini_open("Settings.ini")
		ini_write_real(SETTINGS_CONST.VOLUM_SETINGS, _key,	_vol)
	ini_close()	
	
	set_buttons()
}

function language(){
	if(uping){
		global.language++	
		
		if(	global.language > LANGUAGE.NUMBER){
			global.language  = 1
		}
	
	}else{
			global.language--
		
		if(	global.language  < 1){
			global.language = LANGUAGE.NUMBER
		}
	}
	
	ini_open("Settings.ini")
		ini_write_real(SETTINGS_CONST.SETTINGS, SETTINGS_CONST.LANGUAGE_SETINGS,	global.language)
	ini_close()	
	
	set_buttons()
}

function set_buttons(){
	focus = -1
	switch (global.ui_status){
		
	case 	UI_STATUS.PAUS_MENU:
			
		buttons = [
			fun_button_create(get_translate(global.translate_grid,"Continue"),	Obj_controler.pres_pause),
			fun_button_create(get_translate(global.translate_grid,"Settings"),	open_settings),
			fun_button_create(get_translate(global.translate_grid,"Volume settings"),	fun_volumSetings),   
			fun_button_create(get_translate(global.translate_grid,"Quit game"),	 game_end),
		];
	break;
	
	
	case 	UI_STATUS.SETINGS_MENU:
		var skrin = ""
		if(window_get_fullscreen()){
			skrin = get_translate(global.translate_grid,"full-screen")
		}else{
			skrin = get_translate(global.translate_grid,"Windowed mod")
		}	
		
		buttons = [
			fun_button_create("< "+get_translate(global.translate_grid,"language")+" >",	language),
			fun_button_create(skrin,	set_skrin),
			fun_button_create("< "+string( global.screen_w)+"x"+	string( global.screen_h) +" >",	set_skrin_size),
			fun_button_create("< "+get_translate(global.translate_grid,"Vibro")+" "+string( global.vibro) +" >",	set_vibro),
			fun_button_create(get_translate(global.translate_grid,"Back"),	back),
		];
		
	break;
	
	case 	UI_STATUS.VOLUM_SETINGS_MENU:
	
		
		
			buttons = [
			fun_button_create("< "+get_translate(global.translate_grid,"Volume")+" "+	string( ds_map_find_value(global.vol,SETTINGS_CONST.VOL_MASTER))+" >",	set_vol,	SETTINGS_CONST.VOL_MASTER),
			fun_button_create("< "+get_translate(global.translate_grid,"Music")+" "+	string( ds_map_find_value(global.vol,SETTINGS_CONST.VOL_MUSIK))+" >",	set_vol,	SETTINGS_CONST.VOL_MUSIK),
			fun_button_create("< "+get_translate(global.translate_grid,"Effects")+" "+	string( ds_map_find_value(global.vol,SETTINGS_CONST.VOL_FX))+" >",		set_vol,	SETTINGS_CONST.VOL_FX),
			fun_button_create(get_translate(global.translate_grid,"Back"),	back)
			];
		
		
	break;
	}
	
	
}


set_buttons()