class_name magic_group
extends magic_generic

@export var spells:Array[spell_generic] = []
@export var modifiers:Array[modifier_generic] = []

var num_magics:int = 0


func _init(magic_queue:Array[magic_generic] = []):
	cast_delay = 0
	for magic in magic_queue:
		cast_delay += magic.cast_delay
		match magic:
			_ when magic is spell_generic:
				spells.append(magic)
			_ when magic is modifier_generic:
				modifiers.append(magic)
			_:
				printerr("magic of this type is not handled")
	num_magics = magic_queue.size()

func _to_string() -> String:
	var string := "Magic Group with Spells: "
	for spell in spells:
		string += spell.trigger_word + " "
	string += "Modifiers: "
	for modifier in modifiers:
		string += modifier.trigger_word + " "
	return string
	
	
	
	
