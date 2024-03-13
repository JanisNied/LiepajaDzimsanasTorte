extends Sprite

onready var orchestra = get_parent().get_parent().get_parent().find_node("Orchestra")
var vis = false
var stuckpos = 550

func _physics_process(_delta):
	if orchestra.playing:
		self.position.x = stuckpos
		
		if vis:
			if self.modulate.a > 0:
				self.modulate.a -= 0.1
			else:
				self.visible = false
				vis = false

func _unhandled_input(event):
	if !orchestra.playing:
		return
	
	if !event.is_echo() and event.scancode == KEY_SPACE and !vis:
		self.visible = true
		vis = true
		self.modulate.a = 1

func _on_Orchestra_nextbeat(pos):
	self.stuckpos = 550 + (81.75 * (pos))
