extends Node2D

var pointsToMove = [Vector2(-100, -13)]
var idx = 0
var moving = false
var dest = Vector2.ZERO

var degx
var degy

# Called when the node enters the scene tree for the first time.
func _ready():
	Spawning.spawn(self, "RingBulletPattern")
	pass

""""
func _physics_process(delta):
	if !moving:
		dest = self.position + pointsToMove[idx]
		moving = true
	else:
		self.position.move_toward(Vector2(100, 100), 10)
		if idx + 1 < pointsToMove.size():
			moving = false
			idx += 1
		if (
			self.position == dest):
			
			if idx + 1 < pointsToMove.size():
				moving = false
				idx += 1
		else:
			self.position.move_toward(dest, delta * 10)
			if (self.position.x != dest.x):
				if degx:
					self.position.x -= (abs(pointsToMove[idx].x) / 10)
				else:
					self.position.x += (abs(pointsToMove[idx].x) / 10)
				
			if (self.position.y != dest.y):
				if degy:
					self.position.y += (abs(pointsToMove[idx].y) / 100)
				else:
					self.position.y -= (abs(pointsToMove[idx].y) / 100)
	
		"""
			
	#	self.position += (pointsToMove[idx] / 100)
	#	pass
	#else:
	#	if idx + 1 < pointsToMove.size():
	#		idx += 1
	#		moving = false
