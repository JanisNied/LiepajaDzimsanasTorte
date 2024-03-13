extends Spatial

# what is this boilerplate crap
# never let me code at 2am
var activityIndex : int = 0

var act1 : bool = true
var act2 : bool = true
var act3 : bool = true
var act4 : bool = true
var act5 : bool = true
var act6 : bool = true

func _ready():
	pass

func updateAct():
	if activityIndex == Global.allowedActivities.size():
		activityIndex = 0
		$AnimationPlayerOut.play("Activity"+str(Global.allowedActivities[Global.allowedActivities.size()-1]))
	if activityIndex != 0:
		$AnimationPlayerOut.play("Activity"+str(Global.allowedActivities[activityIndex - 1]))
	$AnimationPlayerIn.play("Activity"+str(Global.allowedActivities[activityIndex]))

func activity1():
	if act1:
		$CakeTop/PieceofCake2/MeshInstance.show()
		$CakeTop/PieceofCake3/MeshInstance.show()
		$CakeTop/PieceofCake4/MeshInstance.show()
		act1 = false
	else:
		$CakeTop/PieceofCake2/MeshInstance.hide()
		$CakeTop/PieceofCake3/MeshInstance.hide()
		$CakeTop/PieceofCake4/MeshInstance.hide()
		act1 = true

func activity2():
	if act2:
		$CakeTop/PieceofCake5/MeshInstance.show()
		$CakeTop/PieceofCake6/MeshInstance.show()
		$CakeTop/PieceofCake8/MeshInstance.show()
		$CakeTop/PieceofCake9/MeshInstance.show()
		act2 = false
	else:
		$CakeTop/PieceofCake5/MeshInstance.hide()
		$CakeTop/PieceofCake6/MeshInstance.hide()
		$CakeTop/PieceofCake8/MeshInstance.hide()
		$CakeTop/PieceofCake9/MeshInstance.hide()
		act2 = true

func activity3():
	if act3:
		$CakeTop/PieceofCake/MeshInstance.show()
		$CakeTop/PieceofCake11/MeshInstance.show()
		$CakeTop/PieceofCake10/MeshInstance.show()
		act3 = false
	else:
		$CakeTop/PieceofCake/MeshInstance.hide()
		$CakeTop/PieceofCake11/MeshInstance.hide()
		$CakeTop/PieceofCake10/MeshInstance.hide()
		act3 = true

func activity4():
	if act4:
		$CakeBottom/PieceofCake2/MeshInstance.show()
		$CakeBottom/PieceofCake3/MeshInstance.show()
		$CakeBottom/PieceofCake4/MeshInstance.show()
		act4 = false
	else:
		$CakeBottom/PieceofCake2/MeshInstance.hide()
		$CakeBottom/PieceofCake3/MeshInstance.hide()
		$CakeBottom/PieceofCake4/MeshInstance.hide()
		act4 = true

func activity5():
	if act5:
		$CakeBottom/PieceofCake5/MeshInstance.show()
		$CakeBottom/PieceofCake6/MeshInstance.show()
		$CakeBottom/PieceofCake8/MeshInstance.show()
		$CakeBottom/PieceofCake9/MeshInstance.show()
		act5 = false
	else:
		$CakeBottom/PieceofCake5/MeshInstance.hide()
		$CakeBottom/PieceofCake6/MeshInstance.hide()
		$CakeBottom/PieceofCake8/MeshInstance.hide()
		$CakeBottom/PieceofCake9/MeshInstance.hide()
		act5 = true

func activity6():
	if act6:
		$CakeBottom/PieceofCake/MeshInstance.show()
		$CakeBottom/PieceofCake11/MeshInstance.show()
		$CakeBottom/PieceofCake10/MeshInstance.show()
		act6 = false
	else:
		$CakeBottom/PieceofCake/MeshInstance.hide()
		$CakeBottom/PieceofCake11/MeshInstance.hide()
		$CakeBottom/PieceofCake10/MeshInstance.hide()
		act6 = true	
					
func _on_Button_button_up():
	get_parent().get_parent().get_parent().get_node("Button").disabled = true
	activityIndex += 1
	updateAct()
	yield(get_tree().create_timer(0.7), "timeout")
	get_parent().get_parent().get_parent().get_node("Button").disabled = false
	pass 
