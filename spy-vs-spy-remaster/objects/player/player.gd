extends KinematicBody2D

signal power_changed(power);
signal move(velocity);
signal item_added_to_inventory(new_item_data);
signal item_removed_from_inventory(removed_item_data);

var _current_power = 100 setget set_current_power, get_current_power;
var _can_interact : bool = false;
var _inventory : Array = [];

func _process(delta):
	var direction = Vector2();
	
	if(Input.is_action_pressed("move_down")):
		direction.y += 1
		
	if(Input.is_action_pressed("move_up")):
		direction.y -= 1
		
	if(Input.is_action_pressed("move_right")):
		direction.x += 1
		
	if(Input.is_action_pressed("move_left")):
		direction.x -= 1
		
	var velocity : Vector2 = move_and_slide(direction.normalized() * 100);

	if(velocity.length() > 0):
		emit_signal("move", direction);
		
	
func set_current_power(power):
	_current_power = power;
	emit_signal("power_changed", power);
	
func get_current_power():
	return _current_power;
	
func _on_inventory_item_added_to_inventory(new_item_data):
	emit_signal("item_added_to_inventory", new_item_data);

func _on_inventory_item_removed_from_inventory(removed_item_data):
	emit_signal("item_removed_from_inventory", removed_item_data);
