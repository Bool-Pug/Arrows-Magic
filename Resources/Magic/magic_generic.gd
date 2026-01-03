class_name magic_generic
extends Resource

@export var mana_cost: int = 10
@export var cast_delay: int = 300
@export var trigger_word = "1234567asdf"
@export var additional_casts := 0 

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init():
	pass
