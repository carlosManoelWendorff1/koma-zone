extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for bt in get_tree().get_nodes_in_group("botao"):
		bt.pressed.connect(func(): on_button_pressed(bt))
		bt.mouse_exited.connect(func(): mouse_interaction(bt, "exited"))
		bt.mouse_entered.connect(func(): mouse_interaction(bt, "entered"))

func on_button_pressed(button: Button) -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func mouse_interaction(button:Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		
		"entered":
			button.modulate.a = 0.5
