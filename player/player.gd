extends CharacterBody2D

class_name Player

const SPEED = 300.0

@export var money = 0
@export var KillCount = 0
@export var health = 100
@export var fire_rate: float = 0.3  # 🔹 Tempo (em segundos) entre tiros

var alive: bool = true
var shooting: bool = false
var can_shoot: bool = true  # 🔹 Controla se o player pode atirar
var bullet_scene = preload("res://objects/projetil.tscn")

func _ready() -> void:
	$CanvasLayer/MarginContainer/VBoxContainer/vida.value = health

func _physics_process(_delta: float) -> void:
	if not alive:
		return

	if health <= 0:
		die()
		return

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("walk-rigth") - Input.get_action_strength("walk-left")
	input_vector.y = Input.get_action_strength("walk-back") - Input.get_action_strength("walk-forward")
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

	# 🔫 Disparo com cooldown
	if Input.is_action_pressed("shoot") and bullet_scene and alive and can_shoot:
		shoot()

func shoot() -> void:
	can_shoot = false
	shooting = true
	$fire.emitting = true
	$AnimatedSprite2D.play("shot")

	var bullet = bullet_scene.instantiate()
	var muzzle = $GunMuzzle
	bullet.global_position = muzzle.global_position
	bullet.global_rotation = muzzle.global_rotation + deg_to_rad(90)
	get_tree().current_scene.add_child(bullet)

	# 🔹 Create tracer for the bullet
	var tracer_scene = preload("res://objects/bullet_tracer.tscn")
	var tracer = tracer_scene.instantiate()
	tracer.target = bullet
	get_tree().current_scene.add_child(tracer)

	await $AnimatedSprite2D.animation_finished
	shooting = false

	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true

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
