extends Control

@export var menu_scene : PackedScene

@export var in_time : float = 0.5
@export var fade_in_time : float = 1.5
@export var pause_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5

@export var splash_image : TextureRect
@export var message_label : Label
@export var quit_button : Button


func _ready() -> void:
	fade()


func fade() -> void:
	splash_image.modulate.a = 0.0
	var tween : Tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_image, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_image, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	check_steam()


func check_steam() -> void:
	var status : Dictionary = Globals.getSteamStatus()
	if status['status'] == 1:
		if Globals.isGameOwned():
			get_tree().change_scene_to_packed(menu_scene)

	elif status['status'] == 2:
		display_error("Steamworks failed to initialize. Try restarting your game!")

	elif status['status'] == 20:
		display_error("You need to have steam running to play this game!")

	else:
		display_error("Invalid app ID or app not installed")


func display_error(message: String) -> void:
	message_label.text = message
	message_label.show()
	quit_button.show()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
