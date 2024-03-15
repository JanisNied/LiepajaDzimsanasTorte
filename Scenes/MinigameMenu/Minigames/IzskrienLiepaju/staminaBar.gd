extends ProgressBar


var timeSinceLastRun=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if get_parent().get_parent().moving:
		if value<100 and !Input.is_action_pressed("run"):
			timeSinceLastRun+=delta*10
			value+=1*delta*timeSinceLastRun
		if value>0 and Input.is_action_pressed("run"):
			
			timeSinceLastRun=0
			value-=50*delta
		if value==0 and Input.is_action_pressed("run"):
			timeSinceLastRun=-30
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
