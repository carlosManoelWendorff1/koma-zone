class_name HurtBox
extends Area2D

#signal recive_damage(damage: int)

func _ready() -> void:
	if not is_connected("area_entered", _on_area_entered):
		connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Hitbox) -> void:
	get_parent().health -= hitbox.damage
	print(get_parent().health)
