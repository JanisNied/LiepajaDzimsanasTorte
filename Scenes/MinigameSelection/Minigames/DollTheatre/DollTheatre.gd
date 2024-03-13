extends Node2D

var computerTurn
var step = 0
var spaceLock = false

onready var dollNodes = [$Foreground/Dolls/DollShow/D1, $Foreground/Dolls/DollShow/D2, $Foreground/Dolls/DollShow/D3, $Foreground/Dolls/DollShow/D4]

func _ready():
	SoundManager.stop("sunMenuMusic")
	$Orchestra.start_play(5, $Beatmap.getbpm())
	
func _unhandled_input(event):
	if !$Orchestra.playing:
		return
	
	if !event.is_echo() and event.scancode == KEY_SPACE and !spaceLock:
		if computerTurn == 1 and $Beatmap.dolls[step] == 1:
			print("Miss!")
			self.spaceLock = true
	
	pass
	
# conductor
func _on_Orchestra_nextbeat(pos):
	self.step = pos
	self.spaceLock = false
	
	if computerTurn == 1:
		if $Beatmap.dolls[step] == 1:
			dollNodes[step].visible = true
	
	#print(pos)
	pass # Replace with function body.

func _on_Orchestra_nextwave(turn):
	$Beatmap.nextLine()
	self.computerTurn = turn
	
	if computerTurn == 1:
		for i in 4:
			dollNodes[i].visible = false
	pass # Replace with function body.

func _on_Orchestra_nowstart():
	pass # Replace with function body.

# beatmap file
func _on_Beatmap_eof():
	
	pass # Replace with function body.
