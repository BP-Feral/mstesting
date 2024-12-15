extends CharacterBody2D


@export var speed : float = 200.0

@export var animation_tree : AnimationTree

var direction : Vector2 = Vector2.ZERO


func _ready() -> void:
	animation_tree.active = true

func _process(_delta: float) -> void:
	update_animation_parameters()

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized()

	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_walking"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true

	if direction != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
