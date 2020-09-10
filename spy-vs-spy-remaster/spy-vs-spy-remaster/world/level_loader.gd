extends Node

func _add_child(parent_name, node):
	if(get_parent().get_node(parent_name) != null):
		get_parent().get_node(parent_name).call_deferred("add_child", node);
	else:
		get_parent().call_deferred("add_child", node);
	pass

func _on_level_loader_ready():
	var level = load_level("rooms/room0");
	
	for nodes in level.nodes:
		for key in nodes.keys():
			for value in nodes.values():
				if(value.type == Enum.NodeType.SPRITE):
					var sprite = Sprite.new();
					sprite.name = key;
					
					sprite.texture = load(value.data.resource_path) as Texture;
					sprite.offset = str2var("Vector2" + value.data.position);
					sprite.centered = value.data.centered;
					sprite.z_index = value.data.z_index;
					_add_child(value.parent, sprite);
					yield(sprite, "ready");
		
				if(value.type == Enum.NodeType.NODE):
					var node = Node.new();
					node.name = key;
					_add_child(value.parent, node);
					yield(node, "ready");
		
				if(value.type == Enum.NodeType.COLLISION_SHAPE):
					var collision_shape_2d = CollisionShape2D.new();
					collision_shape_2d.name = key;
					
					if(value.data.shape == Enum.CollisionShapeType.SEGMENT):
						var segment = SegmentShape2D.new();
						segment.a = str2var("Vector2" + value.data.a);
						segment.b = str2var("Vector2" + value.data.b);
						collision_shape_2d.shape = segment;
						print(segment, ", ", collision_shape_2d.shape);
						
					_add_child(value.parent, collision_shape_2d);
					yield(collision_shape_2d, "ready");
		
				if(value.type == Enum.NodeType.STATIC_BODY):
					var static_body_2d = StaticBody2D.new();
					static_body_2d.name = key;
					_add_child(value.parent, static_body_2d);
					yield(static_body_2d, "ready");
				
func load_level(level_name):
	var file = File.new();
	
	if not file.file_exists(level_name + ".json"):
		print("COULD NOT FIND LEVEL ", level_name);
		file.close();
		return;
	
	file.open(level_name + ".json", file.READ);
	var text = file.get_as_text();
	var data = parse_json(text);
	file.close();
	return data;
	