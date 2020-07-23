program DelphiWeb;


uses
  Forms,
  ActiveX,
  dwVars in 'dwVars.pas',
  main in 'main.pas' {MainForm},
  dwCore in 'dwCore.pas',
  dwBase in 'dwBase.pas' {Form_Base},
  Unit1 in 'Unit1.pas' {Default},
  Unit2 in 'Unit2.pas' {dwsdk},
  Unit3 in 'Unit3.pas' {Form_OnlineTestSystem},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Login},
  DemosUnit in 'DemosUnit.pas' {Demos},
  TestUnit in 'TestUnit.pas' {Test},
  DriverUnit in 'DriverUnit.pas' {Driver},
  dwDatas in 'dwDatas.pas' {DM: TDataModule},
  dwEdits in 'dwEdits.pas',
  dwCtrlBase in 'dwCtrlBase.pas',
  dwButtons in 'dwButtons.pas';

{$R *.RES}

begin
     CoInitialize(nil); 
     Application.Title := 'Deweb Server';
     Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
     CoUninitialize;
end.
