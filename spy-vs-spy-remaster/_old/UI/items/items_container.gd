extends VBoxContainer

onready var briefcase = get_node("items/briefcase");
onready var key = get_node("items/key");
onready var moneybag = get_node("items/moneybag");
onready var passport = get_node("items/passport");

func _ready():
	assert(briefcase);
	assert(key);
	assert(moneybag);
	assert(passport);

func on_item_was_added_to_inventory(new_item_data):
	match new_item_data.inventory_type:
		Item.InventoryType.BRIEFCASE:
			briefcase.show_item();
			
		Item.InventoryType.KEY:
			key.show_item();
			
		Item.InventoryType.MONEYBAG:
			moneybag.show_item();
			
		Item.InventoryType.PASSPORT:
			passport.show_item();
			
func on_item_was_removed_from_inventory(removed_item_data):
	match removed_item_data.inventory_type:
		Item.InventoryType.BRIEFCASE:
			briefcase.hide_item();
			
		Item.InventoryType.KEY:
			key.hide_item();
			
		Item.InventoryType.MONEYBAG:
			moneybag.hide_item();
			
		Item.InventoryType.PASSPORT:
			passport.hide_item();