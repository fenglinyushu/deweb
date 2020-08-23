library dwTStringGrid;

uses
     ShareMem,      //�������

     //
     dwCtrlBase,    //һЩ��������

     //
     SynCommons,    //mormot���ڽ���JSON�ĵ�Ԫ

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
     Classes,Grids,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//��ǰ�ؼ���Ҫ����ĵ�����JS/CSS ,һ��Ϊ�����Ķ�,Ŀǰ����TChartʹ��ʱ��Ҫ�õ�
function dwGetExtra(ACtrl:TComponent):string;stdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     {
     //������TChartʱ�Ĵ���,���ο�
     joRes.Add('<script src="dist/charts/echarts.min.js"></script>');
     joRes.Add('<script src="dist/charts/lib/index.min.js"></script>');
     joRes.Add('<link rel="stylesheet" href="dist/charts/lib/style.min.css">');
     }

     //
     Result    := joRes;
end;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     joData    : Variant;
begin
     //
     joData    := _Json(AData);

     if joData.event = 'onclick' then begin
          //�����¼�
          TStringGrid(ACtrl).OnExit    := TStringGrid(ACtrl).OnClick;
          //����¼�,�Է�ֹ�Զ�ִ��
          TStringGrid(ACtrl).OnClick  := nil;
          //����ֵ
          TStringGrid(ACtrl).Row   := joData.value;
          //�ָ��¼�
          TStringGrid(ACtrl).OnClick  := TStringGrid(ACtrl).OnExit;

          //ִ���¼�
          if Assigned(TStringGrid(ACtrl).OnClick) then begin
               TStringGrid(ACtrl).OnClick(TStringGrid(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
     end;

     //���OnExit�¼�
     TStringGrid(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     //
     iItem     : Integer;
     //
     joHint    : Variant;
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     //
     with TStringGrid(ACtrl) do begin
          //������
          joRes.Add('<div'
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style ���
                    +'>');
          //�������
          joRes.Add('    <el-table'
                    +' :data="'+Name+'__ces"'
                    +' highlight-current-row'
                    +' ref="'+Name+'"'
                    //+' stripe'
                    +dwIIF(Borderstyle<>bsNone,' border','')
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +' height="'+IntToStr(TControl(ACtrl).Height)+'"'
                    +' style="width:100%"'
                    +Format(_DWEVENT,['row-click',Name,'val.d0','onclick',''])
                    +'>');

          //�������ӵ��к���, ���ڱ�ʾ�к�
          joRes.Add('        <el-table-column  show-overflow-tooltip fixed v-if=false prop="d0" label="rowno" width="80"></el-table-column>');
          //��Ӹ���
          for iItem := 0 to ColCount-1 do begin
               joRes.Add('        <el-table-column'
                         +' show-overflow-tooltip'
                         +' prop="d'+IntToStr(iItem+1)+'"'
                         +' :label="'+Name+'__col'+IntToStr(iItem)+'"'
                         +' width="'+IntToStr(ColWidths[iItem])+'"></el-table-column>');
          end;
     end;

     //
     Result    := (joRes);
end;

//ȡ��HTMLβ����Ϣ
function dwGetTail(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //���ɷ���ֵ����
     joRes.Add('    </el-table>');
     joRes.Add('</div>');

     //
     Result    := (joRes);
end;



//ȡ��Data
function dwGetData(ACtrl:TControl):string;StdCall;
var
     joRes     : Variant;
     //
     iRow,iCol : Integer;
     sCode     : String;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TStringGrid(ACtrl) do begin

          //
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //�б���
          for iCol := 0 to ColCount-1 do begin
               joRes.Add(Name+'__col'+IntToStr(iCol)+':"'+Cells[iCol,0]+'",');
          end;


          //����
          sCode     := Name+'__ces:[';
          for iRow := 1 to RowCount-1 do begin
               sCode     := sCode + '{"d0":'''+IntToStr(iRow)+''',';
               for iCol := 0 to ColCount-1 do begin
                    sCode     := sCode + '"d'+IntToStr(iCol+1)+'":'''+Cells[iCol,iRow]+''',';
               end;
               sCode     := sCode + '},';
          end;
          sCode     := sCode + '],';
          joRes.Add(sCode);
          //joRes.Add('currentRow: 1,');
     end;
     //
     Result    := (joRes);
end;



//ȡ��Method
function dwGetMethod(ACtrl:TControl):string;StdCall;
var
     joRes     : Variant;
     //
     iRow,iCol : Integer;
     sCode     : String;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //
     with TStringGrid(ACtrl) do begin
          //
          joRes.Add(Name+'__lef="'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top="'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid="'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei="'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis='+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis='+dwIIF(Enabled,'false','true'));

          //�б���
          for iCol := 0 to ColCount-1 do begin
               joRes.Add('this.'+Name+'__col'+IntToStr(iCol)+'="'+Cells[iCol,0]+'";');
          end;

          //����
          for iRow := 1 to RowCount-1 do begin
               sCode     := 'this.$set(this.'+TStringGrid(ACtrl).Name+'__ces,'+IntToStr(iRow-1)+',{d0:"'+IntToStr(iRow)+'",';
               for iCol := 0 to ColCount-2 do begin
                    sCode     := sCode +'d'+IntToStr(iCol+1)+':"'+Cells[iCol,iRow]+'",';
               end;
               sCode     := sCode +'d'+IntToStr(ColCount)+':"'+Cells[ColCount-1,iRow]+'"});';
               joRes.Add(sCode);
          end;

     end;
     //�к�        this.$refs.multiplePlan.data[0]
     joRes.Add('this.$refs.'+TStringGrid(ACtrl).Name+'.setCurrentRow('
          +'this.$refs.'+TStringGrid(ACtrl).Name+'.data['+IntToStr(TStringGrid(ACtrl).Row-1)+']'
          +');');
     //
     Result    := (joRes);
end;

exports
     dwGetExtra,
     dwGetEvent,
     dwGetHead,
     dwGetTail,
     dwGetMethod,
     dwGetData;

begin
end.
 
