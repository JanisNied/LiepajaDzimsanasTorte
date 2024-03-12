extends AudioStreamPlayer

var beatpersecs
var beatdelay = 0
var nthbeat = 0
var lastreportbeat = 0
var measures := 3
var measure = 1

func start_play(offset, bpm):
	beatpersecs = 60.0 / bpm
	beatdelay = offset
	$Conductor.wait_time = beatpersecs
	$Conductor.start()

func report_beat():
	if lastreportbeat < nthbeat:
		if measure > measures:
			measure = 0
		lastreportbeat = nthbeat
		measure += 1

func _on_Conductor_timeout():
	nthbeat += 1
	if nthbeat < beatdelay - 1:
		$Conductor.start()
	elif nthbeat == beatdelay - 1:
		$Conductor.wait_time = $Conductor.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		$Conductor.start()
	else:
		play()
		$Conductor.stop()
	report_beat()
	
