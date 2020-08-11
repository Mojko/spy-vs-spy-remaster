tool
extends Node2D

enum DoorType {
	SIDE_LEFT,
	SIDE_RIGHT,
	CENTER,
	CENTER_DOWN
}

enum DoorState {
	OPEN,
	CLOSED
}

export(int) var id;
export(int) var leads_to_room;
export(int) var destination_door_id;

export(DoorType) var _door_type setget _set_door_type;
export(DoorState) var _door_state setget _set_door_state;

export(Texture) var _side_door_closed;
export(Texture) var _side_door_open;
export(Texture) var _center_door_closed;
export(Texture) var _center_door_open;
export(Texture) var _center_door_down_open;

signal sprite_changed(sprite);

onready var destination = get_node("destination");

func _ready():
	assert(destination);

func _set_door_state(door_state):
	_door_state = door_state;
	_set_door_sprite(_door_type);

func _set_door_type(door_type):
	_door_type = door_type;
	if(_door_type == DoorType.SIDE_RIGHT):
		set_scale(Vector2(-1, 1));
	else:
		set_scale(Vector2(1, 1));
		
	_set_door_sprite(door_type);

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
	if(door_type == DoorType.CENTER_DOWN):
		emit_signal("sprite_changed", _center_door_down_open);
		
func is_open():
	return _door_state == DoorState.OPEN;
	
func open():
	_set_door_state(DoorState.OPEN);