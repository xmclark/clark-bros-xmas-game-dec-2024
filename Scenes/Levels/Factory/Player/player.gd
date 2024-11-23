extends CharacterBody2D

signal state_changed

@export var GRAVITY: float = 100.0
@export var SPEED: float = 100.0
@export var JUMP_FORCE: float = 100.0

const IDLE_STATE = "IdleState"
const RUNNING_STATE = "RunningState"
const JUMPING_STATE = "JumpingState"
const FALLING_STATE = "FallingState"

var states = {}
var current_state = null

func _ready() -> void:
	states[IDLE_STATE] = preload("./States/idle_state.gd").new()
	states[RUNNING_STATE] = preload("./States/running_state.gd").new()
	states[JUMPING_STATE] = preload("./States/jumping_state.gd").new()
	states[FALLING_STATE] = preload("./States/falling_state.gd").new()

	set_state(IDLE_STATE)

func _physics_process(delta):
	if current_state:
		current_state.update(self, delta)

func _input(_event):
	var _player = self
	current_state.input(_player, _event)

func set_state(state_name):
	if states[state_name] == current_state:
		return # do nothing if the state is unchanged
	
	if current_state:
		current_state.exit(self)

	current_state = states[state_name]

	if current_state:
		current_state.enter(self)

	emit_signal(state_changed.get_name(), state_name)

func set_falling_state():
	set_state(FALLING_STATE)
	
func set_idle_state():
	set_state(IDLE_STATE)
	
func set_jumping_state():
	set_state(JUMPING_STATE)

func set_running_state():
	set_state(RUNNING_STATE)
