extends StaticBody3D

const MAX_VEL: float = -600
const ADD_VEL: float = 2
const MAX_SPEED: float = -600

@export var sloop: RigidBody3D
@export var player: CharacterBody3D

var vel_to: Vector3


func _physics_process(delta: float) -> void:
	sloop.apply_central_force(sloop.global_basis.z * vel_to.z)
