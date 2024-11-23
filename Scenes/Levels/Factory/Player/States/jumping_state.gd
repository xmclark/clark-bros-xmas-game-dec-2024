extends Node

func enter(_player):
	print("Entered Jumping State")
	_player.velocity.y = -_player.JUMP_FORCE

func exit(_player):
	print("Exiting Jumping State")

func update(_player, delta):
	_player.velocity.y += _player.GRAVITY * delta
	var direction = Input.get_axis("ui_left", "ui_right")
	_player.velocity.x = direction * _player.SPEED
	_player.move_and_slide()
	if _player.is_on_floor():
		_player.set_idle_state()
	elif _player.velocity.y > 0:
		_player.set_falling_state()

func input(_player, _event):
	pass