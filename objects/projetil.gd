extends Sprite2D

@export var velocidade_inicial: float = 900.0     # 🔹 Velocidade de início
@export var velocidade_maxima: float = 2500.0      # 🔹 Limite máximo de velocidade
@export var aceleracao: float = 800.0             # 🔹 Aceleração (px/s²)
@export var lifetime: float = 3.0                 # 🔹 Tempo de vida em segundos

var velocidade_atual: float
var direcao: Vector2 = Vector2.ZERO

func _ready() -> void:
	direcao = Vector2.RIGHT.rotated(rotation)
	velocidade_atual = velocidade_inicial
	# Se quiser destruir automaticamente após um tempo
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta: float) -> void:
	# 🔹 Aumenta a velocidade até o máximo
	velocidade_atual = min(velocidade_atual + aceleracao * delta, velocidade_maxima)

	# 🔹 Move o projétil
	position -= direcao * velocidade_atual * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hitbox_area_entered(_area: Area2D) -> void:
	queue_free()
