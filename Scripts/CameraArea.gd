extends Area

func _on_CameraArea_body_entered(body):
	Globals.camera.global_translation = $Position3D.global_translation
	Globals.camera.base_rotation = $Position3D.rotation_degrees
