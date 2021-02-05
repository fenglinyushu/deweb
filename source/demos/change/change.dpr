library change;

uses
  ShareMem,
  SysUtils,
  Forms,
  Messages,
  StdCtrls,
  Variants,
  Windows,
  Classes,
  unit1 in 'unit1.pas' {Form1};

{$R *.res}
type
     PdwGetEvent    = function (ACtrl:TComponent;AData:String):string;StdCall;

var
     DLLApp    : TApplication;
     DLLScreen : TScreen;


function dwLoad(AParams:String;AApp:TApplication;AScreen:TScreen):TForm;stdcall;
var
     AForm     : TForm1;
begin
     //采用调用程序的应用和屏幕信息
     Application    := AApp;
     Screen         := AScreen;

     //创建窗体
     AForm          := TForm1.Create(nil);
     //设置当前窗体的相关信息
     AForm.Hint     := AParams;
     //返回
     Result         := AForm;
end;

procedure DLLUnloadProc(dwReason: DWORD);
begin
     if dwReason = DLL_PROCESS_DETACH then begin
          Application    := DLLApp; //恢复
          Screen         := DLLScreen;
     end;
end;



exports
     dwLoad;

begin
     DLLApp    := Application;     //保存 DLL 中初始的 Application 对象
     DLLScreen := Screen;
     DLLProc   := @DLLUnloadProc;  //保证 DLL 卸载时恢复原来的 Application
     DLLUnloadProc(DLL_PROCESS_DETACH);
end.
