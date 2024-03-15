extends Path2D

func _ready():
	print(get_parent().find_node("RingEnemy").Sprite)
	#$Following/RingSprite.texture = get_parent().find_node("RingEnemy").Sprite.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
