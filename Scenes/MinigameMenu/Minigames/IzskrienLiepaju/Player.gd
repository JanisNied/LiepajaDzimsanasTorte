extends KinematicBody2D


const max_speed = 150
const accel =  500
const friction = 1000
var velocity = Vector2()
var input = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	_player_movement(delta)

func _get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()

func _player_movement(delta):
	input = _get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO	
	else:
		velocity += (input * accel * delta) 
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide(velocity)
