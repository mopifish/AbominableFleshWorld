extends Area

export(Resource) var document

func interact():
	var new_dialog = Dialogic.start(name)
	add_child(new_dialog)
	visible = false
	
	if document:
		yield(new_dialog, "tree_exited")
		document.unlocked = true
		queue_free()
