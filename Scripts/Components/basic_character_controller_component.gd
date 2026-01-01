extends CharacterBody2D

@export_group("Movement")
@export var MOVE_SPEED = 300.0
@export var MOVE_ACCELERATION = 20

@export_group("Jumping")
@export var JUMP_HEIGHT = 100
@export var JUMPING_GRAVITY_INTENSITY = 0.5
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var was_on_floor:bool = false
var previous_y_vel:float = 0.0

var moveInput = 0.0
var jumpInput:bool = false

var flipped_direction = false


func _physics_process(delta: float) -> void:
	var on_floor = is_on_floor()
	# Add the gravity.
	if not is_on_floor():
		if(jumpInput and velocity.y<0):
			velocity += get_gravity() * delta * JUMPING_GRAVITY_INTENSITY
		else:
			velocity += get_gravity() * delta

	
	# Handle jump.
	if jumpInput and on_floor:
		if sprite_2d.animation != "jump":
			sprite_2d.play("jump")
		elif(sprite_2d.frame == 2):
			velocity.y = -sqrt(2*get_gravity().length()*JUMP_HEIGHT*JUMPING_GRAVITY_INTENSITY)

	if(!on_floor && !was_on_floor && velocity.y > 0 && sprite_2d.animation == "jump"):
		sprite_2d.play("falling")
	elif(!was_on_floor && on_floor):
		if( abs(previous_y_vel) > 70):
			sprite_2d.play("landing")
		else:
			sprite_2d.play("idle")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	if moveInput:
		velocity.x = move_toward(velocity.x,moveInput*MOVE_SPEED,MOVE_ACCELERATION)
		sprite_2d.flip_h = velocity.x<0
		flipped_direction = sprite_2d.flip_h
		if(!jumpInput && (sprite_2d.animation == "landing" && sprite_2d.frame == 1) or sprite_2d.animation == "idle"):
			
			sprite_2d.play("walk")
	else:
		if(!jumpInput && (sprite_2d.animation == "landing" && sprite_2d.frame == 1) or sprite_2d.animation == "walk"):
			sprite_2d.play("idle")
		velocity.x = move_toward(velocity.x, 0, MOVE_ACCELERATION)
		
	was_on_floor = on_floor
	previous_y_vel = velocity.y

	move_and_slide()
