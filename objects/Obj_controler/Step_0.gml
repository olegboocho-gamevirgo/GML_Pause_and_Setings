/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе



if (gamepad_button_check_pressed(0, gp_start)){
	pres_pause()
}


if (gamepad_button_check_pressed(0, gp_face2) && global.ui_status = UI_STATUS.PAUS_MENU){
	pres_pause()
}

if (has_focus != window_has_focus())
{
		
	has_focus = window_has_focus()
	if(global.ui_status = UI_STATUS.PLAY){
		pres_pause()
	}
}
