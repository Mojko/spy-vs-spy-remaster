extends Node

export(int) var id;

func _ready():
	set_process(false);


func get_door_with_id(door_id):
	for child in get_children():
		if(child.is_in_group("door")):
			if(child.id == door_id):
				return child;