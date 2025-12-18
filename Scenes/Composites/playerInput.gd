extends Node2D

@onready var basic_character_controller_component: CharacterBody2D = $BasicCharacterControllerComponent
@onready var camera_2d: Camera2D = $Camera2D
var input_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(input_paused):
		basic_character_controller_component.jumpInput = false
		basic_character_controller_component.moveInput = 0
	else:
		basic_character_controller_component.jumpInput = Input.get_action_strength("jump") == 1
		basic_character_controller_component.moveInput = Input.get_axis("move_left","move_right")
	
	
	
	camera_2d.global_position = basic_character_controller_component.global_position
	pass
