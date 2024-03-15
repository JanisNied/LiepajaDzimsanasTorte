extends Control

# enemy stages
var bosses
var bossidx = 0
var stop = true

# Called when the node enters the scene tree for the first time.
func _ready():
	bosses = [$Playground/RIngPath/PathFollow2D]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (stop):
		return
	
	var currenemy
	if bossidx == 0:
		currenemy = bosses[bossidx].find_node("RingEnemy")
		
		if !currenemy.visible:
			currenemy.visible = true
		
		if bosses[bossidx].offset < 2.5:
			currenemy.spawnV()
		
		if bosses[bossidx].offset > 1900.0 and bosses[bossidx].offset < 1910.0:
			currenemy.spawnRings()
		
		if bosses[bossidx].offset > 2100.0 and bosses[bossidx].offset < 2110.0:
			currenemy.spawnRings()
		bosses[bossidx].offset += 250 * delta	
	
	#bosses[bossidx].position.move_toward(Vector2(100, 100), delta * 100)
	pass


func _on_Timer_timeout():
	$Playground/Fighters.visible = false
	$Playground/Player.visible = true
	stop = false
	pass # Replace with function body.
