class_name projectile_controller
extends Node2D
@onready var projectile_body: CharacterBody2D = $ProjectileBody
@onready var damage: Node = $ProjectileBody/Damage
var spell_base:spell_generic

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(spell_base):
		initialize_from_spell(spell_base)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func initialize_from_spell(spell:spell_generic):
	print(name)
	projectile_body.velocity.x = spell.speed
	projectile_body.gravity_intensity = spell.gravity_intensity
	damage.damage = spell.damage
	damage.node_to_destroy_on_collision = self
