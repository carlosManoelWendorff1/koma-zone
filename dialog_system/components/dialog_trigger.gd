extends Area2D
class_name DialogTrigger

@export var dialog_time_interval: float = 10.0

var _dialog_ended: bool = false
var dialog_handler: DialogHandler
var _dialog_index: int = 0
var dialog_manager: DialogManager
var _timer: Timer

func _ready() -> void:
	dialog_handler = get_node("DialogHandler")
	if dialog_handler == null:
		push_error(
			"DialogTrigger need a DialogHandler. Add it as a child. ", 
			global_position
		)
	
	dialog_manager = get_parent().get_node("DialogManager")
	if dialog_manager == null:
		push_error("DialogTrigger need a DialogHandler. Add it in root node. ")
	
	_timer = get_node("Timer")

func _on_area_entered(_body: Node2D) -> void:
	if not _body.get_parent().name.to_lower() == "player":
		return
	
	dialog_handler.init_dialog()
	if not _timer.autostart: _timer.autostart = true
	_timer.wait_time = dialog_time_interval
	if not _timer.is_connected("timeout", _next_dialog): _timer.connect("timeout", _next_dialog)
	_timer.start()

func _next_dialog() -> void:
	print_debug("Timer trigged _next_dialog") # TODO Remover debug
	if _dialog_ended: 
		print_debug("Dialog ended")
		dialog_manager.end_dialog()
		_timer.stop()
		return
	
	if not dialog_manager.dialog_started:
		print_debug("Dialog handler init")
		dialog_handler.init_dialog()
		_dialog_index = 0
		return
	
	print_debug("Node index: ", _dialog_index)
	var node_to_show = dialog_manager.dialogs[_dialog_index+1]
	print_debug("Node to show\n", node_to_show)
	dialog_manager.next_dialog(node_to_show.ID)
	
	if _dialog_index+2 >= len(dialog_manager.dialogs): 
		_dialog_ended = true
		return
	
	_dialog_index += 1
