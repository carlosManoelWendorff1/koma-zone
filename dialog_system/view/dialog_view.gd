extends Control
class_name DialogView

var _dialog_manager: DialogManager
var options_vbox: VBoxContainer
var title_text_reach: RichTextLabel
var text_text_reach: RichTextLabel

func _ready() -> void:
	title_text_reach = get_node('Background/VBoxContainer/Title')
	text_text_reach = get_node('Background/VBoxContainer/Text')
	options_vbox = get_node('Background/VBoxContainer/Options')
	_dialog_manager = get_parent().get_node('DialogManager')
	
	if title_text_reach == null:
		push_error("DialogView component is missing title TextTeach.")
	if text_text_reach == null:
		push_error("DialogView component is missing text TextReach.")
	if options_vbox == null:
		push_error("DialogView component is missing title VBoxContainer.")
	if _dialog_manager == null:
		push_error("Scene "+ get_parent().name +" is missing DialogManager.")

func show_dialog(_dialog) -> void:
	if !visible:
		visible = true
	
	title_text_reach.clear()
	text_text_reach.clear()
	title_text_reach.append_text(_dialog.Title)
	text_text_reach.append_text(_dialog.Text)
	
	_load_options(_dialog.Options)
	
	#print(_dialog.Title)
	#print(_dialog.Text)
	#print("Options:")
	#for option in _dialog.Options:
	#	print("- "+option.Placeholder)

func close_dialog() -> void:
	if visible:
		visible = false
	title_text_reach.clear()
	text_text_reach.clear()
	_clear_options()

func _load_options(options) -> void:
	# Loads the response buttons. 
	# Adding placeholders and connecting them to the button interaction signals.
	_clear_options()
	
	for opt in options:
		var _opt_button: Button = preload('res://dialog_system/view/option_button.tscn').instantiate()
		_opt_button.button_up.connect(_dialog_manager.next_dialog.bind(opt.Goes), CONNECT_ONE_SHOT)
		_opt_button.text = opt.Placeholder
		options_vbox.add_child(_opt_button)

func _clear_options() -> void:
	if not options_vbox.get_children().size() > 0:
		return
	
	for btn in options_vbox.get_children():
		btn.queue_free()
