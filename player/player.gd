extends CharacterBody2D

const SPEED = 300.0

@export var money = 0

@export var KillCount = 0

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# Captura o input das setas ou teclas W/A/S/D
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	# Normaliza pra manter mesma velocidade em diagonais
	input_vector = input_vector.normalized()
	if Input.get_action_strength("ui_accept") :
		money +=1 ;
		KillCount +=1;
		print(money)
		print(KillCount)
	# Aplica velocidade
	velocity = input_vector * SPEED

	move_and_slide()
