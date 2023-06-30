extends CharacterBody2D


var speed:float = 70.0
@export var direction:float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ledgeCheckRight=$LedgeCheckRight
@onready var ledgeCheckLeft=$LedgeCheckLeft

func _physics_process(delta):
	var foundLedge=not ledgeCheckLeft.is_colliding() or not ledgeCheckRight.is_colliding()
	
	if is_on_wall() or foundLedge:
		direction*=-1
	velocity.x=speed * direction
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.get_collision_layer()==1:
		body.death()
