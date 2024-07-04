package BAPlayer

import rl "vendor:raylib"

DrawTextureCenter :: proc(texture: rl.Texture, alpha: f32) {
    tw, th := f32(texture.width), f32(texture.height)
    ww, wh := f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight())
    scale  := (ww/wh > tw/th) ? (ww/tw) : (wh/th)
    source := rl.Rectangle{0, 0, tw, th}
    dest   := rl.Rectangle{ww/2, wh/2, tw * scale, th * scale}
    origin := rl.Vector2{tw/2 * scale, th/2 * scale}
    rl.DrawTexturePro(texture, source, dest, origin, 0, rl.Fade(rl.WHITE, alpha))
}

DrawTextShadow :: proc(font: rl.Font, text: cstring, position: rl.Vector2) {
    BLACK :: rl.Color{0, 0, 0, 128}
    OFFSET :: rl.Vector2{2, 2}
    rl.DrawTextEx(font, text, position + OFFSET, cast(f32)font.baseSize, 0, BLACK)
    rl.DrawTextEx(font, text, position, cast(f32)font.baseSize, 0, rl.WHITE)
}

TimeToMinSec :: proc(time: f64) -> (min, sec: i32) {
    time := cast(i32)time
    min = time / 60
    sec = time % 60
    return min, sec
}