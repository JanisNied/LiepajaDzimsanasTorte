extends AnimatedSprite

func _on_Theatre_beatHit(score):
	if !self.visible:
		self.visible = true
