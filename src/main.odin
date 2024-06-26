package BAPlayer

import rl "vendor:raylib"

window: struct {
	width:  i32,
	height: i32,
	title:  cstring,
	fps:    i32,
	flags:  rl.ConfigFlags,
}

main :: proc() {
	Init()
	defer Close()

	rl.SetConfigFlags(window.flags)
	rl.InitWindow(window.width, window.height, window.title)
	defer rl.CloseWindow()

	Load()

	rl.SetTargetFPS(window.fps)

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
	window.width = 1280
	window.height = 720
	window.title = "BAPlayer"
	window.fps = 30
	window.flags = {.WINDOW_RESIZABLE, .MSAA_4X_HINT}
}

Load :: proc() {

}

Update :: proc() {

}

Draw :: proc() {

}

Close :: proc() {

}



