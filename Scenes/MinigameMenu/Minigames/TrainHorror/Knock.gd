extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var knocking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and knocking:
		if event.button_index == BUTTON_LEFT and event.pressed:
			$Sound.play()
			print("knocking")
		


func _on_Area_body_entered(body):
	knocking = true
	print("Knock! True")
	pass # Replace with function body.


func _on_Area_body_exited(body):
	knocking = false
	print("Knock! False")
	pass # Replace with function body.
