extends Node2D

@export var health: int = 10
@export var explosion_scene: PackedScene
@export var explosion_damage: int = 20

func _process(_delta: float) -> void:
	if health <= 0:
		gas_tank_break()

func gas_tank_break():
	print("broken!")

	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	explosion.damage = explosion_damage
	get_parent().add_child(explosion)

	queue_free() # opcional: remove o tanque depois da explosão
