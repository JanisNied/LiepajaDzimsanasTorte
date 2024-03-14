extends AnimatedSprite

func _on_Theatre_beatHit(score):
	if !self.visible:
		self.visible = true
	
	if score == 50:
		self.frame = 2
	elif score == 100:
		self.frame = 1
	elif score == 300:
		self.frame = 0
	elif score == -1:
		self.frame = 3
