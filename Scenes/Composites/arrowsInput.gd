extends Node

enum Arrows {UP, DOWN, LEFT, RIGHT}
@export var current_combo = []
@export var count = 0

@export var projectileSpellScene = preload("res://Scenes/Composites/projectileSpell.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("Arrow_Mode")):
		if(Input.is_action_just_pressed("Arrow_Up")):
			current_combo.append(Arrows.UP)
		elif (Input.is_action_just_pressed("Arrow_Down")):
			current_combo.append(Arrows.DOWN)
		elif (Input.is_action_just_pressed("Arrow_Left")):
			current_combo.append(Arrows.LEFT)
		elif (Input.is_action_just_pressed("Arrow_Right")):
			current_combo.append(Arrows.RIGHT)
	if(Input.is_action_just_released("Arrow_Mode")):
		cast_current_combo()
		current_combo = []
	
	pass


func cast_current_combo():
	print(current_combo)
	
	if(current_combo.size() == 0): return
	
	if(current_combo.get(0)==Arrows.UP):
		get_parent().add_child(projectileSpellScene.instantiate())
	
	
