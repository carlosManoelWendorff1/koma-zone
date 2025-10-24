extends AnimationPlayer

@onready var elevatorAnimation = $AnimatedSprite2D

func _ready():
	elevatorAnimation.play("default")
