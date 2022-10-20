extends KinematicBody

onready var MOUSE_SENSITIVITY = 0.3

export var WALK_SPEED = 3
export var SPRINT_SPEED = 6
export var ACCELERATION = 30
export var FRICTION = 30
export var JUMP_HEIGHT = 20
export var GRAVITY = 0.98

export var TURN_SPEED = 3

var velocity = Vector3.ZERO
var held_object = null

func _ready():
	Globals.player = self

func _physics_process(delta):
	#--Prevents player action during Dialogs--
	if Dialogic.has_current_dialog_node(): return
	
	#--Local Variables--
	var lerp_rate = FRICTION
	var speed = WALK_SPEED
	
	#--Input Logic--
	var input_vector = Vector3(Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"), 0,
					   Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down"))
	if input_vector != Vector3.ZERO: lerp_rate = ACCELERATION
	if Input.is_action_pressed("sprint"): speed = SPRINT_SPEED
	if Input.is_action_pressed("interact"): _interact()
	
	#--Rotational Logic--
	if input_vector.x != 0:
		rotation.y += TURN_SPEED * input_vector.x * delta
	input_vector.x = 0
	var direction = input_vector.rotated(Vector3.UP, global_transform.basis.get_euler().y + deg2rad(90)).normalized()
	
	#--Movement--
	velocity = lerp(velocity, direction * speed, lerp_rate * delta)
	#velocity.y -= GRAVITY
	velocity = move_and_slide(velocity, Vector3.UP)

func _interact():
	var items = $InteractArea.get_overlapping_areas()
	if items.size() > 0: 
		items[0].interact()
