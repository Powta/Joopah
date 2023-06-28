extends Node2D

@onready var current_level=$Level_Title

# Called when the node enters the scene tree for the first time.
func _ready():
	current_level.connect("level_cleared",_on_level_cleared)
	current_level.connect("player_died",_on_player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_cleared(current_level_name:String):
	var next_level #the actual scene we're gonna instance
	var next_level_name:String
	#match is the same as switch statement
	#maybe you wanna do an enum or a consistent naming pattern or something
	match current_level_name:
		"test":
			next_level_name="1"
		"title":
			next_level_name="1"
		"1":
			next_level_name="2"
		"2":
			return
		_:#This is error
			return
	next_level=load("res://Scenes/level_"+next_level_name+".tscn").instantiate() #in godot 4, to get instance of a scene, you use instantiate function
	
	add_child(next_level)#adds the new level to the scene switcher node
	
	#removes the previous level on the scene and replace it with the new level
	current_level.queue_free() 
	current_level=next_level
	current_level.connect("level_cleared",_on_level_cleared)
	current_level.connect("player_died",_on_player_died)

func _on_player_died(current_level_name:String):
	var level=load("res://Scenes/level_"+current_level_name+".tscn").instantiate()
	print(current_level_name)
	add_child(level)
	current_level.queue_free() 
	current_level=level
	current_level.connect("level_cleared",_on_level_cleared)
	current_level.connect("player_died",_on_player_died)	
	
