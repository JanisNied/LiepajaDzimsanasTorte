extends Sprite

onready var orchestra = get_parent().get_parent().get_parent().find_node("Orchestra")

var oglocation = 550
var animreached = false

func _physics_process(_delta):
	if orchestra.playing and !animreached:
		var beatpos = orchestra.measure - 1
		var idealcoords = 550 + (81.75 * beatpos)
		self.position.x = idealcoords
		#if beatpos == 0:
			
	#	else:
			

func _on_Orchestra_nowstart():
	self.visible = true
