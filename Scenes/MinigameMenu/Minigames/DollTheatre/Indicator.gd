extends Sprite

onready var orchestra = get_parent().get_parent().get_parent().find_node("Orchestra")

var oglocation = 550
var animreached = false

func _physics_process(_delta):
	if orchestra.playing and !animreached:
		var beatpos = orchestra.measure - 1
		var idealpos = 550 + (81.75 * beatpos)
		if self.position.x != idealpos:
			if beatpos == 0:
				self.position.x -= 81.75
			else:
				self.position.x += 27.25
		else:
			animreached = true

func _on_Orchestra_nowstart():
	self.visible = true

func _on_Orchestra_nextbeat(pos):
	animreached = false

func _on_Beatmap_eof():
	self.visible = false	
	pass # Replace with function body.
