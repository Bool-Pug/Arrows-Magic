extends Control

@onready var line_edit: LineEdit = $Padding/LineEdit
@onready var player: Node2D = $"../../Player"
var terminal_open:bool = false
@onready var player_caster: Node2D = $"../../Player/BasicCharacterControllerComponent/Caster"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(!terminal_open and Input.is_action_just_pressed("Terminal_Open")):
		player.input_paused = true
		Engine.time_scale = 0.25
		line_edit.show()
		line_edit.grab_focus()
		terminal_open = true
	
		
	pass


func _on_terminal_text_submitted(new_text: String) -> void:
	player_caster.magic_queue.clear()
	player_caster.parse_to_magic_queue(new_text)
	line_edit.clear()
	line_edit.hide()
	player.input_paused = false
	Engine.time_scale = 1.
	terminal_open = false
	
	player_caster.cast_next_in_queue()
	pass # Replace with function body.
	
