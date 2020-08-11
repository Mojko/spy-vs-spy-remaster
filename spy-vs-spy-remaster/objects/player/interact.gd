extends Area2D

signal item_found_in_interactable(item_data);
signal place_item_in_interactable(interactable_area);

var _can_interact : bool;
var _is_interacting : bool;
var _interactable_area : Area2D;

func _process(delta):
	if(!_can_interact):
		return;
	
	if(!_is_interacting and Input.is_action_just_pressed("interact")):
		_enter_interaction();
		
		var items = _interactable_area.grab_items();
		
		for item in items:
			emit_signal("item_found_in_interactable", item);
		return;
	
	if(_is_interacting and Input.is_action_just_pressed("place_item")):
		emit_signal("place_item_in_interactable", _interactable_area);
		return;
	
	if(_is_interacting and Input.is_action_just_pressed("interact")):
		_exit_interaction();
		return;

func _enter_interaction():
	_interactable_area.play_interaction_enter_animation();
	_is_interacting = true;
	
func _exit_interaction():
	if(_is_interacting == false or _interactable_area == null):
		return;
		
	_interactable_area.play_interaction_exit_animation();
	_is_interacting = false;

func _on_interact_area_entered(area):
	if(area.is_in_group("interactable")):
		_can_interact = true;
		_interactable_area = area;

func _on_interact_area_exited(area):
	if(area.is_in_group("interactable")):
		_can_interact = false;
		_interactable_area = null;

func _on_player_move(velocity):
	_exit_interaction();
