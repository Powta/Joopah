extends Area2D

signal key_collected
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(_body):
	emit_signal("key_collected")
	$AnimationPlayer.play("explosion")
	
func key_collect():
	queue_free()
