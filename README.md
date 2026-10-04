# WinClicker

A gorgeous, tiny, native auto clicker for Windows. One 60 KB `.exe`, zero dependencies, zero installer — it uses only what ships with Windows.

![WinClicker main window](docs/main.png)

## Why it's cool

- **It can click in the background.** Pick a spot inside any window — a Chrome tab, a game launcher, anything — and WinClicker posts clicks straight to that window. Your real mouse never moves, so you keep using the rest of your PC like normal. The target can even sit behind other windows.
- **Only your keyboard stops it.** Shaking the mouse never interrupts a run. Press the stop hotkey (or, if you like, *any* key) and it stops instantly.
- **Global hotkeys you choose.** Click a hotkey button, press the key you want (modifiers welcome). The hotkeys are swallowed so the app you're clicking in never sees them.
- **It tells you what it's doing.** A click-through popup announces every start and stop — with the click count and run time.
- **Precise timing.** 1 ms resolution via a dedicated clicking thread; intervals from 1 ms up.
- **A real UI.** Dark, rounded, frameless, DPI-aware on every monitor — not a grey Win32 dialog from 2003.

![Start/stop popup](docs/toast.png)

## Get it

Download `WinClicker.exe` from the [latest release](../../releases/latest) and run it. That's it.

To build it yourself, clone the repo and run `build.bat` — it uses `csc.exe` from the .NET Framework that is already on every Windows 10/11 machine.

## Using it

| Target mode | What happens | Stops on |
|---|---|---|
| **Fixed location** | Moves the pointer to X/Y and clicks there. Choose the spot with *Pick on screen*. | Stop hotkey, or any key (switchable) |
| **Follow cursor** | Clicks wherever your pointer currently is. | Stop hotkey, or any key (switchable) |
| **In a window** | Sends clicks directly to one window, mouse-free. Window may be behind others, but not minimized. | Stop hotkey only — your typing goes to your other apps |

Also: interval in ms, left / right / middle button, single or double click. Defaults are **F6** to start and **F7** to stop. Settings persist in `%APPDATA%\WinClicker\settings.ini` (the window target is re-picked each launch, since window handles don't survive restarts).

## How it works

- Fixed and cursor modes use `SendInput`, the same path real hardware takes.
- Window mode walks the target's child windows (`ChildWindowFromPointEx`) and posts `WM_MOUSEMOVE` + `WM_xBUTTONDOWN/UP` with `PostMessage`, so it never blocks on a busy target. Verified against Chrome while covered by another window: 25 posted clicks, 25 counted.
- Hotkeys and the "any key stops it" behaviour come from a low-level keyboard hook (`WH_KEYBOARD_LL`); auto-repeat is filtered so a held key counts once.
- The whole thing is one C# file plus two XAML files, compiled by the Windows-bundled compiler.

## Caveats

- Window mode needs the target to accept synthetic mouse messages. Browsers and ordinary apps do; some games that read raw input don't — use Fixed location for those.
- Apps running as administrator ignore clicks from a non-elevated WinClicker. Run WinClicker as administrator too in that case.

## License

MIT
