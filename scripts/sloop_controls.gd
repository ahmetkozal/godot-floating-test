extends Node3D

const MAX_ROTATE_VEL: float = 120.0
const ADD_ROTATE_DEG: float = 0.5

@export var sloop: RigidBody3D

var rotate_vel: float
var rotate_vec: Vector3

func _physics_process(delta: float) -> void:
	
	if rotate_vel >= -5.0 && rotate_vel < 5.0:
		rotate_vec.y = 0
	else:
		rotate_vec.y = rotate_vel
	sloop.apply_torque(rotate_vec)
