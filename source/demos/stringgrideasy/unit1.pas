unit unit1;

interface

uses
     //
     dwBase,

     
     //

     //
     Math,
     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, StdCtrls, jpeg, ExtCtrls, DB,ADODB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Label_Demo: TLabel;
    DataSource1: TDataSource;
    Timer1: TTimer;
    Panel_Logo: TPanel;
    Image1: TImage;
    Label6: TLabel;
    ADOQuery: TADOQuery;
    Panel2: TPanel;
    Button_Position: TButton;
    Button_Size: TButton;
    Button_Visible: TButton;
    Panel_All: TPanel;
    Panel_StringGrid: TPanel;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Button_Get: TButton;
    Button_Set: TButton;
    Button_Clear: TButton;
    Button_SetCells: TButton;
    Button_GetRow: TButton;
    Button_SetRow: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure Button_PositionClick(Sender: TObject);
    procedure Button_SizeClick(Sender: TObject);
    procedure Button_VisibleClick(Sender: TObject);
    procedure Button_EnabledClick(Sender: TObject);
    procedure Button_GetClick(Sender: TObject);
    procedure Button_SetClick(Sender: TObject);
    procedure Button_ClearClick(Sender: TObject);
    procedure Button_SetCellsClick(Sender: TObject);
    procedure Button_SetRowClick(Sender: TObject);
    procedure Button_GetRowClick(Sender: TObject);
  private
  public

  end;

var
     Form1     : TForm1;


implementation


{$R *.dfm}




procedure TForm1.Button_ClearClick(Sender: TObject);
var
     iR,iC     : Integer;
begin
     for iR := 1 to StringGrid1.RowCount-1 do begin
          for iC := 0 to StringGrid1.ColCount-1 do begin
               StringGrid1.Cells[iC,iR] := '';
          end;
     end;

end;

procedure TForm1.Button_EnabledClick(Sender: TObject);
begin
     with StringGrid1 do begin
          Enabled   := not Enabled;
     end;

end;

procedure TForm1.Button_GetClick(Sender: TObject);
begin
     dwShowMessage(StringGrid1.Cells[2,2],self);
end;

procedure TForm1.Button_GetRowClick(Sender: TObject);
begin
     dwShowMessage('Row : '+IntToStr(StringGrid1.Row),self);

end;

procedure TForm1.Button_PositionClick(Sender: TObject);
begin
     With StringGrid1 do begin
          Left := Left + 5;
          Top  := Top + 5;
     end;
end;

procedure TForm1.Button_SetCellsClick(Sender: TObject);
var
     iR,iC     : Integer;
begin
     //
     for iR := 1 to StringGrid1.RowCount-1 do begin
          for iC := 0 to StringGrid1.ColCount-1 do begin
               StringGrid1.Cells[iC,iR] := Format('位%d,%d',[iR,iC]);
          end;
     end;

end;

procedure TForm1.Button_SetClick(Sender: TObject);
begin
     StringGrid1.Cells[2,2]   := IntToStr(GetTickCount);
end;

procedure TForm1.Button_SetRowClick(Sender: TObject);
begin
     with StringGrid1 do begin
          if Row<RowCount-1 then begin
               Row     := Row + 1;
          end else begin
               Row  := 1;
          end;
     end;
end;

procedure TForm1.Button_SizeClick(Sender: TObject);
begin
     With StringGrid1 do begin
          Width     := Width + 5;
          Height    := Height + 5;
     end;

end;

procedure TForm1.Button_VisibleClick(Sender: TObject);
begin
     with StringGrid1 do begin
          Visible   := not Visible;
     end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
     iR,iC     : Integer;
begin

     //
     Top  := 0;
     //
     StringGrid1.Cells[0,0]   := '姓名';
     StringGrid1.Cells[1,0]   := '性别';
     StringGrid1.Cells[2,0]   := '民族';
     StringGrid1.Cells[3,0]   := '籍贯';

     //
     for iR := 1 to StringGrid1.RowCount-1 do begin
          for iC := 0 to StringGrid1.ColCount-1 do begin
               StringGrid1.Cells[iC,iR] := Format('位%d,%d',[iR,iC]);
          end;
     end;

     //
     dwSetHeight(Self,1200);
end;


procedure TForm1.StringGrid1Click(Sender: TObject);
var
     iRow      : Integer;
begin
     iRow      := StringGrid1.Row;
     if iRow < StringGrid1.RowCount then begin
     end else begin
     end;
end;

end.
