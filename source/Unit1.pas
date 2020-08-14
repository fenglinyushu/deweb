unit Unit1;

interface

uses

     //
     Math,
  Windows, Messages, SysUtils, Variants, StdCtrls, Graphics, ExtCtrls,
  Controls, Forms, Dialogs, Classes ;

type
  TDefault = class(TForm)
    Label_deweb: TLabel;
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
