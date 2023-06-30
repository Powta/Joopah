extends CharacterBody2D

@export var speed:float
var direction=-1

func _ready():
	$Timer.start()
	
func _physics_process(delta):
	velocity.y=speed*direction
	move_and_slide()


func _on_timer_timeout():
	direction *=-1
	$Timer.start()


func _on_area_2d_body_entered(body):
	if body.get_collision_layer()==1:
		body.death()
