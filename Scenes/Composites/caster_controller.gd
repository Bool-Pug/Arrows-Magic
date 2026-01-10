extends Node2D


@export var magic_resources:Array[magic_generic] 
@export var failed_spell:spell_generic
@onready var cast_delay_timer: Timer = $CastDelayTimer

@export var magic_queue:Array[magic_group] = []
var direction:int = 1

func _ready() -> void:
	if magic_queue.size() > 0:
		cast_next_in_queue()
		queue_free()

func parse_to_magic_queue(text: String):

	var words:PackedStringArray = text.split(" ",true)
	var found_match:bool = false
	var ungrouped_magic_queue:Array[magic_generic] = []
	for word in words:
		found_match = false
		for magic in magic_resources:
			if(word == magic.trigger_word):
				ungrouped_magic_queue.append(magic.duplicate())
				found_match = true
				break
		if(!found_match):
			ungrouped_magic_queue.append(failed_spell)
	#print(words)
	var iterations:=0
	while (ungrouped_magic_queue.size()>0 and iterations < 100):
		iterations += 1
		
		var new_group := create_first_group_in_queue(ungrouped_magic_queue)
		magic_queue.append(new_group)
		
		if(new_group.num_magics >= ungrouped_magic_queue.size()): break
		for i in range(new_group.num_magics):
			ungrouped_magic_queue.remove_at(0)
		
	
func create_first_group_in_queue(queue:Array[magic_generic]) -> magic_group:
	var additional_casts := 1
	var temp_queue: Array[magic_generic] = []
	var num_magics = 0
	while queue.size() > 0:
		var magic := queue[0]
		if magic is trigger_spell_generic:
			magic.trigger_group = create_first_group_in_queue(queue.slice(1,queue.size()))
			for i in range(magic.trigger_group.num_magics,0,-1):
				queue.remove_at(i)
				num_magics += 1
				
		additional_casts += magic.additional_casts
		num_magics += 1

		additional_casts -= 1
		temp_queue.append(magic)
		if(additional_casts <= 0):
			break
		queue.remove_at(0)
	return magic_group.new(temp_queue,num_magics)
	
	
	
func cast_next_in_queue():
	if(magic_queue.size() == 0):
		return
	
	cast_delay_timer.start(magic_queue[0].cast_delay / 1000.)
	#print(get_parent().name,magic_queue[0].to_string())
	
	cast_magic_group(magic_queue[0])
	magic_queue.remove_at(0)
	

func cast_magic_group(group:magic_group):
	var group_parent = Node2D.new()
	for spell in group.spells:
		cast_spell(spell,group_parent)
	get_tree().root.add_child(group_parent)
	

func cast_spell(spell:spell_generic,group_parent:Node2D):
	
	var manifestation:Node2D = spell.manifestation.instantiate()
	group_parent.add_child(manifestation)
	var flip_vector := Vector2(1,1)
	


	
	if(direction < 0):
		flip_vector = Vector2(-1,1)
		manifestation.apply_scale(flip_vector)
		spell.speed *= -1
	
	if(manifestation is projectile_controller):
		manifestation.spell_base = spell
	
	manifestation.global_position = global_position
	

func _on_cast_delay_timer_timeout() -> void:
	cast_next_in_queue()
