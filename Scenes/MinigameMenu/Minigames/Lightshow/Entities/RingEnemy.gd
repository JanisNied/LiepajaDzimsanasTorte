extends Node2D

func spawnRings():
	Spawning.spawn(self, "RingBulletPattern")
	
func spawnV():
	Spawning.spawn(self, "RingBulletPatternV")
	
func _ready():
	pass
