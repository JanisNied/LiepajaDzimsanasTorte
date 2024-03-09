extends Camera



func disableAreas():
	$PlaySelector/Area.hide()
	$SettingsSelector/Area.hide()
	$LeaderboardSelector/Area.hide()
	$AboutSelector/Area.hide()
	
func enableAreas():
	$PlaySelector/Area.show()
	$SettingsSelector/Area.show()
	$LeaderboardSelector/Area.show()
	$AboutSelector/Area.show()
