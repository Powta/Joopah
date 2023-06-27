extends Node2D

signal level_cleared

@export var level_name:String
# Called when the node enters the scene tree for the first time.
func _ready():
	$Joopah.connect("player_entered_door",_on_player_cleared)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_cleared():
	print("player cleared")
	emit_signal("level_cleared",level_name)
