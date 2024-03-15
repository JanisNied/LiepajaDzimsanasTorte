extends Node2D

var pointsToMove = [Vector2(-100, -13), Vector2(0, -40)]
var idx = 0
var moving = false
var dest

var degx
var degy

# Called when the node enters the scene tree for the first time.
func _ready():
	Spawning.spawn(self, "RingBulletPattern")
	pass

func _process(delta):
	if !moving:
		dest = self.position + pointsToMove[idx]
		moving = true
		
		if (self.position.x > dest.x):
			degx = true
		elif (self.position.x < dest.x):
			degx = false
	
		if (self.position.y > dest.y):
			degy = true
		elif (self.position.y < dest.y):
			degy = false
			
	else:
		if (self.position == dest):
			if idx + 1 < pointsToMove.size():
				moving = false
				idx += 1
		else:
			if (self.position.x != dest.x):
				if degx:
					self.position.x -= 1
				else:
					self.position.x += 1
				
			if (self.position.y != dest.y):
				if degy:
					self.position.y -= 1
				else:
					self.position.y += 1
		print(self.position, " ", dest)
	
		
			
	#	self.position += (pointsToMove[idx] / 100)
	#	pass
	#else:
	#	if idx + 1 < pointsToMove.size():
	#		idx += 1
	#		moving = false
