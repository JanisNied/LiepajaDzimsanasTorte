extends PathFollow2D
var moving = true
var boostTime = 0.0
var speedDif = randi()
var t := 0.0
var timePos=0
var diff=1
var stopTime=0.0
var antiStop=false
var stopPoint=[251,326,531,714,960,1051,2399,2490,2604]
func _process(delta):
	if round(offset) in stopPoint and stopTime<=0.0 and antiStop==false:
		stop()
		antiStop=true
	if moving:
		if !(round(offset) in stopPoint):
			antiStop=false
		#print(stopTime)
		t+=delta*5
		if boostTime>0:
			t+=delta*2
			boostTime-=delta
		offset=t*10.0*diff
	else:
		if stopTime>0:
			stopTime-=delta
		else:
			boostTime+=5
			moving=true
func set_moving(i):
	moving =i
func stop():
#	stopTime+=6+randi()%4
	moving=false
