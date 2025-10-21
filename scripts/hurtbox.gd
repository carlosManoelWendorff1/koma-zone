class_name HurtBox
extends Area2D

signal recive_damage(damage: int)

func _on_area_entered(hitbox: Hitbox) -> void:
	print("entrou!", hitbox.damage)
