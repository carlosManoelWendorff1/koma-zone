class_name Hitbox
extends Area2D

@export var damage: int = 1

func set_damage(value: int):
	damage = value

func get_damage():
	return damage
