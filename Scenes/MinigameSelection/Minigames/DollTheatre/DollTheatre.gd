extends Node2D

func _ready():
	SoundManager.stop("sunMenuMusic")
	$Orchestra.start_play(4, $Beatmap.getbpm())



func _on_Orchestra_nextbeat(pos):
	print(pos)
	pass # Replace with function body.


func _on_Orchestra_nextwave(turn):
	print("NEXT TURN! ", turn)
	pass # Replace with function body.
