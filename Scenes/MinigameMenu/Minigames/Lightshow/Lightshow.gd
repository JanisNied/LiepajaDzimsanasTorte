extends Control

# enemy stages
var bosses
var bossidx = 0
var stop = true

signal gamestart

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.stop("sunMenuMusic")
	bosses = [$Playground/RIngPath/PathFollow2D]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (stop):
		return
	
	var currenemy
	if bossidx == 0:
		currenemy = bosses[bossidx].find_node("RingEnemy")
		
		
		bosses[bossidx].offset += 250 * delta
	
	$HUD/Cover/Time.text = "Laiks: %d\nAplis: %d/%d\nSpēks: %d\nPunkti" % [(int($Chronometer.time_left) + 1), bossidx + 1,  bosses.size(), $Playground/Player.hp]


func _on_Timer_timeout():
	SoundManager.play_bgm("bulletHellMusic")
	
	$Playground/Fighters.visible = false
	$Playground/Fighters/bat.visible = false
	$Playground/Fighters/angel.visible = false
	
	$Playground/Player.visible = true
	bosses[bossidx].find_node("RingEnemy").visible = true
	emit_signal("gamestart")
	
	stop = false
	$Chronometer.start()

func _on_Chronometer_timeout():
	stop = true
	Spawning.clear_all_bullets()
	bosses[bossidx].find_node("RingEnemy").visible = false
	
	if bossidx + 1 < bosses.size():
		bossidx += 1
		$Playground/Fighters.visible = true
	else:
		$Playground/Fighters/Label.text = "Visus\npieveici!"
		$Playground/Fighters.visible = true
