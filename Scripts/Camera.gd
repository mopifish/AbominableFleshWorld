extends Camera

var turn_speed = 10
var base_rotation = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.camera = self

func _process(delta):
	var to_target = Globals.player.global_transform.origin - global_transform.origin
	var r_dot = to_target.dot(global_transform.basis.x)
	var u_dot = to_target.dot(global_transform.basis.y)
	
	turn_speed = 10 + r_dot

	#rotation_degrees.y += turn_speed  * -r_dot * delta
	#rotation_degrees.x += turn_speed  * u_dot * delta
	rotation_degrees = base_rotation
	
	rotation_degrees.y = clamp(rotation_degrees.y, base_rotation.y - 5, base_rotation.y + 5)
	rotation_degrees.x = clamp(rotation_degrees.x, base_rotation.x - 5, base_rotation.x + 5)
	
