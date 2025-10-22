extends CharacterBody2D

class_name Player

const SPEED = 300.0
@export var money = 0
@export var KillCount = 0
@export var health = 100

var alive: bool = true
var shooting: bool = false
var bullet_scene = preload("res://objects/projetil.tscn")

func _ready() -> void:
	$CanvasLayer/MarginContainer/VBoxContainer/vida.value = health

func _physics_process(delta: float) -> void:
	if not alive:
		return

	if health <= 0:
		die()
		return

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	velocity = input_vector * SPEED
	move_and_slide()

	# 🔹 Só troca a animação se não estiver atirando
	if not shooting:
		if input_vector == Vector2.ZERO:
			if $AnimatedSprite2D.animation != "idle_gun":
				$AnimatedSprite2D.play("idle_gun")
		else:
			if $AnimatedSprite2D.animation != "walk_gun":
				$AnimatedSprite2D.play("walk_gun")

	# Rotaciona o player em direção ao mouse
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	rotation = direction.angle() + deg_to_rad(90)

	# Disparo
	if Input.is_action_just_pressed("shoot") and bullet_scene and alive:
		shoot()

func shoot() -> void:
	shooting = true
	$fire.emitting = true
	$AnimatedSprite2D.play("shot")

	var bullet = bullet_scene.instantiate()
	var muzzle = $GunMuzzle
	bullet.global_position = muzzle.global_position
	bullet.global_rotation = muzzle.global_rotation + deg_to_rad(90)
	get_tree().current_scene.add_child(bullet)

	# Espera a animação de tiro terminar e volta ao movimento normal
	await $AnimatedSprite2D.animation_finished
	shooting = false

func die() -> void:
	if not alive:
		return
	alive = false
	print("player morreu!")

	$AnimatedSprite2D.play("death")
	velocity = Vector2.ZERO
	await $AnimatedSprite2D.animation_finished
	get_tree().change_scene_to_file("res://Menu/game_over.tscn")

func take_damage(damage: int) -> void:
	if not alive:
		return
	health -= damage
	$CanvasLayer/MarginContainer/VBoxContainer/vida.value = health
	if health <= 0:
		die()
