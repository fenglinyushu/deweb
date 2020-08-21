unit TestUnit;

interface

uses
     dwBase,
     dwDatas,

     //
     SynCommons, ZAbstractRODataset, ZDataset,

     //
     Forms, SysUtils,
     Windows, Classes, Controls, StdCtrls, Menus, ExtCtrls, 
      ComCtrls, jpeg,  Grids, DBGrids, DB, Data.Win.ADODB, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Samples.Spin ;

type
  TTest = class(TForm)
    Button1: TButton;
    DBEdit1: TDBEdit;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu: TMainMenu;
    MenuItem_File: TMenuItem;
    MenuItem_Open: TMenuItem;
    MenuItem_Reload: TMenuItem;
    N1: TMenuItem;
    MenuItem_Save: TMenuItem;
    MenuItem_SaveAs: TMenuItem;
    MenuItem_SaveAll: TMenuItem;
    Sep: TMenuItem;
    MenuItem_PrintChart: TMenuItem;
    MenuItem_PrintCode: TMenuItem;
    MenuItem_Pro0: TMenuItem;
    MenuItem_Close: TMenuItem;
    MenuItem_CloseAll: TMenuItem;
    N2: TMenuItem;
    MenuItem_Exit: TMenuItem;
    MenuItem_Edit: TMenuItem;
    MenuItem_ZoomIn: TMenuItem;
    MenuItem_ZoomOut: TMenuItem;
    N9: TMenuItem;
    MenuItem_ExpandAll: TMenuItem;
    MenuItem_ShrinkAll: TMenuItem;
    N5: TMenuItem;
    MenuItem_ShowLineNumbers: TMenuItem;
    MenuItem_Search: TMenuItem;
    MenuItem_Find: TMenuItem;
    MenuItem_SearchAgain: TMenuItem;
    MenuItem_Option: TMenuItem;
    MenuItem_ExportWord: TMenuItem;
    MenuItem_ExportVisio: TMenuItem;
    MenuItem_ExportBitmap: TMenuItem;
    MenuItem_ExportSVG: TMenuItem;
    MenuItem_ExportXML: TMenuItem;
    MenuItem_SimulateExec: TMenuItem;
    MenuItem_Pro1: TMenuItem;
    MenuItem_Options: TMenuItem;
    Windows1: TMenuItem;
    N6: TMenuItem;
    MenuItem_NextWindow: TMenuItem;
    MenuItem_Help: TMenuItem;
    MenuItem_Content: TMenuItem;
    N7: TMenuItem;
    MenuItem_HomePage: TMenuItem;
    MenuItem_OrderNow: TMenuItem;
    MenuItem_Pro2: TMenuItem;
    MenuItem_Register: TMenuItem;
    N3: TMenuItem;
    MenuItem_About: TMenuItem;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem39: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
  private
     ZQuery: TZReadOnlyQuery;
  public
    { Public declarations }
  end;

var
  Test: TTest;

implementation

{$R *.dfm}

procedure TTest.Button1Click(Sender: TObject);
begin
{     With StaticText1 do begin
          Left      := Left + 20;
          Top       := Top + 20;
          Width     := Width + 20;
          Height    := Height + 20;
          //
          //Checked        := not Checked;
          //
          Caption   := '中言-'+IntToStr(GetTickCount mod 1000);
     end;
}
     ADOTable1.Next;
{
     Label1.Caption           := '标签  '+IntToStr(GetTickCount mod 1000);
     Edit1.Text               := '编辑  '+IntToStr(GetTickCount mod 999);
     CheckBox1.Checked        := not CheckBox1.Checked;
     RadioButton1.Checked     := checkBox1.Checked;
     //
     dwShowMessage('Hello, DeWeb!',self);
}end;

procedure TTest.Button26Click(Sender: TObject);
begin
{     with Panel2 do begin
          Left      := Left + 20;
          Top       := Top + 20;
          Width     := Width + 20;
          Height    := Height + 20;
     end;
}
end;

procedure TTest.FormCreate(Sender: TObject);
begin
     Top  := 0;

     //设置菜单的Left/Top/Width/Height
     dwSetCompLTWH(MainMenu,0,0,Width,60);
     //设置菜单的Left/Top/Width/Height
     dwSetCompLTWH(MainMenu1,0,60,200,500);
{

     //
     ZQuery    := TZReadOnlyQUery.Create(Self);
     ZQuery.Connection   := DM.ZConnection;

     //
     ZQuery.SQL.Text     := 'SELECT * FROM Member';  //姓名,性别,民族,爱好,籍贯,地址
     ZQuery.Open;


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

