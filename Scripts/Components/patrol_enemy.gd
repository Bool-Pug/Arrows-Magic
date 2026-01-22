extends Node2D
@onready var basic_character_controller_component: CharacterBody2D = $BasicCharacterControllerComponent
@onready var ray_cast_2d: RayCast2D = $BasicCharacterControllerComponent/RayCast2D

@export var move_input := 1.0
@export var ray_was_blocked := false

func _process(delta: float) -> void:
	var ray_blocked = ray_cast_2d.is_colliding()
	if(!ray_blocked and ray_was_blocked):
		move_input*= -1
	basic_character_controller_component.moveInput = move_input
	
	ray_was_blocked = ray_blocked
	
	
