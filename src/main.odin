package BAPlayer

import rl "vendor:raylib"

main :: proc() {
	Init()
	defer Close()

	rl.InitWindow(800, 450, "BAPlayer")
	defer rl.CloseWindow()

	Load()

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		Update()

		rl.BeginDrawing()
			rl.ClearBackground(rl.RAYWHITE)
			Draw()
			rl.DrawFPS(16, 16)
		rl.EndDrawing()
	}
}


Init :: proc() {

}

Load :: proc() {

}

Update :: proc() {

}

Draw :: proc() {

}

Close :: proc() {

}



