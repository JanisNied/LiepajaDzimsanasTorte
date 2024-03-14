extends Node2D

var holoMat = preload("res://Shaders/holo.tres")

func _ready():
	print("[TIME] Elapsed Time since Game Start: %02d:%02d:%02d" % [floor(int(Global.time) / 3600), floor((int(Global.time) % 3600) / 60), int(Global.time) % 60])
	SoundManager.stop("sunMenuMusic")
	randomize()
	if not Global.activitiesPicked:
		Global.pickActivitiesRandomly()
	Global.printAllActivities()
	deleteEatenSlices()
	if Global.slicesEaten != 6:
		$ViewportContainer.show()
		yield(get_tree().create_timer(1.5), "timeout")
		$ViewportContainer/Viewport/Spatial/Camera/AnimationPlayer.play("CakeOpening")
	else:
		noSlices()
	print("Current Score: "+str(Global.score))
	pass # Replace with function body.
	
func noSlices():
	Global.transition("GameEnd")
	
func deleteEatenSlices():
	for i in Global.discardedActivityNum:
		match i:
			1:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake2.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake3.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake4.set_surface_material(0, holoMat)
			2:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake5.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake6.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake8.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake9.set_surface_material(0, holoMat)
			3:
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake11.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeTop/PieceofCake10.set_surface_material(0, holoMat)
			4:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake2.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake3.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake4.set_surface_material(0, holoMat)
			5:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake5.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake6.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake8.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake9.set_surface_material(0, holoMat)
			6:
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake11.set_surface_material(0, holoMat)
				$ViewportContainer/Viewport/Spatial/CakeBottom/PieceofCake10.set_surface_material(0, holoMat)

func _process(delta):
	Global.time += delta
