extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button3_mouse_entered():
	$Arrow.modulate = Color(0.59, 0.14, 0.96)
	pass # Replace with function body.


func _on_Button3_mouse_exited():
	$Arrow.modulate = Color(1.0, 1.0, 1.0)
	pass # Replace with function body.


func _on_Button3_button_up():
	$AnimationPlayer.play("GoOut")
	pass # Replace with function body.
