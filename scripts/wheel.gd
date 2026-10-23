extends StaticBody3D

@export var sloop: RigidBody3D
@export var player: CharacterBody3D

signal player_on_wheel
signal player_not_on_wheel 

func _on_area_3d_body_entered(body: Node3D) -> void:
	emit_signal("player_on_wheel")


func _on_area_3d_body_exited(body: Node3D) -> void:
	emit_signal("player_not_on_wheel")
