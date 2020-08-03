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
  dwCtrlBase in 'dwCtrlBase.pas',
  dwTreeViews in 'dwVcls\dwTreeViews.pas',
  dwRadioButtons in 'dwVcls\dwRadioButtons.pas',
  dwMemos in 'dwVcls\dwMemos.pas',
  dwDBTexts in 'dwVcls\dwDBTexts.pas',
  dwPageControls in 'dwVcls\dwPageControls.pas',
  dwTabSheets in 'dwVcls\dwTabSheets.pas',
  dwCheckBoxs in 'dwVcls\dwCheckBoxs.pas',
  dwPanels in 'dwVcls\dwPanels.pas',
  dwDateTimePickers in 'dwVcls\dwDateTimePickers.pas',
  dwImages in 'dwVcls\dwImages.pas',
  dwButtons in 'dwVcls\dwButtons.pas',
  dwComboBoxs in 'dwVcls\dwComboBoxs.pas',
  dwSpinEdits in 'dwVcls\dwSpinEdits.pas',
  dwDBGrids in 'dwVcls\dwDBGrids.pas',
  dwDBEdits in 'dwVcls\dwDBEdits.pas',
  dwListBoxs in 'dwVcls\dwListBoxs.pas',
  dwStringGrids in 'dwVcls\dwStringGrids.pas',
  dwEdits in 'dwVcls\dwEdits.pas',
  dwLabels in 'dwVcls\dwLabels.pas',
  DFWUnit in 'DFWUnit.pas' {DFW};

{$R *.RES}

begin
     CoInitialize(nil); 
     Application.Title := 'Deweb Server';
     Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDFW, DFW);
  Application.Run;
     CoUninitialize;
end.
