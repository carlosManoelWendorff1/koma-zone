extends StaticBody2D

@onready var light := $PointLight2D

var timer := 0.0
var blink_interval := randf_range(4, 5.5)
var target_energy := 2.0

func _process(delta: float) -> void:
	timer += delta
	
	# De tempos em tempos escolhe um novo valor de intensidade
	if timer > blink_interval:
		timer = 0.0
		blink_interval = randf_range(0.1, 1.5) # intervalo aleatório entre piscadas
		target_energy = randf_range(0.2, 1.5)  # nova intensidade alvo
		
		# Às vezes faz um "blink" forte (piscada rápida)
		if randf() < 0.2:
			target_energy = 0.0  # piscar apagando rápido
	
	# Suaviza a transição entre valores de energia
	light.energy = lerp(light.energy, target_energy, delta * 5.0)
