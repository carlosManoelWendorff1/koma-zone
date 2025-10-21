extends CharacterBody2D

class_name Player

const SPEED = 300.0

@export var money = 0
@export var KillCount = 0
var bullet_scene = preload("res://objects/projetil.tscn")
var current_position: Vector2
var player_health = 100

func _ready() -> void:
	$CanvasLayer/MarginContainer/VBoxContainer/vida.value = player_health

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# Captura o input das setas ou teclas W/A/S/D
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	velocity = input_vector * SPEED
	move_and_slide()

	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position

	# Ajuste para o sprite: se o sprite está "para cima", adicione PI/2 (90 graus)
	rotation = direction.angle() + deg_to_rad(90)

	if Input.is_action_just_pressed("shoot") and bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position
		bullet.rotation = rotation
		get_tree().current_scene.add_child(bullet)
		print("Bala disparada!")
	else:
		print("Não disparou - bullet_scene vazio?", bullet_scene == null)

	current_position = global_position


func _on_collision_shape_2d_child_entered_tree(node: Node) -> void:
	print("entrou")
	pass # Replace with function body.
