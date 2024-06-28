package BAPlayer

import "core:fmt"
import "core:strings"

Database :: struct {
	artist: []string,
	bgm:    []BGM,
}

BGM :: struct {
	audio:    string,
	title:    string,
	artistId: int,
	bpm:      int,
	loop:     LoopPoint,
}

LoopPoint :: struct {
	begin, end: f64,
}

bgmTotal := len(db.bgm)-1

@(private="file")
db := Database {
    artist = {
        /* 0 */ "Mitsukiyo",
        /* 1 */ "KARUT",
        /* 2 */ "Nor",
    },
    bgm = {
        {/* 0 */},
        {"01", "Constant Moderato", 0, 112, {0, 100}},
        {"02", "Luminous Memory",   0, 100, {39, 135}},
        {"03", "Mischievous Step",  0, 102, {0, 100}},
        {"04", "Lovely Picnic",     0, 125, {15.36, 138.24}},
        {"05", "Colorful Mess",     1, 172, {44.651, 111.628}},
        {"06", "Funky Road",        1, 103, {18.641, 130.485}},
    }
}

DatabaseGet :: proc(track: int) -> (
    audio:  cstring,
    title:  cstring,
    artist: cstring,
    bpm:    i32,
    loop:   LoopPoint,
) {
    return DatabaseGetAudio(track),
           DatabaseGetTitle(track),
           DatabaseGetArtist(track),
           DatabaseGetBpm(track),
           DatabaseGetLoop(track)
}

DatabaseGetAudio :: proc(track: int) -> cstring {
    return fmt.ctprintf("data/bgm/Theme_%s.ogg", db.bgm[track].audio)
}

DatabaseGetTitle :: proc(track: int) -> cstring {
    return strings.clone_to_cstring(db.bgm[track].title)
}

DatabaseGetArtist :: proc(track: int) -> cstring {
    return strings.clone_to_cstring(db.artist[db.bgm[track].artistId])
}

DatabaseGetBpm :: proc(track: int) -> i32 {
    return cast(i32)db.bgm[track].bpm
}

DatabaseGetLoop :: proc(track: int) -> LoopPoint {
    return db.bgm[track].loop
}