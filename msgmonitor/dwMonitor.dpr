program dwMonitor;

uses
  Vcl.Forms,
  main in 'main.pas' {MsgMonitor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMsgMonitor, MsgMonitor);
  Application.Run;
end.
