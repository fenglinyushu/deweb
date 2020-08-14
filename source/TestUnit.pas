unit TestUnit;

interface

uses
     dwBase,
     dwDatas,

     //
     SynCommons,

     //
     Forms, SysUtils,
     Windows, Classes, Controls, StdCtrls, Menus, ExtCtrls, 
      ComCtrls, jpeg, MPlayer ;

type
  TTest = class(TForm)
    MediaPlayer1: TMediaPlayer;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

procedure TTest.FormCreate(Sender: TObject);
begin
     Top  := 0;
{
     Series1.Add(1393);
     Series1.Add(3530);
     Series1.Add(2923);
     Series1.Add(1723);
     Series1.Add(3792);
     Series1.Add(4593);
     //
     Series2.Add(1093);
     Series2.Add(3230);
     Series2.Add(2623);
     Series2.Add(1423);
     Series2.Add(3492);
     Series2.Add(4293);
}

end;

end.

