extends Node

func _ready():
	if(NetworkGlobals.is_server):
		var server_instance = load("res://network-demo/server/server.tscn").instance();
		add_child(server_instance);
	else:
		var client_instance = load("res://network-demo/client/client.tscn").instance();
		add_child(client_instance);