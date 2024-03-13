extends Node2D

# beatmap wave
onready var dollNodes = [$Foreground/Dolls/DollShow/D1, $Foreground/Dolls/DollShow/D2, $Foreground/Dolls/DollShow/D3, $Foreground/Dolls/DollShow/D4]
var computerTurn
var step = 0
var spaceLock = false

signal beatHit(score)
# hit timing
var momentIndiTouchesDollMS

func _ready():
	SoundManager.stop("sunMenuMusic")
	$Orchestra.start_play(5, $Beatmap.getbpm())
	
func _unhandled_input(event):
	if !$Orchestra.playing:
		return
	
	if !event.is_echo() and event.scancode == KEY_SPACE and !spaceLock:
		if computerTurn == 1 and $Beatmap.dolls[step] == 1:
			emit_signal("beatHit", -1)
			self.spaceLock = true
		elif computerTurn == 0 and $Beatmap.dolls[step] == 1:
			self.spaceLock = true
			var MsSinceAppearance = Time.get_ticks_msec() - momentIndiTouchesDollMS
			var LifetimeMs = $Orchestra.secsperbeat * 1000
			var Timing = (MsSinceAppearance / LifetimeMs) * 100
			
			if Timing > 85:
				emit_signal("beatHit", 50)
			elif Timing > 65:
				emit_signal("beatHit",100)
			elif Timing > 20:
				emit_signal("beatHit", 300)
			elif Timing > 15:
				emit_signal("beatHit", 100)
			else:
				emit_signal("beatHit", 50)
			
			dollNodes[step].visible = false
	
# conductor
func _on_Orchestra_nextbeat(pos):
	self.step = pos
	self.spaceLock = false
	
	if computerTurn == 1:
		if $Beatmap.dolls[step] == 1:
			dollNodes[step].visible = true
	else:
		momentIndiTouchesDollMS = Time.get_ticks_msec()
		if self.step > 0 and dollNodes[step - 1].visible:
			dollNodes[step - 1].visible = false
			emit_signal("beatHit", -1)

func _on_Orchestra_nextwave(turn):
	self.computerTurn = turn
	
	if computerTurn == 1:
		if dollNodes[3].visible:
			dollNodes[3].visible = false
			emit_signal("beatHit", -1)
		
		$Beatmap.nextLine()
		for i in 4:
			dollNodes[i].visible = false
	pass # Replace with function body.

func _on_Orchestra_nowstart():
	pass # Replace with function body.

# beatmap file
func _on_Beatmap_eof():
	
	pass # Replace with function body.
