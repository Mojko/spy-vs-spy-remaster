extends Node
class_name StateMachine

export(Array, String) var state_map = [];

signal change_state(state_node);

var states = [];
var active_state;

func _ready():
	for child in get_children():
		states.append(child);
		
	if(states.size() > 0):
		change_state(states[0].name);
		
func update(parent):
	if(active_state == null):
		return;
	
	var next_state_data : Array = active_state.update(parent);
	
	if(next_state_data != null):
		var next_state = next_state_data.pop_front();
		change_state(next_state, next_state_data);
		
func change_state(next_state : String, data : Array = []):
	var index = state_map.find(next_state);
	
	if(active_state != null):
		active_state.exit();
		
	active_state = states[index];
	
	emit_signal("change_state", active_state);
	
	active_state.enter(data);