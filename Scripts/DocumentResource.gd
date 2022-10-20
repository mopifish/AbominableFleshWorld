extends Resource

class_name Document

signal unlocked

export(int) var date = 00000000
export(String) var location = "Unknown"
export(String) var author = "Unknown"
export(String, MULTILINE) var text = "???????????????????????????????????"
var unlocked = false setget set_unlocked

func set_unlocked(value):
	unlocked = value
	emit_signal("unlocked")
