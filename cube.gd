extends RigidBody3D

const WATER_LEVEL: float = 0.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var water_str: float = 0.0
var sloop_mass:float = 0.0
var desired_sink: float = 0.0
var buoyancy_points: Array[Marker3D] = []
var in_water: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in $BuoyancyPoints.get_children():
		if i.get_class() == "Marker3D":
			buoyancy_points.append(i)
	sloop_mass = self.mass
	desired_sink = 0.8
	# water_str = mass * gravity / istenen_sink_depth
	water_str = (sloop_mass * gravity) / (desired_sink * buoyancy_points.size())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	in_water = false
	for i in buoyancy_points:
		if i.global_position.y < WATER_LEVEL:
			in_water = true
			var sink_depth = WATER_LEVEL - i.global_position.y
			var force:Vector3 = Vector3.UP * water_str * sink_depth
			apply_force(force,i.global_position - global_position)
	if in_water:
		var k:float = sloop_mass * 2
		var f_drag:Vector3 = k * linear_velocity *-1
		apply_central_force(f_drag)
