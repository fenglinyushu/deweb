unit dwStringGrids;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,     Controls, Forms, Dialogs, ComCtrls,
     ExtCtrls, Spin, Grids,  Math,typinfo, DateUtils, StdCtrls, Menus, Windows,Types;

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
     TStringGrid(ACtrl).OnExit    := TStringGrid(ACtrl).OnClick;
     //����¼�,�Է�ֹ�Զ�ִ��
     TStringGrid(ACtrl).OnClick    := nil;
     //����ֵ
     TStringGrid(ACtrl).Row    := AData.value;
     //�ָ��¼�
     TStringGrid(ACtrl).OnClick  := TStringGrid(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TStringGrid(ACtrl).OnClick) then begin
          TStringGrid(ACtrl).OnClick(TStringGrid(ACtrl));
     end;

     //���OnExit�¼�
     TStringGrid(ACtrl).OnExit  := nil;

end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     iItem     : Integer;
     sCode     : string;
     joHint    : Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);
     with TStringGrid(ACtrl) do begin
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
                    +' style="width:100%;height:100%;"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onchange',''])
                    +'>');
          //�������ӵ��к���, ���ڱ�ʾ�к�
          Result.Add('        <el-table-column show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //��Ӹ���
          for iItem := 0 to ColCount-1 do begin
               Result.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +dwIIF(iItem<FixedCols,' fixed','')
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' label="'+Cells[iItem,0]+'"'
                         +' width="'+IntToStr(Colwidths[iItem])+'"></el-table-column>');
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
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TStringGrid(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if ASeparator = ':' then begin
               sCode     := '';
               for iRow := 1 to RowCount-1 do begin
                    sCode     := sCode + '{"d0":'''+IntToStr(iRow)+''',';
                    for iCol := 0 to ColCount-1 do begin
                         sCode     := sCode + '"d'+IntToStr(iCol+1)+'":'''+dwProcessCaption(Cells[iCol,iRow])+''',';
                    end;
                    Delete(sCode,Length(sCode),1);
                    sCode     := sCode + '},';
               end;
               if sCode<>'' then begin
                    Delete(sCode,Length(sCode),1);
               end;
               sCode     := '['+sCode + ']';
               Result.Add(Name+'__ces'+ASeparator+sCode);
          end else begin
               for iRow := 0 to RowCount-1 do begin
                    sCode     := '';
                    sCode := '{d0:"'+IntToStr(iRow)+'",';   //������ӵ��к���
                    for iCol := 0 to ColCount-1 do begin
                         sCode    := sCode + 'd'+IntToStr(iCol+1)+':"'+dwProcessCaption(Cells[iCol,iRow])+'",';
                    end;
                    if Length(sCode)>2 then begin
                         Delete(sCode,Length(sCode),1);  //ɾ������,
                    end;
                    sCode    := sCode + '}';

                    Result.Add('$set(this.'+Name+'__ces,'+IntToStr(iRow)+','+sCode+')');
               end;
          end;
     end;
end;







end.
