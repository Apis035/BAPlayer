package BAPlayer

import rl "vendor:raylib"
import "core:fmt"
import "core:math"

window: struct {
	width:  i32,
	height: i32,
	title:  cstring,
	fps:    i32,
	flags:  rl.ConfigFlags,
}

font: struct {title, subtitle, time: rl.Font}

player: struct {
	title:    cstring,
	artist:   cstring,
	position: f64,
	length:   f64,
	hover:    f32,
	bg:       rl.Texture,
}

main :: proc() {
	Init()

	rl.SetConfigFlags(window.flags)
	rl.InitWindow(window.width, window.height, window.title)
	defer rl.CloseWindow()

	Load()
	defer Unload()

	rl.SetTargetFPS(window.fps)

	for !rl.WindowShouldClose() {
		Update(rl.GetFrameTime())

		rl.BeginDrawing()
			rl.ClearBackground(rl.BLACK)
			Draw()
			rl.DrawFPS(16, 16)
		rl.EndDrawing()

		free_all(context.temp_allocator)
	}
}


Init :: proc() {
	window.width = 1280
	window.height = 720
	window.title = "BAPlayer"
	window.fps = 30
	window.flags = {.WINDOW_RESIZABLE, .MSAA_4X_HINT}

	player.title = "Luminous Memory"
	player.artist = "Mitsukiyo"
	player.position = 80
	player.length = 200
}

Load :: proc() {
	NOTO_SANS_SC :: "data/font/NotoSans_SemiCondensed-Regular.ttf"

	font.title    = rl.LoadFontEx(NOTO_SANS_SC, 48, nil, 0)
	font.subtitle = rl.LoadFontEx(NOTO_SANS_SC, 32, nil, 0)
	font.time     = rl.LoadFontEx(NOTO_SANS_SC, 24, nil, 0)

	player.bg = rl.LoadTexture("data/image/BG_CS_PV2_71.jpg")
	rl.SetTextureFilter(player.bg, .BILINEAR)
}

Unload :: proc() {
	rl.UnloadFont(font.title)
	rl.UnloadFont(font.subtitle)
	rl.UnloadFont(font.time)
}

/*****************************************************************************/

PADDING :: 32

TITLE_YOFFSET  :: -40
ARTIST_YOFFSET :: -70
TIME_XOFFSET   :: 14
TIME_YOFFSET   :: -22

BAR_HEIGHT         :: 10
BAR_HOVER_DISTANCE :: 20
BAR_HOVER_SPEED    :: 8

Update :: proc(dt: f32) {
	if rl.GetMousePosition().y > cast(f32)window.height - (BAR_HEIGHT + BAR_HOVER_DISTANCE) {
		player.hover = rl.Lerp(player.hover, BAR_HOVER_DISTANCE, BAR_HOVER_SPEED * dt)
	} else {
		player.hover = rl.Lerp(player.hover, 0, BAR_HOVER_SPEED * dt)
	}

	if rl.IsWindowResized() {
		window.width  = rl.GetScreenWidth()
		window.height = rl.GetScreenHeight()
	}
}

Draw :: proc() {
	BOTTOM_LEFT  := rl.Vector2{0, cast(f32)window.height}                     + {PADDING,  -PADDING}
	BOTTOM_RIGHT := rl.Vector2{cast(f32)window.width, cast(f32)window.height} + {-PADDING, -PADDING}

	/* Background */
	DrawTextureCenter(player.bg, 0.75)

	/* Artist, title */
	rl.DrawTextEx(font.title,    player.title,  BOTTOM_LEFT + {0, TITLE_YOFFSET  + -player.hover}, cast(f32)font.title.baseSize,    0, rl.WHITE)
	rl.DrawTextEx(font.subtitle, player.artist, BOTTOM_LEFT + {0, ARTIST_YOFFSET + -player.hover}, cast(f32)font.subtitle.baseSize, 0, rl.WHITE)

	/* Time */
	cm, cs := TimeToMinSec(player.position)
	lm, ls := TimeToMinSec(player.length)
	time := fmt.ctprintf("%02d:%02d / %02d:%02d", cm, cs, lm, ls)
	titleWidth := rl.MeasureTextEx(font.title, player.title, cast(f32)font.title.baseSize, 0).x
	rl.DrawTextEx(font.time, time, BOTTOM_LEFT + {titleWidth + TIME_XOFFSET, TIME_YOFFSET + -player.hover}, cast(f32)font.time.baseSize, 0, rl.WHITE)

	/* Progress bar background */
	barHover := BAR_HEIGHT + cast(i32)math.floor(player.hover)
	rl.DrawRectangle(0, window.height - barHover, window.width, barHover, rl.GRAY)

	/* Progress bar current position */
	barProgWidth := i32(player.position/player.length * cast(f64)window.width)
	rl.DrawRectangle(0, window.height - barHover, barProgWidth, barHover, rl.ORANGE)
}