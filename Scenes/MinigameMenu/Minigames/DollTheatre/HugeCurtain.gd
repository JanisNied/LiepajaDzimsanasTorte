extends Control

var landed = true

func _physics_process(delta):
	if landed:
		return
	
	if rect_position.y < 0:
		rect_position.y += 576 * delta
	else:
		rect_position.y == 0
		landed = true

func _on_Beatmap_eof():
	landed = false
