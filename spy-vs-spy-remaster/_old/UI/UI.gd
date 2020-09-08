extends Control

onready var items_container = get_node("side/VBoxContainer/items_container");

func _ready():
	assert(items_container);

func _on_player_item_added_to_inventory(new_item_data):
	items_container.on_item_was_added_to_inventory(new_item_data);
	
func _on_player_item_removed_from_inventory(removed_item_data):
	items_container.on_item_was_removed_from_inventory(removed_item_data);
