unit unit1;

interface

uses
     //
     dwBase,

     //
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.MPlayer;

type
  TForm1 = class(TForm)
    Button3: TButton;
    MediaPlayer1: TMediaPlayer;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
     MediaPlayer1.EnabledButtons   := [btPause];

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     if MediaPlayer1.FileName  = '/small.mp4' then begin
          MediaPlayer1.FileName    := '/ocean.mp4';
     end else begin
          MediaPlayer1.FileName    := '/small.mp4';
     end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     MediaPlayer1.EnabledButtons   := [btPlay];
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
     MediaPlayer1.AutoRewind := not MediaPlayer1.AutoRewind;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
     MediaPlayer1.HelpContext := 6;
end;

end.