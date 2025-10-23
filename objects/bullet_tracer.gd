extends Line2D

@export var target: Node2D
@export var max_points: int = 30

func _process(_delta: float) -> void:
	if not target or not is_instance_valid(target):
		queue_free()
		return

	add_point(target.global_position)

	if points.size() > max_points:
		remove_point(0)
