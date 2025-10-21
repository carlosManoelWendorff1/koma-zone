extends CharacterBody2D

const SPEED = 100.0  # ajusta conforme o tamanho do mapa e velocidade desejada

@export var player: Node2D  # referência ao Player
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	# Define o destino inicial do zumbi como a posição atual do player
	if player:
		nav_agent.target_position = player.global_position

func _physics_process(delta: float) -> void:
	if not player:
		return
	
	# Atualiza o destino do zumbi (segue o player em tempo real)
	nav_agent.target_position = player.global_position
	
	# Se o agente já chegou ao destino, não precisa mover
	if nav_agent.is_navigation_finished():
		velocity = Vector2.ZERO
	else:
		# Pega a próxima posição no caminho gerado
		var next_path_point = nav_agent.get_next_path_position()
		
		# Calcula direção em relação à posição atual
		var direction = (next_path_point - global_position).normalized()
		
		# Move o zumbi nessa direção
		velocity = direction * SPEED
		move_and_slide()
