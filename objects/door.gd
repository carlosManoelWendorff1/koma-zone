extends Node2D

@export var scene_path:PackedScene

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and scene_path:
		get_tree().change_scene_to_file(scene_path.resource_path)
