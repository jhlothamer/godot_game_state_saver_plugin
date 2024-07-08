class_name Player
extends CharacterBody2D


@export var speed := 300.0

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _interaction_area: InteractionArea2D = $InteractionArea2D


var disabled := false
var facing_direction := Vector2.DOWN: set = _set_facing_direction


func _set_facing_direction(value: Vector2) -> void:
	facing_direction = value
	if value == Vector2.UP:
		_animated_sprite.play("up")
	elif value == Vector2.DOWN:
		_animated_sprite.play("down")
	elif value == Vector2.LEFT:
		_animated_sprite.play("left")
	elif value == Vector2.RIGHT:
		_animated_sprite.play("right")


func _physics_process(_delta):
	if disabled:
		return
	
	_handle_interaction()
	
	var v = _get_move_vector()
	if v == Vector2.ZERO:
		return
	face_direction(v)
	v = v.normalized()*speed
	set_velocity(v)
	move_and_slide()
	var _discard = velocity


func _get_move_vector() -> Vector2:
	var v := Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		v.y += 1
	if Input.is_action_pressed("ui_up"):
		v.y -= 1
	if Input.is_action_pressed("ui_right"):
		v.x += 1
	if Input.is_action_pressed("ui_left"):
		v.x -= 1
	
	return v


func _handle_interaction():
	if !Input.is_action_just_pressed("interact"):
		return
	_interaction_area.start_interaction_with_closest_interactable_object(self)
	

func face_direction(v: Vector2) -> void:
	if v.x < 0:
		self.facing_direction = Vector2.LEFT
	elif v.x > 0:
		self.facing_direction = Vector2.RIGHT
	elif v.y < 0:
		self.facing_direction = Vector2.UP
	elif v.y > 0:
		self.facing_direction = Vector2.DOWN
