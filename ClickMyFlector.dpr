program ClickMyFlector;

{$APPTYPE CONSOLE}

uses
  Windows,
  messages,
  sysutils,shellapi;

var found:Boolean=false;
wfserver_exe,wfdir:array[0..max_path]of char;
execerr:HINST;
function WinFlectorClick(hw:HWND;reserved:LParam):bool;stdcall;
var title:array[byte]of char;
startButton:HWND;
begin
GetWindowText(hw,title,high(Title));
if(THandle(Strpos(title,'Winflector v.'))=THandle(@title))then begin
startbutton:=FindWindowEx(HW,0,'Button','&START');
found:=(Startbutton<>0);
if found then sendmessage(Startbutton,bm_click,0,0)else
begin
writeln('Failed to find start button, is server already started or a new version changes the way it works?');
writeln(datetimetostr(NOW),' - Error#',getlasterror);
end;
end;
result:=not found;
end;
begin
execerr:=33;
ExpandEnvironmentStrings('%SystemDrive%\Winflector\server',wfdir,sizeof(wfdir));
strcat(Strcopy(wfserver_exe,wfdir),'\wfserver.exe');
if FindCmdlineswitch('S',['/'],true)then EXECErr:=shellexecute(0,nil,wfserver_Exe,
nil,wfdir,SW_NORMAL);
if EXECErr<33then writeln('ShellExecute: ',syserrormessage(execerr))else
sleep(10240);
writeln('Searching for WinFlector Windows...');
while not found do begin EnumWindows(@WinFlectorClick,0);if found then break;
Writeln(datetimetostr(Now),' - Winflector window not found or isn'#39't finish loading');
Sleep(5120);end;
writeln('Winfector found');
sleep(5120);
end.
