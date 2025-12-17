extends Node2D

@onready var basic_character_controller_component: CharacterBody2D = $BasicCharacterControllerComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	basic_character_controller_component.jumpInput = Input.get_action_strength("jump") == 1
	basic_character_controller_component.moveInput = Input.get_axis("move_left","move_right")
	pass
