extends Node

var list = {}

func _ready():
	var docs = _get_documents()
	for doc in docs:
		add(load(doc))
	
	print(list)

func add(doc : Document):
	list[doc.date] = doc

#--Retrieves all documents in the documents folder
func _get_documents(path = "res://Resources/Documents/"):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(path + file)

	dir.list_dir_end()

	return files
