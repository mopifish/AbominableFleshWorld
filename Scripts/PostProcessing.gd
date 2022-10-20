extends Node

export var FPS = 24

func _ready():
	Engine.set_target_fps(FPS)
