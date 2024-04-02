extends Spatial

var globalintruder = false
var anomalies = 0

func hideallintruders():
	for child in get_children():
		child.visible = false


func _on_Intruder1_visibility_changed():
	if $Intruder1.visible:
		SoundManager.play_bgm("chase", 0.0, -5.0)
		anomalies += 1
	else:
		SoundManager.stop("chase")
		anomalies -= 1	
	pass # Replace with function body.
