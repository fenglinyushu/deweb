program dwMonitor;

uses
  Forms,
  main in 'main.pas' {MsgMonitor};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMsgMonitor, MsgMonitor);
  Application.Run;
end.
