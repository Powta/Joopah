extends Node2D

signal level_cleared
signal player_died

@export var level_name:String
# Called when the node enters the scene tree for the first time.
func _ready():
	$Joopah.connect("player_entered_door",_on_player_cleared)
	$Joopah.connect("player_death",_on_player_death)
	$Key.connect("key_collected",$Joopah._on_key_collected)
	$Key.connect("key_collected",$Door._on_key_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level_name=="title":
		if Input.is_action_just_pressed("ui_accept"):
			_on_player_cleared()

func _on_player_cleared():
	emit_signal("level_cleared",level_name)
	
func _on_player_death():
	emit_signal("player_died",level_name)
	
