extends Node2D

enum CONVEYOR_BELT_STATE { RUNNING_LEFT, RUNNING_RIGHT, STOPPED }

@export var state: CONVEYOR_BELT_STATE = CONVEYOR_BELT_STATE.STOPPED
@export var tread_speed: float = 0.1
@export var tread_count = 15

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var path: Path2D = $Path2D

const tread_scene = preload("res://Scenes/Levels/Factory/ConveyorBelt/Tread.tscn")
var path_followers: Array[PathFollow2D] = []
var speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = tread_speed
	create_path_followers()

func _physics_process(delta: float) -> void:
	update_path_follower_progress(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match state:
		CONVEYOR_BELT_STATE.RUNNING_LEFT:
			animated_sprite_2d.play("conveyor_belt_run_left")
			animated_sprite_2d.play()
			speed = -abs(tread_speed)
		CONVEYOR_BELT_STATE.RUNNING_RIGHT:
			animated_sprite_2d.play("conveyor_belt_run_right")
			animated_sprite_2d.play()
			speed = abs(tread_speed)
		CONVEYOR_BELT_STATE.STOPPED:
			animated_sprite_2d.pause()
			speed = 0
			
func create_path_followers():
	for x in range(0, tread_count):
		var path_follower: PathFollow2D = PathFollow2D.new()
		var progress_ratio = float(x) / float(tread_count)
		var tread_scene_instance = tread_scene.instantiate()
		path.add_child(path_follower)
		path_follower.progress_ratio = progress_ratio
		path_follower.add_child(tread_scene_instance)
		path_followers.push_back(path_follower)

func update_path_follower_progress(delta: float):
	for x in range(0, tread_count):
		var path_follower = path_followers[x]
		path_follower.progress_ratio += speed * delta
