extends ColorRect

func _ready():
	load_documents()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle()
		$Menu/Continue.grab_focus()

func toggle():
	get_tree().paused = !get_tree().paused
	visible = !visible #get_tree().paused
	$Menu.visible = true
	$DocumentTab.visible = false

#---Menu Functions---
func _on_Continue_pressed():
	toggle()

func _on_Documents_pressed():
	$Menu.visible = false
	$DocumentTab.visible = true
	$DocumentTab/DocumentTabBack.grab_focus()
	update_documents()

func _on_Settings_pressed():
	pass

func _on_Quit_pressed():
	get_tree().quit()

#---Document Tab Functions---
func load_documents():
	for doc in Documents.list.values():
		var button = Button.new()
		button.text = "?????????????"
		button.set_script(load("res://Scripts/DocButton.gd"))
		button.document = doc
		button.connect("focus_entered", self, "display_document", [doc])
		button.disabled = true
		$DocumentTab/DocuListScroller/DocumentList.add_child(button)

func update_documents():
	for i in Documents.list.values().size():
		if Documents.list.values()[i].unlocked: 
			$DocumentTab/DocuListScroller/DocumentList.get_child(i).unlock()

func display_document(doc : Document):
	if doc.unlocked:
		$DocumentTab/ScrollContainer/DocumentDetails/Date.text = str(doc.date).substr(6, 2) + "/" + str(doc.date).substr(4, 2) + "/" + str(doc.date).substr(0, 4)
		$DocumentTab/ScrollContainer/DocumentDetails/Location.text = "Found in " + doc.location
		$DocumentTab/ScrollContainer/DocumentDetails/Author.text = doc.author
		$DocumentTab/ScrollContainer/DocumentDetails/Text.text = doc.text
	else:
		$DocumentTab/ScrollContainer/DocumentDetails/Date.text = ""
		$DocumentTab/ScrollContainer/DocumentDetails/Location.text = ""
		$DocumentTab/ScrollContainer/DocumentDetails/Author.text = ""
		$DocumentTab/ScrollContainer/DocumentDetails/Text.text = ""

func _on_DocumentTabBack_pressed():
	$Menu.visible = true
	$DocumentTab.visible = false
	$Menu/Documents.grab_focus()
