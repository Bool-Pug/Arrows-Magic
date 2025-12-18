extends CharacterBody2D

@export_group("Movement")
@export var MOVE_SPEED = 300.0
@export var MOVE_ACCELERATION = 20

@export_group("Jumping")
@export var JUMP_HEIGHT = 100
@export var JUMPING_GRAVITY_INTENSITY = 0.5



var moveInput = 0.0
var jumpInput:bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if(jumpInput and velocity.y<0):
			velocity += get_gravity() * delta * JUMPING_GRAVITY_INTENSITY
		else:
			velocity += get_gravity() * delta

	# Handle jump.
	if jumpInput and is_on_floor():
		velocity.y = -sqrt(2*get_gravity().length()*JUMP_HEIGHT*JUMPING_GRAVITY_INTENSITY)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	if moveInput:
		velocity.x = move_toward(velocity.x,moveInput*MOVE_SPEED,MOVE_ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_ACCELERATION)

	move_and_slide()
