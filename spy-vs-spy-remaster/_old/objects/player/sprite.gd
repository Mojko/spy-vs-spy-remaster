extends Sprite

onready var _change_sprite_timer : Timer = get_node("change_sprite_timer");
onready var _state_machine : StateMachine = get_node("state_machine");

var _current_animation : Array;
var _current_index : int;

func _ready():
	assert(_change_sprite_timer);
	assert(_state_machine);
	_state_machine.change_state("walk_down");
	
func _on_state_machine_change_state(state_node):
	if(!(state_node is SpriteAnimationState)):
		return;
		
	_current_animation = state_node.animation_values;
	_current_index = 0;
	_change_sprite_timer.start();

func _on_change_sprite_timer_timeout():
	self.region_rect.position.x = _current_animation[_current_index].position.x;
	self.region_rect.position.y = _current_animation[_current_index].position.y;
	self.region_rect.size.x = _current_animation[_current_index].size.x;
	self.region_rect.size.y = _current_animation[_current_index].size.y;
	_change_sprite_timer.start();
	_current_index += 1;
	_current_index %= _current_animation.size();
