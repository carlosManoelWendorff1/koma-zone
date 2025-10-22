extends CharacterBody2D

class_name Player

const SPEED = 300.0

@export var money = 0
@export var KillCount = 0
@export var health = 100

var alive: bool = true
var bullet_scene = preload("res://objects/projetil.tscn")
var current_position: Vector2

func _ready() -> void:
	$CanvasLayer/MarginContainer/VBoxContainer/vida.value = health

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	if health <= 0:
		die()
		return
	
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
		$fire.emitting = true
		var bullet = bullet_scene.instantiate()

		# Pegamos a posição do Marker2D (cano da arma)
		var muzzle = $GunMuzzle
		# A bala nasce no cano da arma, apontando na mesma direção do player
		bullet.global_position = muzzle.global_position
		bullet.global_rotation = muzzle.global_rotation + deg_to_rad(90)

		get_tree().current_scene.add_child(bullet)
		print("Bala disparada!")


func _on_collision_shape_2d_child_entered_tree(node: Node) -> void:
	print("entrou")
	pass # Replace with function body.

func die() -> void:
	if not alive: return
	print("player morreu!")
	alive = false
	get_tree().change_scene_to_file("res://Menu/game_over.tscn")

func take_damage(damage: int) -> void:
	health -= damage
