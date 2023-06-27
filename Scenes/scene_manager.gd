extends Node2D

@onready var current_level=$Level_Test

# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.connect("level_cleared",_on_level_cleared)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_cleared(current_level_name:String):
	print(current_level_name)
