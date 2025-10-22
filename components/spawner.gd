extends Node2D
class_name EnemySpawner

@export var interval: float = 1
@export var enemy_scene: PackedScene

var enemy_instance: CharacterBody2D
var timer: Timer

func _ready() -> void:
	timer = get_node('Timer')
	if timer == null:
		push_error("EnemySpawner component need a timer.")
		return
	
	timer.wait_time = interval
	timer.start()
	if not timer.is_connected("timeout", _spawn_enemy):
		timer.connect("timeout", _spawn_enemy)

func _spawn_enemy() -> void:
	if not enemy_scene == null:
		enemy_instance = enemy_scene.instantiate()
		enemy_instance.player = get_parent().get_node("player")
		enemy_instance.global_position = global_position
	
	if not enemy_instance == null:
		get_parent().add_child(enemy_instance)
	else:
		print_debug("Enemy instance is null. ", position)
