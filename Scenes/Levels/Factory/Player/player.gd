extends CharacterBody2D

signal state_changed

@export var GRAVITY: float = 100.0
@export var SPEED: float = 100.0
@export var JUMP_FORCE: float = 100.0

@onready var animation_tree: AnimationTree = $AnimationTree

const IDLE_STATE = "IdleState"
const RUNNING_STATE = "RunningState"
const JUMPING_STATE = "JumpingState"
const FALLING_STATE = "FallingState"

var states = {}
var current_state = null
var last_facing_direction = Vector2(0, -1)
var attacking = false

func _ready() -> void:
	states[IDLE_STATE] = $States/IdleState
	states[RUNNING_STATE] = $States/RunningState
	states[JUMPING_STATE] = $States/JumpingState
	states[FALLING_STATE] = $States/FallingState

	set_state(IDLE_STATE)

func _physics_process(delta):
	if current_state:
		current_state.update(self, delta)
	play_animation()
	
func play_animation():
	var idle = !velocity
	
	if !idle:
		last_facing_direction = velocity.normalized()

	animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/Run/blend_position", last_facing_direction)
	animation_tree.set("parameters/Attack/blend_position", last_facing_direction)
	

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
