unit Unit2;

interface

uses
     //
     dwBase,

     //
     Forms, SysUtils,Windows,
     Math, StdCtrls, Graphics, ExtCtrls, Controls, Classes;

type
  Tdwsdk = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    dwsdk: Tdwsdk;

implementation

{$R *.dfm}

procedure Tdwsdk.Button1Click(Sender: TObject);
var
     I    : Integer;
begin
     ComboBox1.Items.Clear;
     for I := 0 to 1 do begin
          ComboBox1.Items.Add(IntToStr(GetTickCount));
          Sleep(10);
     end;

end;

end.
