extends Node

export(NodePath) var _player_path;

var _current_room;
var _current_level;
var _player;

func _ready():
	assert(_player_path);
	_current_level = get_node("HD/level_0");
	assert(_current_level);
	
	_current_room = _current_level.get_room_with_id(0);
	
	_activate_current_room();
	
	_player = get_node(_player_path);

func _on_player_teleport(next_room_id, next_door_id):
	_deactivate_current_room();
	_current_room = _current_level.get_room_with_id(next_room_id);
	print(_current_room.name);
	_activate_current_room();
	_player.global_transform.origin = _current_room.get_door_with_id(next_door_id).destination.global_transform.origin;
	
func _activate_current_room():
	_current_level.add_child(_current_room);

func _deactivate_current_room():
	_current_level.remove_child(_current_room);