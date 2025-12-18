extends Control

@onready var line_edit: LineEdit = $Padding/LineEdit
@onready var player: Node2D = $"../../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Terminal_Open")):
		player.input_paused = true
		line_edit.show()
		line_edit.grab_focus()
	
	pass


func _on_terminal_text_submitted(new_text: String) -> void:
	parse_as_spell(new_text)
	line_edit.clear()
	line_edit.hide()
	player.input_paused = false


	
	pass # Replace with function body.
	
func parse_as_spell(text: String):
	print(text)
