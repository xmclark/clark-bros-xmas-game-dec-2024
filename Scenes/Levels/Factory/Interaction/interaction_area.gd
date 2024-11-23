extends Area2D

class_name InteractionArea

@export var action_name: String = "Enter"

var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	if InteractionManager.is_player(body):
		InteractionManager.register_area(self)


func _on_body_exited(body:Node2D) -> void:
	if InteractionManager.is_player(body):
		InteractionManager.unregister_area(self)
