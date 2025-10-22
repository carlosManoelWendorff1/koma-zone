extends CharacterBody2D

const SPEED = 100.0 

@export var player: Node2D
@export var health: int = 100
@export var dead_scene: PackedScene
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var hitbox = Hitbox
var alive: bool = true

func _ready() -> void:
	if player:
		nav_agent.target_position = player.global_position

func _physics_process(delta: float) -> void:
	if not player:
		return
	
	if health <= 0:
		die()
		return
	
	nav_agent.target_position = player.global_position
	
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		var next_path_point = nav_agent.get_next_path_position()
		
		var direction = (next_path_point - global_position).normalized()
		
		velocity = direction * SPEED
		move_and_slide()

func die() -> void:
	var dead_zombie = dead_scene.instantiate()
	
	if not alive: return
	print("zombie morreuu!")
	alive = false
	
	get_parent().add_child(dead_zombie)
	dead_zombie.global_position = global_position
	queue_free()

func take_damage(damage: int) -> void:
	health -= damage
