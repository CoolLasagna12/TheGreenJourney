extends RichTextLabel
func _ready():
	self.text = "[center]Time " + str(Vars.time) + "[/center]"
func _on_button_pressed():
	Vars.time = 0
	Vars.checkpoint = 0
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
