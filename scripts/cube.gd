extends RigidBody3D

@export var water_level: float = 0.0
@export var desired_sink: float = 0.8 # Agirlik arttikca azalacak
@export var drag_factor: float = 2.0

@export var buoyancy_points: Array[Node3D] = []

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var water_str: float
var in_water: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if buoyancy_points.size() > 0:
		water_str = (mass * gravity) / (desired_sink * buoyancy_points.size())
	else:
		push_error("NO BUOYANCY POINTS")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	in_water = false
	print("gemi y: ", global_position.y, " water_str: ", water_str, " desired_sink: ", desired_sink, " mass: ", mass)
	for i in buoyancy_points:
		print("  marker y: ", i.global_position.y, " su altında: ", i.global_position.y < water_level)
		if i.global_position.y < water_level:
			in_water = true
			var sink_depth = water_level - i.global_position.y
			var force:Vector3 = Vector3.UP * water_str * sink_depth
			apply_force(force,i.global_position - global_position)
			print("marker y: ", i.global_position.y, " water_level: ", water_level)
	if in_water:
		var f_drag:Vector3 = drag_factor * mass * linear_velocity *-1
		apply_central_force(f_drag)
