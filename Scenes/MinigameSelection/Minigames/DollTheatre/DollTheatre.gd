extends Node2D

var computerTurn

func _ready():
	SoundManager.stop("sunMenuMusic")
	$Orchestra.start_play(5, $Beatmap.getbpm())
	
# conductor
func _on_Orchestra_nextbeat(pos):
	#print(pos)
	pass # Replace with function body.

func _on_Orchestra_nextwave(turn):
	$Beatmap.nextLine()
	self.computerTurn = turn
	
	print($Beatmap.dolls)
	pass # Replace with function body.

func _on_Orchestra_nowstart():
	pass # Replace with function body.

# beatmap file


func _on_Beatmap_eof():
	pass # Replace with function body.
