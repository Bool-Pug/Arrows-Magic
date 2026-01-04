extends CharacterBody2D


@export var gravity_intensity:float = 1.0
@onready var damage: Node = $Damage



func _physics_process(delta: float) -> void:
	# Add the gravity.

	velocity += get_gravity() * delta * gravity_intensity

	var collision := move_and_collide(velocity* delta)

	if(collision):
		damage._on_physics_body_2d_body_entered(collision.get_collider())

	
