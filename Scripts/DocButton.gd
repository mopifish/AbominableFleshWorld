extends Button

export(Resource) var document

func unlock():
	text = str(document.date).substr(6, 2) + "." + str(document.date).substr(4, 2) + "." + str(document.date).substr(0, 4)
	disabled = false
