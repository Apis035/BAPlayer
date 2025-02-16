package BAPlayer

DEBUG :: true
VERSION :: "v0.1"
TITLE :: "BAPlayer " + VERSION

import rl "vendor:raylib"
import "core:fmt"
import "core:math"
import "../bass"

window: struct {
	width:  i32,
	height: i32,
	title:  cstring,
	fps:    i32,
	flags:  rl.ConfigFlags,
}

font: struct {title, subtitle, time: rl.Font}

player: struct {
	// Loaded from database
	stream:     bass.HSTREAM,
	title:      cstring,
	artist:     cstring,
	bpm:        i32,
	loop:       LoopPoint,
	// Audio state
	position:   f64,
	length:     f64,
	pause:      bool,
	enableLoop: bool,
	// Other
	hover:      f32,
	bg:         rl.Texture,
}

defaultBg: rl.Texture

track: int
drawHint: bool

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
			when DEBUG do rl.DrawFPS(16, 16)
		rl.EndDrawing()

		free_all(context.temp_allocator)
	}
}


Init :: proc() {
	window.width = 1280
	window.height = 720
	window.title = TITLE
	window.fps = 30
	window.flags = {.WINDOW_RESIZABLE, .MSAA_4X_HINT}
	drawHint = true
}

Load :: proc() {
	NOTO_SANS_SC :: "data/font/NotoSans_SemiCondensed-Regular.ttf"

	font.title    = rl.LoadFontEx(NOTO_SANS_SC, 48, nil, 0)
	font.subtitle = rl.LoadFontEx(NOTO_SANS_SC, 32, nil, 0)
	font.time     = rl.LoadFontEx(NOTO_SANS_SC, 24, nil, 0)

	defaultBg = rl.LoadTexture("data/bg/" + DEFAULT_BG + ".jpg")
	rl.SetTextureFilter(defaultBg, .BILINEAR)

	bass.Init(-1, 44100, 0, nil, nil)

	player.enableLoop = true
	track = 1
	PlayerChangeTrack(track)
}

Unload :: proc() {
	rl.UnloadFont(font.title)
	rl.UnloadFont(font.subtitle)
	rl.UnloadFont(font.time)

	bass.Free()
}

/*****************************************************************************/

PADDING :: 32

TITLE_YOFFSET  :: -40
ARTIST_YOFFSET :: -70
TRACK_YOFFSET  :: -88
TIME_XOFFSET   :: 14
TIME_YOFFSET   :: -22

BAR_HEIGHT         :: 10
BAR_HOVER_DISTANCE :: 20
BAR_HOVER_SPEED    :: 8

Update :: proc(dt: f32) {
	mousePos := rl.GetMousePosition()
	if mousePos.y > cast(f32)window.height - (BAR_HEIGHT + BAR_HOVER_DISTANCE) {
		player.hover = rl.Lerp(player.hover, BAR_HOVER_DISTANCE, BAR_HOVER_SPEED * dt)

		if rl.IsMouseButtonDown(.LEFT) {
			seekTo := cast(f64)mousePos.x/cast(f64)window.width * player.length
			bass.ChannelSetPosition(player.stream, bass.ChannelSeconds2Bytes(player.stream, seekTo), bass.POS_BYTE)
		}
	} else {
		player.hover = rl.Lerp(player.hover, 0, BAR_HOVER_SPEED * dt)
	}

	if rl.IsWindowResized() {
		window.width  = rl.GetScreenWidth()
		window.height = rl.GetScreenHeight()
	}

	player.position = bass.ChannelBytes2Seconds(player.stream, bass.ChannelGetPosition(player.stream, bass.POS_BYTE))

	if player.stream != 0 && player.position == player.length {
		if track < bgmTotal {
			track += 1
			PlayerChangeTrack(track)
		}
	}

	{
		prevTrack := track
		defer if prevTrack != track {
			PlayerChangeTrack(track)
		}
		switch {
		case rl.IsKeyPressed(.ZERO):  track = 1
		case rl.IsKeyPressed(.ONE):   track = 10
		case rl.IsKeyPressed(.TWO):   track = 20
		case rl.IsKeyPressed(.THREE): track = 30
		case rl.IsKeyPressed(.FOUR):  track = 40
		case rl.IsKeyPressed(.FIVE):  track = 50
		case rl.IsKeyPressed(.SIX):   track = 60
		case rl.IsKeyPressed(.SEVEN): track = 70
		case rl.IsKeyPressed(.EIGHT): track = 80
		}
	}

	if rl.IsKeyPressed(.LEFT) || rl.IsKeyPressedRepeat(.LEFT) {
		if track > 1 {
			track -= 1
			PlayerChangeTrack(track)
		}
	}
	if rl.IsKeyPressed(.RIGHT) || rl.IsKeyPressedRepeat(.RIGHT) {
		if track < bgmTotal {
			track += 1
			PlayerChangeTrack(track)
		}
	}

	if rl.IsKeyPressed(.SPACE) {
		player.pause = !player.pause
		if player.pause {
			bass.ChannelPause(player.stream)
		} else {
			bass.ChannelPlay(player.stream, false)
		}
	}

	if rl.IsKeyPressed(.L) {
		player.enableLoop = !player.enableLoop
		if player.enableLoop {
			bass.ChannelFlags(player.stream, bass.SAMPLE_LOOP, bass.SAMPLE_LOOP)
			bass.ChannelSetPosition(player.stream, bass.ChannelSeconds2Bytes(player.stream, player.loop.end), bass.POS_END)
		} else {
			bass.ChannelFlags(player.stream, 0, bass.SAMPLE_LOOP)
			bass.ChannelSetPosition(player.stream, bass.ChannelGetLength(player.stream, bass.POS_BYTE), bass.POS_END)
		}
	}

	if rl.IsKeyPressed(.F3) {
		drawHint = !drawHint
	}
}

Draw :: proc() {
	TOP_RIGHT    := rl.Vector2{cast(f32)window.width, 0}                      + {-PADDING, PADDING}
	BOTTOM_LEFT  := rl.Vector2{0, cast(f32)window.height}                     + {PADDING,  -PADDING}
	BOTTOM_RIGHT := rl.Vector2{cast(f32)window.width, cast(f32)window.height} + {-PADDING, -PADDING}

	/* Background */
	{
		bg := player.bg.id != 0 ? player.bg : defaultBg
		DrawTextureCenter(bg, 0.9)
	}

	/* Artist, title */
	{
		titlePos    := BOTTOM_LEFT + {0, TITLE_YOFFSET  + -player.hover}
		subtitlePos := BOTTOM_LEFT + {0, ARTIST_YOFFSET + -player.hover}
		DrawTextShadow(font.title,    player.title,  titlePos)
		DrawTextShadow(font.subtitle, player.artist, subtitlePos)
	}

	/* Track */
	{
		trackText := fmt.ctprintf("#%d", track)
		trackPos  := BOTTOM_LEFT + {0, TRACK_YOFFSET + -player.hover}
		DrawTextShadow(font.time, trackText, trackPos)
	}

	/* Time */
	{
		cm, cs := TimeToMinSec(player.position)
		lm, ls := TimeToMinSec(player.length)
		time := fmt.ctprintf("%02d:%02d / %02d:%02d", cm, cs, lm, ls)
		titleWidth := rl.MeasureTextEx(font.title, player.title, cast(f32)font.title.baseSize, 0).x
		timePos := BOTTOM_LEFT + {titleWidth + TIME_XOFFSET, TIME_YOFFSET + -player.hover}
		DrawTextShadow(font.time, time, timePos)
	}

	/* Keyboard keys hint */
	KEYBOARD_HINTS :: []cstring {
		"<F3>: toggle this hint",
		"<L>: toggle loop",
		"<1-9>: jump track",
		"<Space>: pause/resume",
		"<Left/Right>: change track",
	}

	if drawHint {
		y: f32
		for hint, i in KEYBOARD_HINTS {
			font := font.time
			size := rl.MeasureTextEx(font, hint, cast(f32)font.baseSize, 0)
			pos  := TOP_RIGHT + {-size.x, y - 8}
			y += size.y
			DrawTextShadow(font, hint, pos)
		}
	}

	/* Progress bar background */
	barHover := BAR_HEIGHT + cast(i32)math.floor(player.hover)
	rl.DrawRectangle(0, window.height - barHover, window.width, barHover, rl.GRAY)

	/* Progress bar current position */
	barProgWidth := i32(player.position/player.length * cast(f64)window.width)
	rl.DrawRectangle(0, window.height - barHover, barProgWidth, barHover, rl.ORANGE)

	/* Loop position */
	if player.enableLoop {
		loopBeginX := i32(player.loop.begin/player.length * cast(f64)window.width)
		loopEndX   := i32(player.loop.end  /player.length * cast(f64)window.width)
		rl.DrawRectangle(loopBeginX, window.height - barHover, 4, barHover, rl.MAROON)
		rl.DrawRectangle(loopEndX-4, window.height - barHover, 4, barHover, rl.MAROON)
	}
}

/*****************************************************************************/

PlayerChangeTrack :: proc(track: int) {
	/* Free current audio */
	if player.stream != 0 {
		bass.StreamFree(player.stream)
	}

	/* Unload bg */
	rl.UnloadTexture(player.bg)

	audio, title, artist, bpm, loop, bg := DatabaseGet(track)
	player.stream = bass.StreamCreateFile(false, bass.raw(audio), 0, 0, 0)
	player.title = title
	player.artist = artist
	player.bpm = bpm
	player.loop = loop
	player.length = bass.ChannelBytes2Seconds(player.stream, bass.ChannelGetLength(player.stream, bass.POS_BYTE))
	player.bg = rl.LoadTexture(bg)
	rl.SetTextureFilter(player.bg, .BILINEAR)

	bass.ChannelSetPosition(player.stream, bass.ChannelSeconds2Bytes(player.stream, player.loop.begin), bass.POS_LOOP)
	if player.enableLoop {
		bass.ChannelSetPosition(player.stream, bass.ChannelSeconds2Bytes(player.stream, player.loop.end), bass.POS_END)
		bass.ChannelFlags(player.stream, bass.SAMPLE_LOOP, bass.SAMPLE_LOOP)
	}

	bass.ChannelPlay(player.stream, true)
	player.pause = false
}