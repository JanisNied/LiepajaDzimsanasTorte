extends PathFollow2D
var moving = true
var boostTime = 0.0
var t := 0.0
func _process(delta):
	if moving:
		t+=delta*5
		if boostTime>0:
			t+=delta*1.5
			boostTime-=delta
		if Input.is_action_pressed("run") and get_node("MainPlayer/staminaBar").value>0:
			t+=delta*1.4
		if get_node("MainPlayer/staminaBar").value==0:
			t-=delta*2.5
		
		
		offset=t*10.0
func set_moving(i):
	moving =i
