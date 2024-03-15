extends Node2D

var pointsToMove = [Vector2(-100, -13), Vector2(0, -40)]
var idx = 0
var moving = false
var dest

# Called when the node enters the scene tree for the first time.
func _ready():
	Spawning.spawn(self, "RingBulletPattern")
	pass

func _process(delta):
	if !moving:
		dest = self.position + pointsToMove[idx]
		moving = true
		
	if (self.position != dest):
		self.position += (pointsToMove[idx] / 100)
		pass
	else:
		if idx + 1 < pointsToMove.size():
			idx += 1
			moving = false
