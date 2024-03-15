extends Area2D
var rememberSmth=0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_new_collision()
	get_node("Control/QuestFrame1").hideAll()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print("shit works")
	print(rememberSmth)
	print(body)
	if body==get_parent().get_node("Route/RouteFollowers/MainPlayer"):
		get_parent().get_node("Route/RouteFollowers").set_moving(false)
		get_node("Control/QuestFrame1")._ready()
		get_node("Control/QuestFrame1").showAll()
		get_node("Control/QuestFrame1").questionNum=rememberSmth
		#get_node("Control/QuestFrame1").set_new_pos()
		get_parent().get_node("Route/RouteFollowers/MainPlayer/Camera2D").current=false
		$questCamera.current=true
func restart():
	get_parent().get_node("Route/RouteFollowers").moving = true
	$questCamera.current=false
	get_parent().get_node("Route/RouteFollowers/MainPlayer/Camera2D").current=true
func set_new_collision():
	if rememberSmth<9:
		get_node("CollisionShape2D2").set_global_position(get_parent().get_node("poi"+str(rememberSmth+1)).global_position)
		print(global_position,"collision set")
