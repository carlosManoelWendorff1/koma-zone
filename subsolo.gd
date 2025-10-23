extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if $secondElevator.isBeingCalled:
		$EnemySpawner.enemy_count = 1
		$EnemySpawner2.enemy_count = 1

	else :
		$EnemySpawner.enemy_count = 0
		$EnemySpawner2.enemy_count = 0

	pass
