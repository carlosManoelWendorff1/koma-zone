extends CharacterBody2D

class_name Player

const SPEED = 300.0

@export var money = 0
@export var KillCount = 0
var current_position: Vector2

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

	# Ajuste para o sprite: se seu sprite está olhando "para cima", subtraia 90 graus (PI/2)
	rotation = direction.angle() + deg_to_rad(90)

	if Input.is_action_just_pressed("ui_accept"):
		money += 1
		KillCount += 1
		print("Money:", money)
		print("Kills:", KillCount)
	
	current_position = global_position
