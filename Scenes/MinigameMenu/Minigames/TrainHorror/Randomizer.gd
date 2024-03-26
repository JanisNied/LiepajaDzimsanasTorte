extends Spatial

func _on_EventTimer_timeout():
	var randNum = randi() % 10 + 1
	print(randNum)
	getEvent(randNum)
	pass 

func getEvent(event):
	match event:
		5:
			if not $Intruders.globalintruder:
				var randNum = randi() % $Intruders.get_child_count() + 1
				$Intruders.get_node("Intruder"+str(randNum)).visible = true
				$Intruders.globalintruder = true
