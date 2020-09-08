extends Area2D

signal teleport(next_room_id, next_door_id);

var _can_interact : bool = false;
var _door : Area2D;

func _process(delta):
	if(!_can_interact):
		return;
	
	if(Input.is_action_just_pressed("interact")):
		if(!_door.is_open()):
			_door.open();
			return;
			
		emit_signal("teleport", _door.leads_to_room, _door.destination_door_id);

func _on_interact_door_area_entered(area):
	if(area.is_in_group("door")):
		_can_interact = true;
		_door = area;

func _on_interact_door_area_exited(area):
	if(area.is_in_group("door")):
		_can_interact = false;
		_door = null;