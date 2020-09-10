extends Node

export(PackedScene) var player_prefab;
export(PackedScene) var other_player_prefab;

func start_game(connected_clients):
	PrintHelper.print_client("Players joined in the game: [" + str(connected_clients) + "]");
	
	for client in connected_clients:
		if(client.id == get_tree().get_network_unique_id()):
			var instance = player_prefab.instance();
			add_child(instance);
			instance.object_id = client.object_id;
			instance.name = str(client.id);
			print("wew");
		else:
			var instance = other_player_prefab.instance();
			add_child(instance);
			instance.object_id = client.object_id;
			instance.name = str(client.id);
			
func add_child(child, b = false):
	.add_child(child, b);
	print("Added child: ", child);