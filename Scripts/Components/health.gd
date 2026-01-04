extends Node
@export var max_health:int = 100
@export var health:int = 50
@export var start_at_max = true
@export var destroy_parent_on_death = true
@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.max_value = max_health
	if(start_at_max):
		health = max_health
	update_health_bar()


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
func take_damage(damage:int):
	health -= damage
	if(health <= 0):
		get_parent().queue_free()
	update_health_bar()
func update_health_bar():
	progress_bar.value = health
