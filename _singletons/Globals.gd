extends Node


var OWNED : bool = false
var ONLINE : bool = false
var steamID : int = 0
var steamName : String = ""

var steamAppID : int = 2415880
var steamGameID : int = 2415880

var INIT : Dictionary = {}


func _ready() -> void:

	OS.set_environment("SteamAppID", str(steamAppID))
	OS.set_environment("SteamGameID", str(steamAppID))

	INIT = Steam.steamInit()
	if INIT['status'] != 1:
		print(INIT['status'])
		print("Failed to initialize Steam. " + str(INIT['verbal']) + " Shutting down...")
		return

	ONLINE = Steam.loggedOn()
	steamID = Steam.getSteamID()
	steamName = Steam.getPersonaName()
	OWNED = Steam.isSubscribed()


func getSteamStatus() -> Dictionary:
	return INIT


func isGameOwned() -> bool:
	return OWNED


func _process(_delta: float) -> void:
	Steam.run_callbacks()
