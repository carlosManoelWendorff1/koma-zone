extends Sprite2D
var velocidade := 250.0
var direcao := Vector2.ZERO

func _ready() -> void:
	# Assume que a rotação já foi ajustada ao instanciar a bala
	# e define a direção com base nessa rotação
	direcao = Vector2.RIGHT.rotated(rotation)

func _process(delta: float) -> void:
	position += direcao * velocidade * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
