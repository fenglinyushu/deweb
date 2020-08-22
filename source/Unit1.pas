unit Unit1;

interface

uses
     dwBase,

     //
     Math,
  Windows, Messages, SysUtils, Variants, StdCtrls, Graphics, ExtCtrls,
  Controls, Forms, Dialogs, Classes, Vcl.Menus ;

type
  TDefault = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Default: TDefault;

implementation

{$R *.dfm}

procedure TDefault.FormCreate(Sender: TObject);
begin
     Top  := 0;
end;

end.
