extends Node

func enter(_player):
	print("Entered Running State")

func exit(_player):
	print("Exiting Running State")

func update(_player, delta):
	_player.velocity.y += _player.GRAVITY * delta
	var direction = Input.get_axis("ui_left", "ui_right")
	_player.velocity.x = direction * _player.SPEED
	_player.move_and_slide()
	if not _player.is_on_floor():
		_player.set_falling_state()

func input(_player, _event):
	if Input.is_action_just_pressed("ui_up") and _player.is_on_floor():
		_player.set_jumping_state()
	elif Input.get_axis("ui_left", "ui_right") != 0:
		_player.set_running_state()
	else:
		_player.set_idle_state()