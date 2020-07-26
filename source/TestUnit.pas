unit TestUnit;

interface

uses
     dwCore,
     SynCommons,
     httpApp,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,Jpeg, DB, ADODB, ComCtrls;

type
  TTest = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image4: TImage;
    Image3: TImage;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

procedure TTest.Image1Click(Sender: TObject);
begin
     dwShowMessage(TImage(Sender).Name,'DeWeb','OK',Self);

end;

end.
