
function fun_set_skrin(){
	
	global.screen_w = global.screen_sizes[global.skrinSize][0]
    global.screen_h = global.screen_sizes[global.skrinSize][1]
	window_set_size(global.screen_w, global.screen_h);
	
	scr_apply_scaling_extend(global.screen_w, global.screen_h)
	surface_resize(application_surface, global.screen_w, global.screen_h);
	
}

function scr_apply_scaling_extend(win_w, win_h){

//var win_w = argument0;
//var win_h = argument1;

var base_w = 960;
var base_h = 540;

// Масштаб — по меньшей стороне
var scale = min(win_w / base_w, win_h / base_h);

// Итоговый размер камеры (что реально видно)
var view_w = win_w / scale;
var view_h = win_h / scale;

// Устанавливаем окно
window_set_size(win_w, win_h);

// Настраиваем камеру
camera_set_view_size(view_camera[0], view_w, view_h);
display_set_gui_size(view_w, view_h);

// Вьюпорт всегда заполняет всё окно
view_set_wport(0, win_w);
view_set_hport(0, win_h);
//view_set_xport(0, 0);
//view_set_yport(0, 0);

}