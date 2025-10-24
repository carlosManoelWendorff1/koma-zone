extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var elevator_animation:AnimatedSprite2D  = $AnimationPlayer/AnimatedSprite2D
@onready var button: Button = $Button

var animation_done := false
var sprite_done := false

func _ready():
	button.disabled = true
	animation.connect("animation_finished", Callable(self, "_on_animation_finished"))
	elevator_animation.connect("animation_finished", Callable(self, "_on_sprite_finished"))
	elevator_animation.play_backwards("default")
	print(elevator_animation.is_playing())
	animation.play_backwards("elevator")

func _on_animation_finished(anim_name: String):
	if anim_name == "elevator":
		animation_done = true
		_check_ready()

func _on_sprite_finished():
	sprite_done = true
	_check_ready()

func _check_ready():
	if animation_done and sprite_done:
		button.disabled = false
		button.text = "clique para continuar..."


func _on_button_button_down():
	Loading.load_screen_to_scene("res://loading/loading_scene.tscn")
