extends AudioStreamPlayer

var secsperbeat
var beatdelay = 0
var nthbeat = 0
var lastreportbeat = 0
var measures := 3
var measure = 1
var songpos = 0
var waveturn = 0

signal nextbeat(pos)
signal nextwave(turn)
signal nowstart()

func start_play(offset, bpm):
	secsperbeat = 60.0 / bpm
	beatdelay = offset
	$Conductor.wait_time = secsperbeat
	$Conductor.start()
	
func _physics_process(_delta):
	if playing:
		songpos = get_playback_position() + AudioServer.get_time_since_last_mix()
		songpos -= AudioServer.get_output_latency()
		nthbeat = int(floor(songpos / secsperbeat)) + beatdelay
		report_beat()

func report_beat():
	if lastreportbeat < nthbeat:
		if measure > measures:
			measure = 0
			waveturn += 1
			emit_signal("nextwave", waveturn % 2)
		emit_signal("nextbeat", measure)
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
		emit_signal("nowstart")
		play()
		$Conductor.stop()
	report_beat()
