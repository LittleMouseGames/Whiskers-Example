extends Control

func _ready():
	var parser = WhiskersParser.new()
	var dialogue_data = parser.open_whiskers("res://Assets/basic_dave.json")
	var block = parser.start_dialogue(dialogue_data)
	
	print(block)
