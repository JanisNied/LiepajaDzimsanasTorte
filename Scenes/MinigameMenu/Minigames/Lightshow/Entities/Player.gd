extends Node2D

var lock = true

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if lock:
		return
	
	var vel = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		vel.y -= 1
	if Input.is_action_pressed("left"):
		vel.x -= 1
	if Input.is_action_pressed("right"):
		vel.x += 1
	if Input.is_action_pressed("down"):
		vel.y += 1
	
	if Input.is_action_pressed("shift"):
		vel /= 2
	
	position += vel * 200 * delta
	
	position.x = clamp(position.x, 0, 576)
	position.y = clamp(position.y, 0, 576)

func _on_Inferface_gamestart():
	lock = false
	pass
