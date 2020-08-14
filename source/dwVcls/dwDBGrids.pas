unit dwDBGrids;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     DB,
     Messages, SysUtils, Variants, Classes, Graphics,     Controls, Forms, Dialogs, ComCtrls,
     ExtCtrls, Spin, Grids,  Math,typinfo, DateUtils, StdCtrls, Menus, Windows,Types,DBGrids;

//����ֵ˵�� : ����һ���ַ�������(ÿ��Ԫ�ش���һ��,�Դ���ǰ����)

//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TControl;AData:Variant):String;

implementation

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TControl;AData:Variant):String;
begin
     //�����¼�
     //TDBGrid(ACtrl).OnExit    := TDBGrid(ACtrl).OnCellClick;
     //����¼�,�Է�ֹ�Զ�ִ��
     //TDBGrid(ACtrl).OnCellClick  := nil;
     //����ֵ
     //TDrawGrid(TDBGrid(ACtrl)).Row := AData.value;
     TDBGrid(ACtrl).DataSource.DataSet.RecNo := AData.value+1;
     //�ָ��¼�
     //TDBGrid(ACtrl).OnCellClick  := TDBGrid(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TDBGrid(ACtrl).OnCellClick) then begin
          TDBGrid(ACtrl).OnCellClick(TDBGrid(ACtrl).Columns[0]);
     end;

     //���OnExit�¼�
     //TDBGrid(ACtrl).OnExit  := nil;

end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     iItem     : Integer;
     joHint    : Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);
     with TDBGrid(ACtrl) do begin
          //������
          Result.Add('<div'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +'>');
          //�������
          Result.Add('    <el-table'
                    +' :data="'+Name+'__ces"'
                    +' highlight-current-row stripe'
                    +dwIIF(Borderstyle<>bsNone,' border','')
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' height="'+IntToStr(ACtrl.Height)+'"'
                    +' style="width:100%"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onchange',''])
                    +'>');
          //�������ӵ��к���, ���ڱ�ʾ�к�
          Result.Add('        <el-table-column  show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //��Ӹ���
          for iItem := 0 to Columns.Count-1 do begin
               Result.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' label="'+Columns[iItem].Title.Caption+'"'
                         +' width="'+IntToStr(Columns[iItem].Width)+'"></el-table-column>');
          end;
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     Result.Add('    </el-table>');
     Result.Add('</div>');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
var
     iRow,iCol : Integer;
     sCode     : String;
     oDataSet  : TDataSet;
     function _GetValue(AField:TField):String;
     begin
          if AField.DataType in [ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat, ftCurrency,
               ftBCD,ftBytes, ftVarBytes, ftAutoInc, ftFmtMemo,ftFixedChar, ftWideString, ftLargeint, ftMemo] then
          begin
               Result    := dwProcessCaption(AField.AsString);
          end else if AField.DataType in [ftDate] then begin
               Result    := FormatDateTime('yyyy-mm-dd',AField.AsDateTime);
          end else if AField.DataType in [ftTime] then begin
               Result    := FormatDateTime('HH:MM:SS',AField.AsDateTime);
          end else if AField.DataType in [ftDateTime] then begin
               Result    := FormatDateTime('yyyy-mm-dd HH:MM:SS',AField.AsDateTime);
          end else begin
               Result    := '';
          end;
     end;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TDBGrid(ACtrl) do begin
          //
          oDataSet  := DataSource.DataSet;
          

          //
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if not oDataSet.Active then begin
          end else begin
               oDataSet.DisableControls;
               //
               if ASeparator = ':' then begin
                    sCode     := '';
                    oDataSet.First;
                    iRow := 0;
                    while not oDataSet.Eof do begin
                         if sCode = '' then begin
                              sCode     := Name+'__ces:[{"d0":'''+IntToStr(iRow)+''',';
                         end else begin
                              sCode     := '{"d0":'''+IntToStr(iRow)+''',';
                         end;
                         for iCol := 0 to Columns.Count-2 do begin
                              sCode     := sCode +'"d'+IntToStr(iCol+1)+'":'''+_GetValue(Columns[iCol].Field)+''',';
                         end;
                         sCode     := sCode +'"d'+IntToStr(Columns.Count-1)+'":'''+_GetValue(Columns[Columns.Count-1].Field)+'''}';
                         //
                         oDataSet.Next;
                         Inc(iRow);
                         if oDataSet.Eof then begin
                              Result.Add(sCode+']');
                         end else begin
                              Result.Add(sCode);
                         end;
                    end;
                    oDataSet.First;
               end;
               oDataSet.EnableControls;
          end
(*
          end else begin
               for iRow := 0 to RowCount-1 do begin
                    sCode     := '';
                    sCode := '{d0:"'+IntToStr(iRow)+'",';   //������ӵ��к���
                    for iCol := 0 to ColCount-1 do begin
                         sCode    := sCode + 'd'+IntToStr(iCol+1)+':"'+Cells[iCol,iRow]+'",';
                    end;
                    if Length(sCode)>2 then begin
                         Delete(sCode,Length(sCode),1);  //ɾ������,
                    end;
                    sCode    := sCode + '}';

                    Result.Add('$set(this.'+Name+'__ces,'+IntToStr(iRow)+','+sCode+')');
               end;
          end;
*)
     end;
end;







end.
