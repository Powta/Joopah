extends CharacterBody2D


@export var speed:float
@export var is_dead:bool

var jump_velocity=-400
var can_open_door=false
var is_door_locked=true

var previous_direction=1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal player_entered_door
signal player_death

var minX=-15
var maxX=651
var maxSpawnX=650
var minSpawnX=-14

var minY=-11 #this is actuall up because godot is weird
var maxY=381
var maxSpawnY=376
var minSpawnY=-10

func _ready():
	pass
	
func _physics_process(delta):
	if is_dead==false:
		movement(delta)
		move_and_slide()
	else:
		velocity.x=0
		velocity.y=0
		
func movement(_delta):
		#Walking off-Screen Logic
	if position.x<=-15:
		position.x=650
	if position.x>651:
		position.x=-14
	
	if position.y>=381:
		position.y=-10
	if position.y<=-11:
		position.y=376
	
	#door logic	
	if Input.is_action_just_pressed("ui_up"):
		if can_open_door==true:
			if is_door_locked==false:
				emit_signal("player_entered_door")
			else:
				pass
				
	var direction = Input.get_axis("ui_left", "ui_right")
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * _delta
		
		if velocity.y>0:
			$AnimationPlayer.play("Fall")
		else:
			$AnimationPlayer.play("Jump")
			
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		$JumpPressedRemember.start()
	if is_on_floor():
		
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
	
	velocity.y = clamp(velocity.y , -450, 900)
	
func _on_key_collected():
	is_door_locked=false

func death():
	is_dead=true
	$AnimationPlayer.play("Death")
	
func death_signal():
	emit_signal("player_death")


	
