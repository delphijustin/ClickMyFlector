program ClickMyFlector;

{$APPTYPE CONSOLE}

uses
  Windows,
  messages,
  sysutils;

var found:Boolean;
function WinFlectorClick(hw:HWND;reserved:LParam):bool;stdcall;
var title:array[byte]of char;
startButton:HWND;
begin
GetWindowText(hw,title,high(Title));
result:=(THandle(Strpos(title,'Winflector v.'))<>THandle(@title));
if not result then begin
startbutton:=FindWindowEx(HW,0,'Button','&START');
found:=(Startbutton<>0);
if found then sendmessage(Startbutton,bm_click,0,0);
end;
end;
begin
writeln('Searching for WinFlector Windows...');
while not found do begin EnumWindows(@WinFlectorClick,0);Sleep(10240);end;
writeln('Winfector found');
  { TODO -oUser -cConsole Main : Insert code here }
end.
