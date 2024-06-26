package BAPlayer

import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 450, "BAPlayer")
	defer rl.CloseWindow()

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
			rl.ClearBackground(rl.RAYWHITE)
			rl.DrawFPS(16, 16)
		rl.EndDrawing()
	}
}
