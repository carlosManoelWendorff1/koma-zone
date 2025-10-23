extends CharacterBody2D

const SPEED = 100.0
const ROTATION_SPEED = 5.0  # quanto maior, mais rápido ele gira

@export var player: Node2D
@export var health: int = 100
@export var dead_scene: PackedScene
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var alive: bool = true
var attacking: bool = false

func _ready() -> void:
	if player:
		nav_agent.target_position = player.global_position

func _physics_process(delta: float) -> void:
	if not player or not alive:
		return

	if health <= 0:
		die()
		return

	# Atualiza o destino do nav agent
	nav_agent.target_position = player.global_position

	if not attacking:
		if nav_agent.is_navigation_finished():
			velocity = Vector2.ZERO
			if $AnimatedSprite2D.animation != "idle":
				$AnimatedSprite2D.play("idle")
		else:
			var next_path_point = nav_agent.get_next_path_position()
			var direction = (next_path_point - global_position).normalized()
			velocity = direction * SPEED
			move_and_slide()

			if $AnimatedSprite2D.animation != "walk":
				$AnimatedSprite2D.play("walk")

	# 🔹 Rotação suave em direção ao player
	rotate_towards_player(delta)

func rotate_towards_player(delta: float) -> void:
	var to_player = (player.global_position - global_position).angle()
	var angle_diff = wrapf(to_player - rotation - 90, -PI, PI)
	rotation += angle_diff * ROTATION_SPEED * delta

func die() -> void:
	if not alive:
		return
	alive = false
	print("zombie morreu!")
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("death")
	
# 🔹 Disable attack hitbox
	$Hitbox/CollisionShape2D.disabled = true
	
	# 🔹 Disable main collision to remove body collisions
	$CollisionShape2D.disabled = true
	
	await $AnimatedSprite2D.animation_finished
	$Timer.start()	
	await $Timer.timeout

	if dead_scene:
		var dead = dead_scene.instantiate()
		dead.global_position = global_position
		get_parent().add_child(dead)

	queue_free()


func take_damage(damage: int) -> void:
	if not alive:
		return

	health -= damage

	if health <= 0:
		die()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if not alive or attacking:
		return
	if body.name == "player": 
		print("Zumbi atacou!")	
		attacking = true
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("attack")

		await $AnimatedSprite2D.animation_finished
		attacking = false
