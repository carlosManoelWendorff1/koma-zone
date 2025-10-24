extends Node2D

var _interactable_component: InteractableComponent
var _dialog_handler: DialogHandler
@export var _dialog_manager: DialogManager
var _current_dialog: int
var _dialog_started: bool

func _ready() -> void:
	_interactable_component = get_node("InteractableComponent")
	if _interactable_component == null :
		push_error("Note needs a InteractableComponent", global_position)
	var _area: Area2D = _interactable_component.get_child(0)
	_area.connect("area_exited", _close_note)
	
	_dialog_handler = get_node("DialogHandler")
	if _dialog_handler == null :
		push_error("Note needs a DialogHandler", global_position)
	
	if not _interactable_component.interaction_emitter.is_connected(_read_note):
		print_debug("connected interaction emmiter in note")
		_interactable_component.interaction_emitter.connect(_read_note)

func _read_note():
	print_debug("read note")
	if not _dialog_started:
		_dialog_handler.init_dialog()
		_current_dialog = 0
		_dialog_started = true
		return
	
	if _current_dialog+1 > len(_dialog_manager.dialogs)-1:
		_dialog_manager.end_dialog()
		_dialog_started = false
		return
	
	var node_to_show = _dialog_manager.dialogs[_current_dialog+1]
	_dialog_manager.next_dialog(node_to_show.ID)
	_current_dialog += 1

func _close_note(_arg):
	print_debug("Close note")
	_dialog_manager.end_dialog()
	_dialog_started = false
	_current_dialog = 0
