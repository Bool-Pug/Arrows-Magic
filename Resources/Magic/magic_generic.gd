class_name magic_generic
extends Resource

@export var mana_cost: int = 10
@export var cast_delay: int = 300
@export var trigger_word = "1234567asdf"
enum Type {
	SPELL,
	GENERIC,
	MODIFIER
}

var magic_type:Type
# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(default_mana_cost = 10, default_cast_delay = 300,default_type = Type.GENERIC):
	mana_cost = default_mana_cost
	cast_delay = default_cast_delay
	magic_type = default_type
