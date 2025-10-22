extends Node2D

@export var damage: int = 20

func _ready() -> void:
	$fire.emitting = true
	$Timer.start()
	connect("area_entered", _on_body_entered)
	$Timer.connect("timeout", Callable(self, "_on_timeout"))

func _on_body_entered(body):
	
	if body.has_method("take_damage"):
		body.take_damage(damage)

func _on_timeout():
	
	queue_free()
