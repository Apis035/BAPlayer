# BAPlayer

A music player for Blue Archive's soundtrack. Insprired from Cave Story's Doukutsu BGM (OrganyaView) which plays Cave Story soundtrack with loops.

# Download

Download the compiled app from releases page. For many reasons, only the first 2 soundtracks from the game included in the download.

To obtain more soundtrack, you can either download it from my Drive folder or obtain it yourself from the game data.

## Soundtrack from Drive

- Download the files from [Drive](https://drive.google.com/drive/folders/1zih9ipcKliyOSOILH7t4BANt3BHMvkXj?usp=sharing).
- Extract file contents from `bgm` into `/data/bgm` in BAPlayer directory.

## Soundtrack from game data

- On your android phone (or emulator), using file browser, navigate to `Android/data/com.nexon.bluearchive/files/pub/resource`.
- For each directory in `GameData` and `Preload`, navigate into `MediaResources/Audio/BGM/`.
- Copy all ogg files into your PC (or out from emulator).
- Put all copied ogg files into `/data/bgm` in BAPlayer directory.

# Usage

Currently there are no buttons in the UI for specific operations like pausing or changing track. You can use keyboard buttons instead for such tasks. There are keyboard hint displayed by default to help you identify which keyboard key does something.

- `Left/Right`: Change track.
- `Space`: Pause/resume.
- `1-9`: Jump to track multiple of 10.
- `L`: Toggle looping.
- `F3`: Toggle hint display.
- Drag on progress bar to seek audio.

# Building

To build program from source:

- Download [Odin](https://odin-lang.org/) compiler.
- Add `odin.exe` into system enviroment variable.
- Run `build.bat`.
- Done.

Currently, BAPlayer only work on Windows.

# Library

- [raylib](https://raylib.com/): Rendering
- [BASS](https://www.un4seen.com/): Sound playing and looping