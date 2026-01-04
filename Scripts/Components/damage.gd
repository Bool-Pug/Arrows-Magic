extends Node
@export var damage:int = 20
@export var node_to_destroy_on_collision:Node = null


func _on_physics_body_2d_body_entered(body: Node) -> void:
	var health = body.find_child("Health")
	print(body.name)
	if(health):
		health.take_damage(damage)
	if(node_to_destroy_on_collision):
		node_to_destroy_on_collision.queue_free()
	pass # Replace with function body.
