extends Node

onready var outline = get_node("CenterContainer/outline");
onready var filled = get_node("CenterContainer/filled");

func show_item():
	outline.hide();
	filled.show();
	
func hide_item():
	outline.show();
	filled.hide();