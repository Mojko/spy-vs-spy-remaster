tool
extends Node2D

export(Texture) var _side_door_closed;
export(Texture) var _side_door_open;
export(Texture) var _center_door_closed;
export(Texture) var _center_door_open;

signal change_sprite(sprite)

func _on_door_state_changed(door_state):
	emit_signal("change_sprite");
	pass


func _on_door_type_changed(door_type):
	pass # Replace with function body.

func _set_door_sprite(door_type):
	if(door_type == DoorType.SIDE_RIGHT or door_type == DoorType.SIDE_LEFT):
		if(_door_state == DoorState.OPEN):
			emit_signal("sprite_changed", _side_door_open);
			#_sprite.texture = _side_door_open;
		elif(_door_state == DoorState.CLOSED):
			emit_signal("sprite_changed", _side_door_closed);

	if(door_type == DoorType.CENTER):
		if(_door_state == DoorState.OPEN):
			emit_signal("sprite_changed", _center_door_open);
		elif(_door_state == DoorState.CLOSED):
			emit_signal("sprite_changed", _center_door_closed);