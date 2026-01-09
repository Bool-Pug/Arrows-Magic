class_name projectile_controller
extends Node2D
@onready var projectile_body: CharacterBody2D = $ProjectileBody
@onready var damage: Node = $ProjectileBody/Damage
var spell_base:spell_generic

@export var trigger_group:magic_group = null
var caster_scene:PackedScene = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(spell_base):
		initialize_from_spell(spell_base)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _exit_tree() -> void:
	if(caster_scene && trigger_group):
		var caster_node:Node2D= caster_scene.instantiate() 
		caster_node.global_position = projectile_body.global_position
		caster_node.direction = -1 * sign(projectile_body.velocity.x)
		caster_node.magic_queue.append(trigger_group)
		get_parent().add_child.call_deferred(caster_node)
	
func initialize_from_spell(spell:spell_generic):
	print(name)
	projectile_body.velocity.x = spell.speed
	projectile_body.gravity_intensity = spell.gravity_intensity
	damage.damage = spell.damage
	damage.node_to_destroy_on_collision = self
	if(spell is trigger_spell_generic):
		trigger_group = spell.trigger_group
		caster_scene = spell.caster_scene
