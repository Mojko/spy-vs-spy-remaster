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
	emit_signal("move", velocity.normalized(), old_position, global_transform.origin);
	
func _on_server_set_object_position(object_id, position):
	if(get_parent().object_id != object_id):
		return;
		
	global_transform.origin = position;
	
func _on_server_move_object(object_id, direction, old_position, position):
	if(get_parent().object_id != object_id):
		return;
		
	#Check for hacks
	
	
	
	
	
	
	
	
	
#func _physics_process(delta):
#	state_machine.update(self);
#
#	var direction = Vector2();
#
#	if(Input.is_action_pressed("move_up")):
#		direction.y -= 1;
#	if(Input.is_action_pressed("move_right")):
#		direction.x += 1;
#	if(Input.is_action_pressed("move_down")):
#		direction.y += 1;
#	if(Input.is_action_pressed("move_left")):
#		direction.x -= 1;
#
#	old_position = global_transform.origin;
#
#	move_and_slide(direction.normalized() * speed);
#
#	if(direction.length() > 0):
#		is_moving = true;
#		emit_signal("move", get_parent().object_id, direction.normalized(), old_position, global_transform.origin);
#	else:
#		if(is_moving):
#			emit_signal("move", get_parent().object_id, direction.normalized(), old_position, global_transform.origin);
#		is_moving = false;