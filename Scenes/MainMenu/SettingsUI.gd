extends Control

onready var masterVol = 1.0
onready var musicVol = 0.2
onready var sfxVol = 1.0

func _ready():
	yield(get_tree().create_timer(1.5), "timeout")
	if SaveSystem.has("Volumes"):
		print("[PERSISTENCE] Volume has been set!")
		masterVol = SaveSystem.get_var("Volumes")["master"]
		musicVol = SaveSystem.get_var("Volumes")["music"]
		sfxVol = SaveSystem.get_var("Volumes")["sfx"]
	$MasterLabel.text = str(masterVol*100)+"%"
	$SFXLabel.text = str(sfxVol*100)+"%"
	$MusicLabel.text = str(musicVol*100)+"%"
	$Master.value = masterVol
	$Music.value = musicVol
	$SFX.value = sfxVol
	pass


func _on_Master_value_changed(value):
	SaveSystem.set_var("Volumes:master", value)
	SaveSystem.save()
	$MasterLabel.text = str(value*100)+"%"
	masterVol = value
	var newValMus = masterVol * musicVol
	var newValSFX = masterVol * sfxVol
	SoundManager.set_bgm_volume_db(linear2db(newValMus))
	SoundManager.set_se_volume_db(linear2db(newValSFX))
	SoundManager.set_volume_db(linear2db(newValMus), "sunMenuMusic")
	pass 


func _on_Music_value_changed(value):
	SaveSystem.set_var("Volumes:music", value)
	SaveSystem.save()
	$MusicLabel.text = str(value*100)+"%"
	musicVol = value
	var newValMus = masterVol * musicVol
	SoundManager.set_bgm_volume_db(linear2db(newValMus))
	SoundManager.set_volume_db(linear2db(newValMus), "sunMenuMusic")
	pass

func _on_SFX_value_changed(value):
	SaveSystem.set_var("Volumes:sfx", value)
	SaveSystem.save()
	$SFXLabel.text = str(value*100)+"%"
	sfxVol = value
	var newValSFX = masterVol * sfxVol
	SoundManager.set_se_volume_db(linear2db(newValSFX))
	pass  
