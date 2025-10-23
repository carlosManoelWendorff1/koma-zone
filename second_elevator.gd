extends Node2D

@export var arrived = false
@export var isBeingCalled = false

func _ready() -> void:
	# Define o tempo do timer para 60 segundos
	$Timer.wait_time = 60
	$Timer.one_shot = true
	$Label.text = "Elevador chegará em 60s"

func _process(delta: float) -> void:
	# Mostra o tempo restante arredondado para inteiro
	if isBeingCalled and not arrived:
		$Label.text = "Elevador chegará em " + str(int(ceil($Timer.time_left))) + "s"
	elif arrived:
		$Label.text = "Elevador chegou!"
	else:
		$Label.text = ""

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if not isBeingCalled and not arrived:
			isBeingCalled = true
			$Timer.start()
		elif arrived:
			print("go to final")

func _on_timer_timeout() -> void:
	isBeingCalled = false
	arrived = true
