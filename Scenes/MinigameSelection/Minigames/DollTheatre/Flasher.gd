extends Sprite

onready var orchestra = get_parent().get_parent().get_parent().find_node("Orchestra")
var vis = false

func _physics_process(_delta):
	if orchestra.playing:
		var idealpos = 550 + (81.75 * (orchestra.measure - 1))
		self.position.x = idealpos

func _unhandled_input(event):
	if !event.is_echo() and event.scancode == KEY_SPACE and !vis:
		self.visible = true
		vis = true
		self.modulate.a = 1
#	elif vis:
#		if self.modulate.a != 0:
#			self.modulate.a -= 0.5
#		else:
#			self.visible = false
#			vis = false
