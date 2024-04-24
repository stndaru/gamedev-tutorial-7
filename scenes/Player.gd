extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3


onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis

	var movement_vector = Vector3()
	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head_basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head_basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head_basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head_basis.x

	movement_vector = movement_vector.normalized()

	velocity = velocity.linear_interpolate(movement_vector * speed, acceleration * delta)
	velocity.y -= gravity

	if Input.is_action_just_pressed("jump") and is_on_floor():
		if Input.is_action_pressed("sprint"):
			jump_power = 50
		else:
			jump_power = 30
		velocity.y += jump_power
	if Input.is_action_pressed("sprint"):
		speed = 30
	elif Input.is_action_pressed("crouch"):
		speed = 3
		$Head.set_translation(Vector3(0, -1, -0.979))
		$MeshInstance.set_transform(Transform(Vector3(1, 0, 0), Vector3(0, 0, 1), Vector3(0, -0.528, 0), Vector3(0, -0.58, 0)))
		$CollisionShape.set_transform(Transform(Vector3(1, 0, 0), Vector3(0, 0, 1), Vector3(0, -0.528, 0), Vector3(0, -0.58, 0)))
	else:
		speed = 10
		$Head.set_translation(Vector3(0, 1.657, 0))
		$MeshInstance.set_transform(Transform(Vector3(1, 0, 0), Vector3(0, 0, 1), Vector3(0, -1, 0), Vector3(0, 0, 0)))
		$CollisionShape.set_transform(Transform(Vector3(1, 0, 0), Vector3(0, 0, 1), Vector3(0, -1, 0), Vector3(0, 0, 0)))
	

	velocity = move_and_slide(velocity, Vector3.UP)
	
