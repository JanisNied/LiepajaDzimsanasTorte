extends Node2D

func _ready():
	randomize()
	Global.pickActivitiesRandomly()
	print(Global.chosenActivities)
	yield(get_tree().create_timer(1.5), "timeout")
	$ViewportContainer/Viewport/Spatial/Camera/AnimationPlayer.play("CakeOpening")
	pass # Replace with function body.
