extends KinematicBody2D

signal move(object_id, direction, old_position, new_position);

onready var state_machine = get_node("state_machine");

func _ready():
	assert(state_machine);
	
	connect("move", RpcToServer, "_on_gameobject_move");
	RpcToClient.connect("set_object_position", self, "_on_server_set_object_position");
	RpcToClient.connect("move_object", self, "_on_server_move_object");

func _physics_process(delta):
	state_machine.update(self);
	
func move(velocity):
	var old_position = global_transform.origin;
	move_and_slide(velocity);
	emit_signal("move", get_parent().object_id, velocity.normalized(), old_position, global_transform.origin);
	
func _on_state_machine_change_state(state_node):
	#Make the player stop on the server too!
	if(state_node.name == "idle"):
		emit_signal("move", get_parent().object_id, Vector2.ZERO, global_transform.origin, global_transform.origin);
	
func _on_server_set_object_position(object_id, position):
	if(get_parent().object_id != object_id):
		return;
		
	global_transform.origin = position;
	
func _on_server_move_object(object_id, direction, old_position, position):
	if(get_parent().object_id != object_id):
		return;