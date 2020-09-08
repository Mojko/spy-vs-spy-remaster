extends Node2D

export(Array, PackedScene) var _rooms;

var _room_instances : Array;

func _ready():
	for room in _rooms:
		_room_instances.append(room.instance());

func get_room_with_id(id):
	return _room_instances[id];