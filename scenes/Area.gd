extends Area

export (String) var sceneName = "Level 1"

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene(str("res://Scenes/" + sceneName + ".tscn"))
