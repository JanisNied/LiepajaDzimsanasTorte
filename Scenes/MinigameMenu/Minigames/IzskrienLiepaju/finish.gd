extends Area2D
var pos = 1
var winners : Array
var pointsEnd
#Points that player gets for winning/losing


func _ready():
	pass 


func _on_Area2D_body_entered(body):
	winners.append(body.name)
	if body==get_parent().get_node("Route/RouteFollowers/MainPlayer"):
		print("finsih if works")
		if winners.size()>1:
			Global.izskrienUzvara = false
			pointsEnd = get_parent().get_node("Quest1/Control/QuestFrame1").pointsGot-10
		else:
			Global.izskrienUzvara = true
			pointsEnd = get_parent().get_node("Quest1/Control/QuestFrame1").pointsGot
		get_parent().get_node("Route/RouteFollowers").moving=false
	else:
		pointsEnd = get_parent().get_node("Quest1/Control/QuestFrame1").pointsGot-10
		get_parent().get_node("Route/hardFollow").stopTime+=9999
		get_parent().get_node("Route/hardFollow").moving=false
		Global.izskrienUzvara = false
	Global.score += pointsEnd
	Global.izskrienPunkti = pointsEnd
	Global.earnedPoints[Global.discardedActivityNum[Global.discardedActivityNum.size()-1]-1] += pointsEnd
	if pointsEnd < 0:
		if not Global.discardedActivityNum[Global.discardedActivityNum.size()-1] in Global.retryMinigameNums:
			Global.retryMinigameNums.append(Global.discardedActivityNum[Global.discardedActivityNum.size()-1])
			Global.allowedActivities.append(Global.discardedActivityNum[Global.discardedActivityNum.size()-1])		
			Global.chosenActivities.append(Global.discardedActivities[Global.discardedActivities.size()-1])
			
			Global.discardedActivityNum.erase(Global.discardedActivityNum[Global.discardedActivityNum.size()-1])
			Global.discardedActivities.erase(Global.discardedActivities[Global.discardedActivities.size()-1])
			Global.sortActivities()
			Global.slicesEaten -= 1
	SoundManager.stop("heartbreak")		
	Global.transition("ExtraScene")
