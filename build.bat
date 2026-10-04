@echo off
rem Builds WinClicker.exe with the C# compiler that ships with Windows (.NET Framework 4.x).
setlocal
set FW=%WINDIR%\Microsoft.NET\Framework64\v4.0.30319
cd /d "%~dp0"
"%FW%\csc.exe" /nologo /target:winexe /optimize+ /out:WinClicker.exe ^
  /win32manifest:app.manifest ^
  /resource:Main.xaml,Main.xaml /resource:Toast.xaml,Toast.xaml ^
  /lib:"%FW%\WPF" /r:PresentationFramework.dll /r:PresentationCore.dll /r:WindowsBase.dll /r:System.Xaml.dll ^
  App.cs
