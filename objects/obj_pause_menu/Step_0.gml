

	fun_button_update(buttons,x,y);
	
	if (gamepad_button_check_released(0, gp_face1) | keyboard_check_released(vk_enter)){
		uping = true
		fun_button_press(buttons);

	}
	
	if ( mouse_check_button_released(mb_left) ){
		
		if(device_mouse_x_to_gui(0)<x){
			uping = false
		}else{
			uping = true
		}
		
		fun_button_press(buttons);
	}
	
	if (gamepad_button_check_released(0, gp_padl) || keyboard_check_released(vk_left)){
		uping = false
		fun_button_press(buttons);
	}
	
	if (gamepad_button_check_released(0, gp_padr) || keyboard_check_released(vk_right)){
		uping = true
		fun_button_press(buttons);
	}	
	
	if(prev_mouse_x != device_mouse_x_to_gui(0) && prev_mouse_y != device_mouse_y_to_gui(0)){
		focus = -1
	}else{
		if (gamepad_button_check_released(0, gp_padd) | keyboard_check_released(vk_down)){
			focus++
			if(focus>=array_length(buttons)){
				focus = 0
			}
		}
		
		if (gamepad_button_check_released(0, gp_padu) | keyboard_check_released(vk_up)){
			focus--
			if(focus<0){
				focus = array_length(buttons)-1
			}
		}	
		
		if(focus != -1){
			for(var i = 0; i < array_length(buttons); i++){
				buttons[i].hovered = false
			}
			
			buttons[focus].hovered = true
		}
	}
	
	
	prev_mouse_x = device_mouse_x_to_gui(0)
	prev_mouse_y = device_mouse_y_to_gui(0)




