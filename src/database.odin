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
        {"01", "Constant Moderato", 0, 112, {0, 137.143}},
        {"02", "Luminous Memory",   0, 100, {39, 135}},
        {"03", "Mischievous Step",  0, 102, {0, 150.588}},
        {"04", "Lovely Picnic",     0, 125, {15.36, 138.24}},
        {"05", "Colorful Mess",     1, 172, {44.651, 111.628}},
        {"06", "Funky Road",        1, 103, {18.641, 130.485}},
        {"07", "Unwelcome School",  0, 180, {0, 117.333}},
        {"08", "Shady Girls",       0, 112, {0, 154.286}},
        {"09", "Midsummer Cat",     0, 100, {0, 139.200}},
        {"10", "Romantic Smile",    0, 117, {0, 133.333}},
        {"11", "Connected Sky",     1, 133, {57.744, 115.489}},
        {"12", "Shooting Stars",    1, 110, {0, 113.455}},
        {"13", "Barrier",           1, 112, {17.143, 120}},
        {"14", "Step by Step",      1, 120, {32, 128}},
        {"15", "Honey Jam",         0, 154, {25.714, 137.922}},
        {"16", "MX Adventure",      0, 102, {0, 112.941}},
        {"17", "Irashaimase",       0, 106, {0, 129.057}},
        {"18", "Mechanical JUNGLE", 1, 145, {66.207, 119.172}},
        {"19", "Virtual Storm",     1, 140, {13.714, 123.429}},
        {"20", "Tech N Tech",       1, 155, {49.548, 123.871}},
        {"21", "Midnight Trip",     2, 75,  {0, 92.8}},
        {"22", "Daily Routine 247", 2, 116, {0, 115.862}},
        {"23", "Party Time",        2, 138, {0, 76.522}},
        {"24", "Endless Carnival",  0, 162, {82.963, 142.222}},
        {"25", "Future Bossa",      0, 180, {9.667, 127}},
        {"26", "Lemonade Diary",    0, 120, {0, 152}},
        {"27", "Fade Out",          1, 170, {0, 90.353}},
        {"28", "Plug and Play",     1, 124, {15.484, 123.871}},
        {"29", "Alert",             1, 132, {29.091, 116.364}},
        {"30", "CrossFire",         1, 160, {12, 109.5}},
        {"31", "Hello to Halo",     2, 174, {0, 104.828}},
        {"32", "GGF",               2, 172, {0, 111.628}},
        {"33", "Vivid Night",       2, 110, {17.455, 104.727}},
        {"34", "Aoharu",            2, 100, {0, 108}},
        {"35", "Morose Dreamer",    0, 70,  {0, 141.208}},
        {"36", "Koi is Love",       0, 120, {16.5, 104.5}},
        {"37", "Aira",              0, 69,  {27.391, 131.739}},
        {"38", "Guruguru Usagi",    0, 131, {0, 135.573}},
        {"39", "Water Drop",        1, 138, {13.913, 125.217}},
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