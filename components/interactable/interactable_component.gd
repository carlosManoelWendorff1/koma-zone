extends Node2D
class_name InteractableComponent

var interactable_area: Area2D
signal interaction_emitter

func _ready() -> void:
	if get_child_count() < 1:
		push_error("InteractableComponent needs an Area2D")
		return
	if not (get_child(0) is Area2D):
		push_error("InteractableComponent needs an Area2D")
		return
	
	interactable_area = get_child(0)
	interactable_area.body_entered.connect(_on_area_enter)
	interactable_area.body_exited.connect(_on_area_exit)

func _on_area_enter(_body: Node2D):
	print_debug("Object: ", _body.name, " entered")
	if _body.name.to_lower() == "player":
		if not (_body as Player).interaction.is_connected(_interaction_emitter):
			print_debug("interaction_emitter connected")
			(_body as Player).interaction.connect(_interaction_emitter)

func _on_area_exit(_body: Node2D):
	print_debug("Object: ", _body.name, " exited")
	if _body.name.to_lower() == "player":
		if (_body as Player).interaction.is_connected(_interaction_emitter):
			print_debug("interaction_emitter disconnected")
			(_body as Player).interaction.disconnect(_interaction_emitter)


func _interaction_emitter():
	interaction_emitter.emit()
