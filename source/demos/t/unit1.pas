unit unit1;

interface

uses
     //
     dwBase,

     //
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.MPlayer,
  Vcl.Menus, Vcl.Buttons, Vcl.Samples.Spin, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image_t_mm: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
function GetDllPath: string;
var
     ModuleName: string;
begin
     SetLength(ModuleName, 255);
     //取得Dll自身路径
     GetModuleFileName(HInstance, PChar(ModuleName), Length(ModuleName));
     Result := PChar(ModuleName);
end;
function dwGetDllName: string;
var
     sModule   : string;
begin
     SetLength(sModule, 255);
     //取得Dll自身路径
     GetModuleFileName(HInstance, PChar(sModule), Length(sModule));
     //去除路径
     while Pos('\',sModule)>0 do begin
          Delete(sModule,1,Pos('\',sModule));
     end;
     //去除.dll
     if Pos('.',sModule)>0 then begin
          sModule     := Copy(sModule,1,Pos('.',sModule)-1);
     end;

     //
     Result := PChar(sModule);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     //
     dwShowMessage('Hello,DeWeb!',self);

end;

end.
