extends Node2D
class_name DialogManager

# The DialogManager is responsible for managing the dialog nodes of a context.
# This context is received through a DialogHandler.

var _current_dialog: String
var current_node
var dialogs: Array
var dialog_ended: bool
var _dialog_node_count: int
var dialog_started: bool = false
@export var _dialog_view: DialogView
var start_in: String
var end_in: String

func _ready() -> void:
	if _dialog_view == null:
		push_error("The scene need a DialogView.")

func init_dialog(ctx: Dictionary) -> void:
	# Initializes and prepares dialog nodes
	_current_dialog = ""
	_dialog_node_count = ctx.DialogNodes.size()
	dialogs = ctx.DialogNodes
	start_in = ctx.StartIn
	end_in = ctx.EndIn
	dialog_started = true
	dialog_ended = false
	next_dialog(start_in)

func next_dialog(_dialog_node_id: String) -> void:
	if _current_dialog == end_in:
		end_dialog()
		return
	
	for _node in dialogs:
		if _node.ID == _dialog_node_id:
			current_node = _node
			_dialog_view.show_dialog(_node)
			_current_dialog = _node.ID
			break

func end_dialog():
	_dialog_view.close_dialog()
	dialog_ended = true
	dialog_started = false
