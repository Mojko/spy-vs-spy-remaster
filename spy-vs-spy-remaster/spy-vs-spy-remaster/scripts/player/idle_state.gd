extends State

func enter(data : Array):
	pass
	
func exit():
	pass

func update(parent : Node):
	if(Input.is_action_pressed("move_up")):
		return ["moving"];
	if(Input.is_action_pressed("move_right")):
		return ["moving"];
	if(Input.is_action_pressed("move_down")):
		return ["moving"];
	if(Input.is_action_pressed("move_left")):
		return ["moving"];