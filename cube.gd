extends RigidBody3D

const WATER_LEVEL: float = 0.0

var water_str:float = 0.2
var sink_time:float = 0.0
var water_force = Vector3.ZERO

var buoyancy_points: Array[Marker3D] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in $BuoyancyPoints.get_children():
		if i.get_class() == "Marker3D":
			buoyancy_points.append(i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(delta: float) -> void:
	for i in buoyancy_points:
		if i.global_position.y < WATER_LEVEL:
			water_force.y = water_str * delta
			apply_impulse(water_force,i.position)
