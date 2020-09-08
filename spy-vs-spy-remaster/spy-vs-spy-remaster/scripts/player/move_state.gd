extends State

var speed = 50;

func enter(data : Array):
	pass
	
func exit():
	pass

func update(parent : Node):
	
	var direction = Vector2();
	
	if(Input.is_action_pressed("move_up")):
		direction.y -= 1;
	if(Input.is_action_pressed("move_right")):
		direction.x += 1;
	if(Input.is_action_pressed("move_down")):
		direction.y += 1;
	if(Input.is_action_pressed("move_left")):
		direction.x -= 1;
		
	if(direction.length() <= 0):
		return ["idle"];
	else:
		parent.move(direction.normalized() * speed);
	