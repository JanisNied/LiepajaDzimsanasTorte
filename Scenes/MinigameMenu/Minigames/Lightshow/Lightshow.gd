extends Control

# enemy stages
var bosses
var bossidx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	bosses = [$Playground/RIngPath/PathFollow2D]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	bosses[bossidx].offset += 250 * delta
	#bosses[bossidx].position.move_toward(Vector2(100, 100), delta * 100)
	pass
