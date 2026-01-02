class_name spell_generic
extends magic_generic

@export var damage:int = 0
@export var speed := 0.0
@export var gravity_intensity := 0.0
@export var manifestation:PackedScene = null

func _init(default_damage = 10, default_manifestation = null):
	damage = default_damage
	manifestation = default_manifestation
