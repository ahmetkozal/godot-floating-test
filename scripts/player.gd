extends CharacterBody3D

@export var sloop: RigidBody3D
@export var sloop_controls: Node3D
@export var sail_controls: StaticBody3D
@export var mouse_sensitivity: float = 0.0015
@export var speed := 10.0
@export var jump_velocity := 4.5
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head: Node3D = $Head

var on_wheel: bool
var on_sails: bool

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# ROTATE THE WHOLE BODY
		rotate_y(-event.relative.x * mouse_sensitivity)
		# ROTATE THE HEAD UP/DOWN
		head.rotate_x(-event.relative.y * mouse_sensitivity)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_pressed("up"):
		position.y += 10.0 * delta
	if Input.is_action_pressed("down"):
		position.y -= 10.0 * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	if Input.is_action_just_released("jump") and velocity.y>0:
		velocity.y = velocity.y/2

	# Direction relative to where we're facing
	var input_dir := Input.get_vector("left","right","forward","backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	if on_wheel:
		if Input.is_action_pressed("wheel_left"):
			if sloop_controls.rotate_vel >= sloop_controls.MAX_ROTATE_VEL:
				sloop_controls.rotate_vel = sloop_controls.MAX_ROTATE_VEL
			else:
				sloop_controls.rotate_vel += sloop_controls.ADD_ROTATE_DEG
		if Input.is_action_pressed("wheel_right"):
			if sloop_controls.rotate_vel <= sloop_controls.MAX_ROTATE_VEL * -1:
				sloop_controls.rotate_vel = sloop_controls.MAX_ROTATE_VEL *-1
			else:
				sloop_controls.rotate_vel -= sloop_controls.ADD_ROTATE_DEG
	if on_sails:
		if Input.is_action_pressed("sails_down"):
			if sail_controls.vel_to.z <= sail_controls.MAX_VEL:
				sail_controls.vel_to.z = sail_controls.MAX_VEL
			else:
				sail_controls.vel_to.z -= sail_controls.ADD_VEL
		if Input.is_action_pressed("sails_up"):
			if sail_controls.vel_to.z >= 0:
				sail_controls.vel_to.z = 0
			else:
				sail_controls.vel_to.z += sail_controls.ADD_VEL

	move_and_slide()


func _on_wheel_player_on_wheel() -> void:
	on_wheel = true
func _on_wheel_player_not_on_wheel() -> void:
	on_wheel = false
func _on_sails_controls_body_entered(w: Node3D) -> void:
	on_sails = true
func _on_sails_controls_body_exited(body: Node3D) -> void:
	on_sails = false
