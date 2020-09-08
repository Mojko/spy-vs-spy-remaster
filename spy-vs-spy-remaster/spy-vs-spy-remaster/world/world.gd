extends Node

func start_game(connected_clients):
	PrintHelper.print_client("Players joined in the game: [" + str(connected_clients) + "]");