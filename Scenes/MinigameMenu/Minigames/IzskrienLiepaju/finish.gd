extends Area2D
var pos = 1
var winners : Array
var pointsEnd
#Points that player gets for winning/losing


func _ready():
	pass 


func _on_Area2D_body_entered(body):
	winners.append(body.name)
	print(winners)
	if body==get_parent().get_node("Route/RouteFollowers/MainPlayer"):
		print("finsih if works")
		if winners.size()>1:
			pointsEnd = get_parent().get_node("Quest1/Control/QuestFrame1").pointsGot-10
		else:
			pointsEnd = get_parent().get_node("Quest1/Control/QuestFrame1").pointsGot
		get_parent().get_node("Route/RouteFollowers").moving=false
	else:
		get_parent().get_node("Route/hardFollow").stopTime+=9999
		get_parent().get_node("Route/hardFollow").moving=false
	Global.score += pointsEnd
	Global.transition("MinigameMenu")
