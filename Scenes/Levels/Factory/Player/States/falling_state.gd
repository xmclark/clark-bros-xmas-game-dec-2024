extends Node

func enter(_player):
	print("Entered Falling State")

func exit(_player):
	print("Exiting Falling State")

func update(_player, delta):
	_player.velocity.y += _player.GRAVITY * delta
	var direction = Input.get_axis("ui_left", "ui_right")
	_player.velocity.x = direction * _player.SPEED
	_player.move_and_slide()
	if _player.is_on_floor():
		_player.set_idle_state()

func input(_player, _event):
	if _player.is_on_floor():
		if Input.get_axis("ui_left", "ui_right") != 0:
			_player.set_running_state()
		else:
			_player.set_idle_state()
