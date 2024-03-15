extends Node

var Score = 0
var playertolookoutfor

# Called when the node enters the scene tree for the first time.
func _ready():
	playertolookoutfor = get_parent().find_node("Player")
	pass # Replace with function body.

func increment():
	Score += 1
	if !playertolookoutfor.wasHit:
		Score += 1	

func _on_Inferface_gameover():
	Score = -1
