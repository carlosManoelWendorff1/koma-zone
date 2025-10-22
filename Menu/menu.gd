extends Control

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(func(): on_button_pressed(button))
		button.mouse_exited.connect(func(): mouse_interaction(button, "exited"))
		button.mouse_entered.connect(func(): mouse_interaction(button, "entered"))
		
func on_button_pressed(button: Button) -> void:
	match button.name:
		"jogar":
			var _jogar: bool = get_tree().change_scene_to_file("res://main.tscn")
		
		"tutorial":
			var _tutorial: bool = get_tree().change_scene_to_file("res://tutorial.tscn")
		
		"controles":
			var _controles: bool = get_tree().change_scene_to_file("res://Menu/control.tscn")
		
		"3_membros":
			var _membros: bool = OS.shell_open("https://github.com/carlosManoelWendorff1/koma-zone")
		
		"Sair":
			get_tree().quit()

func mouse_interaction(button:Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		
		"entered":
			button.modulate.a = 0.5
