extends Node
@export var damage:int = 20
@export var destroy_parent_on_collision:bool = true


func _on_physics_body_2d_body_entered(body: Node) -> void:
	var health = body.get_parent().find_child("Health")
	if(health):
		health.take_damage(damage)
	get_parent().queue_free()
	pass # Replace with function body.
