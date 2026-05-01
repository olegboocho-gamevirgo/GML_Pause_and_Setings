// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377

//enum  BUTTON_STYLE{ HAUSE, VINIL, TEXT}


function fun_button_create(_text, _callback, _param = noone) {
   var btn = {
        b_text:		_text,
        hovered:	false,
        callback:	_callback,
		param :		_param

    };
    return btn;
}

function fun_button_press(buttons){
	
	for (var i = 0; i < array_length(buttons); i++) {
		var button = buttons[i]
		
		if (button.hovered){
			button.callback(button.param)
		}
	}
	
}

function fun_button_update(buttons, _X=0, _Y=0, _wheel = 0) {
	
	var _YY = _Y+_wheel
	
	var w  = sprite_get_width(spr_buton)/2
	var h  = sprite_get_height(spr_buton)/2
	
	for(var i = 0 ; i < array_length(buttons); i++){
	
		buttons[i].hovered = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 
		_X - w, _YY +fun_calculate_Y(array_length(buttons),i) - h, _X + w, _YY+fun_calculate_Y(array_length(buttons),i) +h);
	
	}
			
	
}



function fun_button_draw(buttons, _X=0, _Y=0, _wheel = 0) {
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	for(var i = 0 ; i < array_length(buttons); i++){
		
		var frame =	buttons[i].hovered ? 1 : 0;
		var edge =0
						
		if(i=0){
			var edge = 1
		}
		
		if(i = array_length(buttons)-1){
			var edge = 2
		}
		
		
			var addY = _Y+fun_calculate_Y(array_length(buttons),i)+ _wheel
			draw_sprite(spr_back, 0,	_X, addY);
			draw_sprite(spr_buton, frame, _X, addY);
			
			
			var coll =	c_white
			
			if(frame = 1){
				coll = horved_color 
			}
		
			draw_set_color(coll);
			draw_set_font(Font1)
			draw_text(_X, addY, buttons[i].b_text);
		
	}


		
		var addY = _Y+fun_calculate_Y(array_length(buttons),-1)+ _wheel
		draw_sprite(spr_back, 1,	_X, addY);
		
		var addY = _Y+fun_calculate_Y(array_length(buttons),array_length(buttons))+ _wheel
		draw_sprite(spr_back, 2,	_X, addY);
}

function fun_calculate_Y(var_caunt, var_num){
	var spr_height =  sprite_get_height(spr_back) 
	
	var centr = (var_caunt / 2) - 0.5
	
	var pos = (var_num - centr)*spr_height  

	
	return  pos
}