extends Control

# enemy stages
var bosses
var bossidx = 0
var stop = true

signal gamestart
signal gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	SoundManager.stop("sunMenuMusic")
	bosses = [$Playground/RIngPath/PathFollow2D]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (stop):
		return
		
	if $Playground/Player.hp < 0:
		#emit_signal("gameover")
		stop = true
		Spawning.clear_all_bullets()
		bosses[bossidx].find_node("RingEnemy").visible = false
		$Playground/Player.lock = true
		$Playground/Fighters/Label.text = "Švaki...\n%d" % $Scoring.Score
		$Playground/Fighters.visible = true
		SoundManager.stop("bulletHellMusic")
		return
		
	var currenemy
	if bossidx == 0:
		currenemy = bosses[bossidx].find_node("RingEnemy")
		
		if bosses[bossidx].offset > 178.0 and bosses[bossidx].offset < 183.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 560.0 and bosses[bossidx].offset < 563.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 700.0 and bosses[bossidx].offset < 705.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 750.0 and bosses[bossidx].offset < 755.0:
			currenemy.spawnRings()
			
		if bosses[bossidx].offset > 800.0 and bosses[bossidx].offset < 805.0:
			currenemy.spawnRings()
			
		if bosses[bossidx].offset > 850.0 and bosses[bossidx].offset < 855.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 920.0 and bosses[bossidx].offset < 925.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 975.0 and bosses[bossidx].offset < 980.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 990.0 and bosses[bossidx].offset < 1000.0:
			currenemy.spawnRings()
		
		bosses[bossidx].offset += 200 * delta
	
	$HUD/Cover/Time.text = "Laiks: %d\nAplis: %d/%d\nSpēks: %d\nPunkti: %d" % [(int($Chronometer.time_left) + 1), bossidx + 1,  bosses.size(), $Playground/Player.hp, $Scoring.Score]


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
	
	$Scoring.increment()
	if bossidx + 1 < bosses.size():
		bossidx += 1
		$Playground/Fighters.visible = true
	else:
		$Playground/Fighters/Label.text = "Visus\npieveici!\nNopelns: %d" % $Scoring.Score
		$Playground/Fighters.visible = true

