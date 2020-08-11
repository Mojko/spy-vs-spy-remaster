extends Node

signal item_added_to_inventory(new_item_data);
signal item_removed_from_inventory(removed_item_data);

var _inventory : Array = [];

func _on_interact_item_found_in_interactable(item_data):
	_inventory.append(item_data);
	emit_signal("item_added_to_inventory", item_data);

func _on_interact_place_item_in_interactable(interactable_area):
	for item in _inventory:
		interactable_area.place_item(item);
		emit_signal("item_removed_from_inventory", item);
	_inventory.clear();
