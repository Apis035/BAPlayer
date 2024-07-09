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
    bg:       string,
}

LoopPoint :: struct {
	begin, end: f64,
}

DEFAULT_BG :: "BG_CS_PV2_71"

bgmTotal := len(db.bgm)-1

@(private="file")
db := Database {
    artist = {
        0 = "Mitsukiyo",
        1 = "KARUT",
        2 = "Nor",
    },
    bgm = {
        {/* 0 */},
        {"01", "Constant Moderato", 0, 112, {0, 137.143},      "BG_CS_PR_06"},
        {"02", "Luminous Memory",   0, 100, {39, 135},         "BG_CS_Trinity_02"},
        {"03", "Mischievous Step",  0, 102, {0, 150.588},      "BG_Park"},
        {"04", "Lovely Picnic",     0, 125, {15.36, 138.24},   "BG_CS_Abydos_04"},
        {"05", "Colorful Mess",     1, 172, {44.651, 111.628}, "BG_GehennaCampus"},
        {"06", "Funky Road",        1, 103, {18.641, 130.485}, "BG_View_Abydos"},
        {"07", "Unwelcome School",  0, 180, {0, 117.333},      "BG_KohshinjoRoom"},
        {"08", "Shady Girls",       0, 112, {0, 154.286},      "BG_BlackMarket_Night"},
        {"09", "Midsummer Cat",     0, 100, {0, 139.200},      "BG_CS_Abydos_02"},
        {"10", "Romantic Smile",    0, 117, {0, 133.333},      "BG_ResidenceArea"},
        {"11", "Connected Sky",     1, 133, {57.744, 115.489}, "BG_View_Sky_Night"},
        {"12", "Shooting Stars",    1, 110, {0, 113.455},      "BG_CommitteeRoom_Night"},
        {"13", "Barrier",           1, 112, {17.143, 120},     "BG_SchoolFrontGate"},
        {"14", "Step by Step",      1, 120, {32, 128},         "BG_MainOffice"},
        {"15", "Honey Jam",         0, 154, {25.714, 137.922}, "BG_BigPlaza_Sunset"},
        {"16", "MX Adventure",      0, 102, {0, 112.941},      "BG_CityDowntown"},
        {"17", "Irashaimase",       0, 106, {0, 129.057},      "BG_Shop"},
        {"18", "Mechanical JUNGLE", 1, 145, {66.207, 119.172}, "BG_DemolitionCity"},
        {"19", "Virtual Storm",     1, 140, {13.714, 123.429}, "BG_RailWay"},
        {"20", "Tech N Tech",       1, 155, {49.548, 123.871}, "BG_SubwayHall"},
        {"21", "Midnight Trip",     2, 75,  {0, 92.8},         "BG_Park_Night"},
        {"22", "Daily Routine 247", 2, 116, {0, 115.862},      "BG_AronaRoom_In"},
        {"23", "Party Time",        2, 138, {0, 76.522},       "BG_IndoorPlayGround"},
        {"24", "Endless Carnival",  0, 162, {82.963, 142.222}, "BG_CS_PV4_045"},
        {"25", "Future Bossa",      0, 180, {9.667, 127},      "BG_ClassRoom2"},
        {"26", "Lemonade Diary",    0, 120, {0, 152},          "BG_ModernCafe"},
        {"27", "Fade Out",          1, 170, {0, 90.353},       "BG_CS_Arius_05"},
        {"28", "Plug and Play",     1, 124, {15.484, 123.871}, "BG_Wilderness"},
        {"29", "Alert",             1, 132, {29.091, 116.364}, "BG_CityOffice_Ruin"},
        {"30", "CrossFire",         1, 160, {12, 109.5},       "BG_UndergroundPassage"},
        {"31", "Hello to Halo",     2, 174, {0, 104.828},      "BG_CS_Millenium_58"},
        {"32", "GGF",               2, 172, {0, 111.628},      "BG_CS_Gehenna_01"},
        {"33", "Vivid Night",       2, 110, {17.455, 104.727}, "BG_FineDining_Night"},
        {"34", "Aoharu",            2, 100, {0, 108},          "BG_CS_PR_10"},
        {"35", "Morose Dreamer",    0, 70,  {0, 141.208},      "BG_CS_Trinity_11_1"},
        {"36", "Koi is Love",       0, 120, {16.5, 104.5},     "BG_Rooftop"},
        {"37", "Aira",              0, 69,  {27.391, 131.739}, "BG_CS_Trinity_14_1"},
        {"38", "Guruguru Usagi",    0, 131, {0, 135.573},      "BG_Infirmary"},
        {"39", "Water Drop",        1, 138, {13.913, 125.217}, "BG_RiverCityDownTown_Night"},
        {"40", "Neo City Dive",     1, 130, {29.538, 132.923}, "BG_MilleniumCorridor_Night"},
        {"41", "Interface",         1, 132, {58.182, 116.364}, "BG_SlumFront"},
        {"42", "Glitch Street",     1, 160, {48, 120},         "BG_CS_PV2_68"},
        {"43", "KIRISAME",          2, 155, {12, 112.645},     "BG_HyakkiyakoFestivalRoad"},
        {"44", "Walkthrough",       2, 160, {0, 108},          "BG_Auditorium"},
        {"45", "Signal of Abydos",  2, 110, {52.364, 113.455}, "BG_CS_Abydos_08"},
        {"46", "Sugar Story",       2, 72,  {26.667, 106.667}, "BG_CS_Abydos_10"},
        {"47", "Coffee Cats",       0, 194, {90.309, 170.722}, "BG_TrinityTerrace"},
        {"48", "Out of Control",    1, 178, {86.292, 129.438}, "BG_CS_PV4_051"},
        {"49", "Mechanical JUNGLE (Hi-Tech Full On MIX)", 1, 155, {24.774, 123.871}, "BG_CS_Millenium_11"},
        {"50", "Hue",               1, 170, {11.294, 112.941}, "BG_TrinityClassRoom_Sunset"},
        {"51", "ARES",              2, 170, {45.176, 112.941}, "BG_View_KivotosStadium"},
        {"52", "Vibes",             2, 170, {0, 135.529},      "BG_CS_Trinity_03"},
        {"53", "Future Lab",        2, 160, {0, 120},          "BG_CraftChamber_Night"},
        {"54", "After the Beep",    2, 162, {0, 118.519},      "BG_Arcade"},
        {"55", "Moment",            2, 0,   {0, 102.037},      "BG_CS_Rabbit_07"},
        {"56", "Fearful Utopia",    2, 172, {27.907, 117.209}, "BG_CS_PV4_048"},
        {"57", "Han-nari",          2, 155, {0, 102.194},      "BG_CS_Hyakkiyako_01"},
        {"58", "SAKURA PUNCH",      2, 128, {45, 120},         "BG_RiversideRoad"},
        {"59", "RE Aoharu",         2, 180, {42.667, 133.333}, "BG_CS_PV4_074_3"},
        {"60", "SAKURA PUNCH (Hard Arrange)", 2, 128, {30, 120}, "BG_RiversideRoad_Night"},
        {"61", "Rolling Beat",      0, 170, {24, 148.235},     "BG_HQ"},
        {"62", "Merry Blue",        0, 120, {22, 114},         "BG_CityDowntown2"},
        {"63", "Blooming Moon",     0, 160, {24, 120},         "BG_HyakkiyakoObservatory_Night"},
        {"64", "Pixel Time",        0, 120, {16.5, 128.5},     "BG_GameDevRoom"},
        {"65", "Accelerator",       1, 174, {10.345, 109.655}, "BG_HQ2"},
        {"66", "Golden Shangri-la", 1, 107, {0, 107.664},      "BG_ShanCampus"},
        {"67", "Someday, sometime", 1, 65,  {81.231, 110.769}, "BG_CS_S1Final_30_5"},
        {"68", "Virtual Storm (Hard Arrange)", 0, 135, {28.444, 113.778}, "BG_RailWay_Night2"},
        {"69", "Snow Pantomime",    0, 166, {57.831, 138.795}, "BG_WinterRoad"},
        {"70", "Black Suit",        1, 80,  {12, 108},         "BG_CS_RAID_01"},
        {"71", "Denshi Toujou!",    1, 154, {13.247, 112.987}, ""},
        {"72", "Kaiten Screw!!!",   1, 165, {11.636, 128},     ""},
        {"73", "Interface (Hard Arrange)", 0, 130, {29.538, 118.154}, "BG_SlumFront_Night"},
        {"74", "Tech N Tech (Hard Arrange)", 1, 150, {12.8, 115.2}, "BG_SubwayHall_Night"},
        {"75", "Alert (Hard Arrange)", 1, 145, {39.724, 119.172}, "BG_CS_PV2_56"},
        {"76", "CrossFire (Hard Arrange)", 1, 145, {26.483, 132.414}, "BG_UndergroundPassage_Night"},
        {"77", "Burning Love",      0, 160, {24.375, 120.375}, "BG_CS_Event_06"},
        {"78", "Fever Time",        1, 140, {0, 113.143},      ""},
        {"79", "Summer Bounce",     0, 180, {21.333, 138.667}, "BG_BeachFrontSide"},
        {"80", "Colorful Beach",    0, 125, {15.36, 122.88},   "BG_Beachside"},
        {"81", "Summer Bounce (Hard Arrange)", 1, 174, {22.069, 110.345}, "BG_BeachFrontSide_Night"},
        {"82", "Hifumi Daisuki",    0, 163, {23.558, 117.791}, ""},
    }
}

DatabaseGet :: proc(track: int) -> (
    audio:  cstring,
    title:  cstring,
    artist: cstring,
    bpm:    i32,
    loop:   LoopPoint,
    bg:     cstring,
) {
    return DatabaseGetAudio(track),
           DatabaseGetTitle(track),
           DatabaseGetArtist(track),
           DatabaseGetBpm(track),
           DatabaseGetLoop(track),
           DatabaseGetBg(track)
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

DatabaseGetBg :: proc(track: int) -> cstring {
    if db.bgm[track].bg != "" {
        return fmt.ctprintf("data/bg/%s.jpg", db.bgm[track].bg)
    } else {
        return nil
    }
}