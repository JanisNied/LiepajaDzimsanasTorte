extends Control

var landed = true
var controllable = false

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and $EventHitbox.is_visible_in_tree():
		

func _physics_process(delta):
	if landed:
		return
	
	if rect_position.y < 0:
		rect_position.y += 576 * delta
	else:
		rect_position.y == 0
		landed = true
		controllable = true

func _on_Beatmap_eof():
	landed = false
