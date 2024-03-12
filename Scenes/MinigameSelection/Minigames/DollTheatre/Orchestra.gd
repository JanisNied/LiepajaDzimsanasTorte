extends AudioStreamPlayer

var offset
var secsperbeat
var nthbeat = 0
var lastreportednthbeat = 0
var measures := 3
var measure = 1

func begin_orchestra(delayinbeats, bpm):
	self.secsperbeat = 60.0 / bpm
	self.offset = delayinbeats
	$Conductor.wait_time = self.offset
	$Conductor.start()

func reportbeat():
	if lastreportednthbeat < nthbeat:
		if measure > measures:
			measure = 0
		lastreportednthbeat = nthbeat
		measure += 1

func _on_Conductor_timeout():
	nthbeat += 1
	if nthbeat < offset - 1:
		$Conductor.start()
	elif nthbeat == offset - 1:
		$Conductor.wait_time = $Conductor.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
	else:
		SoundManager.play_bgm("dollBeatmapSong")
		$Conductor.stop()
	reportbeat()
