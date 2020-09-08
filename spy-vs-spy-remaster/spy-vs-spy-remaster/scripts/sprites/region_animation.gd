extends Sprite

export(Array, Rect2) var _idle_down_animation_frames;
export(Array, Rect2) var _walk_down_animation_frames;

onready var _change_sprite_timer = get_node("change_sprite_timer");

var _current_frame : int = 0;
var _current_animation : Array = [];

func _ready():
	assert(_change_sprite_timer);
	
	_current_animation = _idle_down_animation_frames;
	
func idle_down():
	_current_animation = _idle_down_animation_frames;

func walk_down():
	_current_animation = _walk_down_animation_frames;

func _on_change_sprite_timer_timeout():
	self.region_rect.position.x = _current_animation[_current_frame].position.x;
	self.region_rect.position.y = _current_animation[_current_frame].position.y;
	self.region_rect.size.x = _current_animation[_current_frame].size.x;
	self.region_rect.size.y = _current_animation[_current_frame].size.y;
	_change_sprite_timer.start();
	_current_frame += 1;
	_current_frame %= _current_animation.size();
	
func _on_state_machine_change_state(state_node):
	_current_frame = 0;
	
	if(state_node.name == "idle"):
		_current_animation = _idle_down_animation_frames;
	if(state_node.name == "moving"):
		_current_animation = _walk_down_animation_frames;