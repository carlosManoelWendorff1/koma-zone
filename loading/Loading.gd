extends Node

func load_screen_to_scene(target: String) -> void:
	var loading_scene = preload("res://loading/loading_scene.tscn").instantiate()
	loading_scene.next_scene_path = target
	get_tree().current_scene.add_child(loading_scene)
