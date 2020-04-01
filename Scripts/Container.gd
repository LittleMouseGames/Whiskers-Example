extends Control

onready var scene: Node = get_tree().current_scene
onready var name_element: Node = scene.find_node('Name', true, false)
onready var text_element: Node = scene.find_node('Text', true, false)
onready var option_container: Node = scene.find_node('Options', true, false)
onready var button_theme: Theme = load("res://Themes/Button.tres")
onready var parser = WhiskersParser.new()
	
func _ready():
	var dialogue_data = parser.open_whiskers("res://Assets/patrick.json")
	var block = parser.start_dialogue(dialogue_data)
	
	name_element.set_text(dialogue_data.info.display_name)
	
	# reusable block renderer
	render_block(block)

func render_block(block: Dictionary):
	clear_options()
	
	text_element.set_text(block.text)
	
	# Render our options
	for option in block.options:
		add_button(option)

func add_button(option):
	var button = Button.new()
	
	button.set_name(option.key)
	button.set_text(option.text)
	button.set_theme(button_theme)
	option_container.add_child(button)
	
	# Connect our click event, and pass it the elements name
	button.connect("pressed", self, "option_click", [button.name])

func option_click(key):
	var block = parser.next(key)
	
	render_block(block)

func clear_options():
	# Clear our options
	for child in option_container.get_children():
		child.queue_free() 
