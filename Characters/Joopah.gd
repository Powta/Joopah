extends CharacterBody2D


@export var speed:float
#@export var jump_velocity:float 
var jump_velocity=-400
var can_open_door=false
var is_door_locked=true

var previous_direction=1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal player_entered_door
signal player_death

func _ready():
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if can_open_door==true:
			if is_door_locked==false:
				emit_signal("player_entered_door")
			else:
				pass
				
	var direction = Input.get_axis("ui_left", "ui_right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y>0:
			$AnimationPlayer.play("Fall")
		else:
			$AnimationPlayer.play("Jump")
			
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		$JumpPressedRemember.start()
	if is_on_floor():
		#velocity.y=0
		
		#check if the player pressed the button within the last 0.2 secs	
		if $JumpPressedRemember.time_left>0:
			$JumpPressedRemember.stop()
			velocity.y =jump_velocity
			
	#If you release the jump button early	
	else:
		if Input.is_action_just_released("ui_accept"):
			#if the charcater is jumping
			if velocity.y<jump_velocity/2:
				velocity.y =jump_velocity/2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if abs(direction)>0:
		previous_direction=direction
		if velocity.y==0:
			$AnimationPlayer.play("Running")	
		velocity.x = direction * speed
	else:
		if velocity.y==0:
			$AnimationPlayer.play("Idle")
		velocity.x =0
		
	if previous_direction>0:
		$Joop.flip_h=false
	else:
		$Joop.flip_h=true
		
	move_and_slide()
	
func _on_key_collected():
	is_door_locked=false

func death():
	emit_signal("player_death")


	
