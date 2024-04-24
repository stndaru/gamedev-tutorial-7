# Tutorial 7 Game Development CSUI Even Semester 2023/2024
Created by Stefanus Ndaru Wedhatama - 2006526812

## Excercise
Untuk latihan tutorial, saya kurang lebih hanya mengikuti apa yang tertulis di tutorial gamedev ini.

### New Features
#### Sprinting & Crouching
Untuk sprinting dan crouching, saya mengimplementasikan kode berikut
```
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
```

Ketika sprint, maka speed player akan dipercepat dan dapat lompat lebih tinggi dengan mengubah nilai `speed` dan `jump_power`.
Sementara itu, untuk coruching, maka yang pertama dilakukan adalah memperlambat jalan dengan mengurangi `speed`. Lalu, dilakukan transformasi pada karakter supaya terlihat lebih rendah dengan melakukan transformasi.