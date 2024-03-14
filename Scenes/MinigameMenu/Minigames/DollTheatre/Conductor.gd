extends Timer

var offsetbeats = 0
var secsperbeat
var nthbeat = 0
var lastreportednthbeat = 0
var measures := 3
var measure = 1
var songpos

func _physics_process(_delta):
	if SoundManager.is_playing("dollBeatmapSong"):
		songpos = SoundManager.get_position_in_parent() + AudioServer.get_time_since_last_mix()
		songpos -= AudioServer.get_output_latency()
		nthbeat = int(floor(songpos / secsperbeat)) + offsetbeats
		report_beat()

func awake_conductor(offsetinbeats, bpm):
	self.offsetbeats = offsetinbeats
	self.secsperbeat = 60.0 / bpm
	self.wait_time = offsetinbeats
	start()
	
func report_beat():
	if self.lastreportednthbeat < self.nthbeat:
		if self.measure > self.measures:
			self.measure = 1
		self.lastreportednthbeat = self.nthbeat
		self.measure += 1

func _on_Conductor_timeout():
	self.nthbeat += 1
	if self.nthbeat < self.offsetbeats - 1:
		self.start()
	elif self.nthbeat == self.offsetbeats - 1:
		self.wait_time = self.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		self.start()
	else:
		SoundManager.play_bgm("dollBeatmapSong")
		self.stop()
	report_beat()
