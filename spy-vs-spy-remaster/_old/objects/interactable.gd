extends Node

export(Array, Resource) var items_inside = [];

onready var _animation_player = get_node("AnimationPlayer");

func _ready():
	assert(_animation_player);
	
func play_interaction_enter_animation():
	_animation_player.play("interact_animation");

func play_interaction_exit_animation():
	_animation_player.play("interact_animation_exit");
	pass

func place_item(item):
	items_inside.append(item);
	
func grab_items():
	var temp = items_inside.duplicate();
	items_inside.clear();
	return temp;