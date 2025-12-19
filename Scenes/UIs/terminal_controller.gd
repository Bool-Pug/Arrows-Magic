extends Control

@onready var line_edit: LineEdit = $Padding/LineEdit
@onready var player: Node2D = $"../../Player"
var terminal_open:bool = false

@export var magic_resources:Array[magic_generic] 
@export var failed_spell:spell_generic
@onready var cast_delay_timer: Timer = $CastDelayTimer

@export var magic_queue:Array[magic_generic] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!terminal_open and Input.is_action_just_pressed("Terminal_Open")):
		player.input_paused = true
		line_edit.show()
		line_edit.grab_focus()
		terminal_open = true
	
		
	pass


func _on_terminal_text_submitted(new_text: String) -> void:
	parse_to_magic_queue(new_text)
	line_edit.clear()
	line_edit.hide()
	player.input_paused = false
	terminal_open = false
	
	cast_next_in_queue()
	pass # Replace with function body.
	
func parse_to_magic_queue(text: String):
	var words:PackedStringArray = text.split(" ",true)
	var found_match:bool = false
	for word in words:
		found_match = false
		for magic in magic_resources:
			if(word == magic.trigger_word):
				magic_queue.append(magic)
				found_match = true
				break
		if(!found_match):
			magic_queue.append(failed_spell)
	print(words)
	
func cast_next_in_queue():
	if(magic_queue.size() == 0):
		return
	
	match magic_queue[0].magic_type:
		magic_generic.Type.SPELL:
			cast_delay_timer.start(magic_queue[0].cast_delay / 1000)
			print(magic_queue[0].cast_delay)
			magic_queue.remove_at(0)
		magic_generic.Type.MODIFIER:
			pass
		magic_generic.Type.GENERIC:
			printerr("magic_queue[0] is of GENERIC type, which should not be used")
		_:
			printerr("Item 0 in magic_queue is not a handled type, it is type: " + magic_queue[0].get_class())
	pass

func cast_spell(spell:spell_generic):
	print("Delaying: " + str(spell.cast_delay))


func _on_cast_delay_timer_timeout() -> void:
	cast_next_in_queue()
