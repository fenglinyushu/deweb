unit Unit4;

interface

uses
     //
     dwVars,
     dwCore,
     dwCtrlBase,
     
     dwDatas,

     //

     Math,
     Windows, Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Grids,
     Menus, DB, ADODB, ComCtrls;

type
  TForm4 = class(TForm)
    SG: TStringGrid;
    MainMenu: TMainMenu;
    MenuItem_Add: TMenuItem;
    MenuItem_Edit: TMenuItem;
    MenuItem_Delete: TMenuItem;
    MenuItem_About: TMenuItem;
    ADOQuery: TADOQuery;
    TreeView: TTreeView;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Edit_Search: TEdit;
    Panel_Edit: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    MenuItem_Save: TMenuItem;
    MenuItem_Cancel: TMenuItem;
    MenuItem_Prev: TMenuItem;
    MenuItem_Next: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure MenuItem_AboutClick(Sender: TObject);
    procedure MenuItem_DeleteClick(Sender: TObject);
    procedure MenuItem_EditClick(Sender: TObject);
    procedure MenuItem_CancelClick(Sender: TObject);
    procedure SGClick(Sender: TObject);
    procedure MenuItem_SaveClick(Sender: TObject);
    //确认框的结果处理函数
    procedure ProcessMessageDlg(AResult:String);
    //InputQuery框的结果处理函数
    procedure ProcessInputQuery(AResult:String);
    //
    procedure MenuItem_AddClick(Sender: TObject);
    procedure MenuItem_PrevClick(Sender: TObject);
    procedure MenuItem_NextClick(Sender: TObject);
  private
     function CreateNodeSQL(Node: TTreeNode): String;
  public
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}


function TForm4.CreateNodeSQL(Node: TTreeNode): String;
     procedure GetGroupIDs(var sGroup:String;Node:TTreeNode);
     var
          I    : Integer;
     begin
          for I:=0 to Node.Count-1 do begin
               sGroup    := sGroup+' OR GroupIDs Like ''%,'+IntToStr(Node.Item[I].SelectedIndex)+',%''';
               GetGroupIDs(sGroup,Node.Item[I]);
          end;
     end;
var
     iID  : Integer;
     sTmp : String;
begin
     iID  := Node.SelectedIndex;
     if iID=0 then begin
          sTmp := 'True';
     end else begin
          sTmp := ' GroupIDs Like ''%,'+IntToStr(iID)+',%''';
          GetGroupIDs(sTmp,TreeView.Selected);
     end;
     Result    := 'SELECT * FROM Member WHERE '+sTmp+' ORDER BY id DESC';
end;


procedure DataToTreeView(DataSet:TDataSet;sID,sLinkID,sName,sImageIndex:String;TV:TTreeView);
     procedure MyAdd(Node:TTreeNode);
     var
          I    : Integer;
     begin
          //过滤
          DataSet.Filter    := sLinkID+'='+IntToStr(Node.SelectedIndex);
          DataSet.Filtered  := True;
          //
          while not DataSet.Eof do begin
               with TV.Items.AddChild(Node,DataSet.FieldByName(sName).AsString) do begin
                    SelectedIndex  := DataSet.FieldByName(sID).AsInteger;  //当前组号
               end;
               //
               DataSet.Next;
          end;
          //
          for I:=0 to Node.Count-1 do begin
               MyAdd(Node.Item[I]);
          end;
     end;
begin
     //
     TV.Items.BeginUpdate;
     TV.Items[0].DeleteChildren;
     TV.Items[0].SelectedIndex     := 0;
     MyAdd(TV.Items[0]);
     TV.Items.EndUpdate;
     DataSet.Filtered    := False;
end;


procedure TForm4.FormCreate(Sender: TObject);
const
     iRecCountPerPage    = 5;
     sTableName          = 'member';
     iCurPageIndex       = 0;
var
     sSQL      : string;
     iRec      : Integer;
     iCol      : Integer;
     iLeft     : Integer;
begin
     try
          //设置菜单的Left/Top/Width/Height
          dwSetCompLTWH(MainMenu,200,0,600,50);

          //导入通讯录的TreeView组
          DM.ExeAQ(ADOQuery,'SELECT * FROM Groups ORDER BY LinkID,Ord');
          DataToTreeView(ADOQuery,'ID','LinkID','Name','',TreeView);
          TreeView.Items.BeginUpdate;
          TreeView.Items[0].Expand(False);
          TreeView.Items[0].Selected    := True;
          TreeView.Items.EndUpdate;


          //
          ADOQuery.Close;
          ADOQuery.SQL.Text := 'select * from Member ORDER BY id DESC';
          ADOQuery.Open;

          //列宽
          with SG do begin
               ColWidths[0]  := 70;
               ColWidths[1]  := 50;
               ColWidths[2]  := 50;
               ColWidths[3]  := 50;
               ColWidths[4]  := 100;
               ColWidths[5]  := 50;
               ColWidths[6]  := 50;
               ColWidths[7]  := 50;
               ColWidths[8]  := 150;
               ColWidths[9]  := 800 - 620;
          end;

          //列标题
          iLeft     := 0;
          for iCol := 0 to SG.ColCount-1 do begin
               SG.Cells[iCol,0]    := ADOQuery.FieldList[iCol].FieldName;
               //
               with TEdit(Self.FindComponent('Edit'+IntToStr(iCol+1))) do begin
                    Width     := SG.ColWidths[iCol];
                    Left      := iLeft;
                    iLeft     := iLeft + Width;
               end;
          end;
          //内容
          for iRec := 0 to Min(SG.RowCount,ADOquery.RecordCount)-1 do begin
               for iCol := 0 to SG.ColCount-1 do begin
                    SG.Cells[iCol,iRec+1]    := ADOQuery.FieldList[iCol].AsString;
               end;
               ADOQuery.Next;
               //
               if ADOQuery.Eof then begin
                    break;
               end;
          end;

          //
          TreeView.Items[0].Expand(False);

     except
          //ShowMsg('Error when Form4OnCreate');
     end;

end;

procedure TForm4.MenuItem_AboutClick(Sender: TObject);
begin
     dwShowMessage('Welecome to DeWeb!',Self);
end;

procedure TForm4.MenuItem_AddClick(Sender: TObject);
begin
     dwInputQuery('姓名','新成员','曾小贤','确定','取消','ProcessInputQuery',self);
end;

procedure TForm4.MenuItem_DeleteClick(Sender: TObject);
begin
     dwMessageDlg('确定要删除该记 "'+SG.Cells[0,SG.Row]+'"吗?','DeWeb Demo','确定','取消','ProcessMessageDlg',Self);
end;

procedure TForm4.MenuItem_EditClick(Sender: TObject);
var
     iCol      : Integer;
     iLeft     : Integer;
begin
     Panel_Edit.Visible  := True;
     Panel_Edit.Width    := SG.Width;
     Panel_Edit.Top      := SG.Top + SG.Row * 48;
     Panel_Edit.Left     := SG.Left;
     Edit1.Text     := SG.Cells[0,SG.Row];
     Edit2.Text     := SG.Cells[1,SG.Row];
     Edit3.Text     := SG.Cells[2,SG.Row];
     Edit4.Text     := SG.Cells[3,SG.Row];
     Edit5.Text     := SG.Cells[4,SG.Row];
     Edit6.Text     := SG.Cells[5,SG.Row];
     Edit7.Text     := SG.Cells[6,SG.Row];
     Edit8.Text     := SG.Cells[7,SG.Row];
     Edit9.Text     := SG.Cells[8,SG.Row];
     Edit10.Text    := SG.Cells[9,SG.Row];
     //
     iLeft     := 0;
     for iCol := 0 to SG.ColCount-1 do begin
          //
          with TEdit(Self.FindComponent('Edit'+IntToStr(iCol+1))) do begin
               Text      := SG.Cells[iCol,0];
               //
               Width     := SG.ColWidths[iCol];
               Left      := iLeft;
               iLeft     := iLeft + Width;
          end;
     end;
end;

procedure TForm4.MenuItem_NextClick(Sender: TObject);
begin
     dwShowMessage('建设中...',Self);

end;

procedure TForm4.MenuItem_PrevClick(Sender: TObject);
begin
     dwShowMessage('建设中...',Self);

end;

procedure TForm4.MenuItem_SaveClick(Sender: TObject);
var
     iRow,iCol : Integer;
begin
     //根据行号找到记录
     ADOQuery.First;
     for iRow := 0 to SG.Row-2 do begin
          ADOQuery.Next;
     end;

     //更新数据
     ADOQuery.Edit;

     //内容
     for iCol := 0 to 9 do begin
          ADOQuery.Fields[iCol].AsString     := TEdit(Self.FindComponent('Edit'+IntToStr(iCol+1))).Text;
          SG.Cells[iCol,SG.Row]              := ADOQuery.Fields[iCol].AsString;
     end;
     //
     ADOQuery.Post;

     //
     Panel_Edit.Visible  := False;

end;

procedure TForm4.MenuItem_CancelClick(Sender: TObject);
begin
     Panel_Edit.Visible  := False;
end;

procedure TForm4.ProcessInputQuery(AResult: String);
var
     tnNode    : TTreeNode;
     iRec,iCol : Integer;
begin
     //     dwShowMessage('您输入了 : '+(AResult),Self);
     ADOQuery.Append;
     ADOQuery.FieldByName('姓名').AsString   := AResult;
     ADOQuery.FieldByName('GroupIDs').AsString    := ','+IntToStr(TreeView.Selected.SelectedIndex)+',';
     ADOQuery.Post;
     //
     ADOQuery.Close;
     ADOQuery.SQL.Text := CreateNodeSQL(TreeView.Selected);
     ADOQuery.Open;

     //内容
     for iRec := 0 to SG.RowCount-1 do begin
          for iCol := 0 to SG.ColCount-1 do begin
               SG.Cells[iCol,iRec+1]    := ADOQuery.FieldList[iCol].AsString;
          end;
          ADOQuery.Next;
          //
          if ADOQuery.Eof then begin
               for iCol := 0 to SG.ColCount-1 do begin
                    SG.Cells[iCol,iRec+1]    := '';
               end;
          end;
     end;
end;

procedure TForm4.ProcessMessageDlg(AResult: String);
var
     iRow,iCol : Integer;
begin

     if AResult ='1' then begin
          //根据行号找到记录
          ADOQuery.First;
          for iRow := 0 to SG.Row-2 do begin
               ADOQuery.Next;
          end;
          ADOQuery.Delete;
          dwShowMessage('删除成功!',Self);

          //更新数据
          ADOQuery.Close;
          //ADOQuery.SQL.Text := 'select * from Member';
          ADOQuery.Open;

          //内容
          for iRow := 0 to Min(SG.RowCount,ADOquery.RecordCount)-1 do begin
               for iCol := 0 to SG.ColCount-1 do begin
                    SG.Cells[iCol,iRow+1]    := ADOQuery.FieldList[iCol].AsString;
               end;
               ADOQuery.Next;
               //
               if ADOQuery.Eof then begin
                    for iCol := 0 to SG.ColCount-1 do begin
                         SG.Cells[iCol,iRow+1]    := '';
                    end;
               end;
          end;

     end else begin
     //     dwShowMessage('您选择了Cancel!',Self);
     end;
end;

procedure TForm4.SGClick(Sender: TObject);
begin
     if Panel_Edit.Visible then begin
          Panel_Edit.Top      := SG.Top + SG.Row * 48;
          Edit1.Text     := SG.Cells[0,SG.Row];
          Edit2.Text     := SG.Cells[1,SG.Row];
          Edit3.Text     := SG.Cells[2,SG.Row];
          Edit4.Text     := SG.Cells[3,SG.Row];
          Edit5.Text     := SG.Cells[4,SG.Row];
          Edit6.Text     := SG.Cells[5,SG.Row];
          Edit7.Text     := SG.Cells[6,SG.Row];
          Edit8.Text     := SG.Cells[7,SG.Row];
          Edit9.Text     := SG.Cells[8,SG.Row];
          Edit10.Text    := SG.Cells[9,SG.Row];
     end;
end;

procedure TForm4.TreeViewClick(Sender: TObject);
var
     iRec,iCol : Integer;
begin
     //
     ADOQuery.Close;
     ADOQuery.SQL.Text := CreateNodeSQL(TreeView.Selected);
     ADOQuery.Open;

     //内容
     for iRec := 0 to SG.RowCount-1 do begin
          for iCol := 0 to SG.ColCount-1 do begin
               SG.Cells[iCol,iRec+1]    := ADOQuery.FieldList[iCol].AsString;
          end;
          ADOQuery.Next;
          //
          if ADOQuery.Eof then begin
               for iCol := 0 to SG.ColCount-1 do begin
                    SG.Cells[iCol,iRec+1]    := '';
               end;
          end;
     end;
     //
     Panel_Edit.Visible  := False;
end;

end.


