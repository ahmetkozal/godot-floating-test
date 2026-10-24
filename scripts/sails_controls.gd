extends StaticBody3D

@export var sloop: RigidBody3D
@export var player: CharacterBody3D

var MAX_VEL: float = -2000
const ADD_VEL: float = 2

var vel_to: Vector3


func _physics_process(delta: float) -> void:
	sloop.apply_central_force(sloop.global_basis.z * vel_to.z)
