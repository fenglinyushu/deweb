library dwTDateTimePicker;

uses
     ShareMem,      //�������

     //
     dwCtrlBase,    //һЩ��������

     //
     SynCommons,    //mormot���ڽ���JSON�ĵ�Ԫ

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
     Classes,
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

     if joData.event = 'onchange' then begin
          //�����¼�
          TDateTimePicker(ACtrl).OnExit    := TDateTimePicker(ACtrl).OnChange;
          //����¼�,�Է�ֹ�Զ�ִ��
          TDateTimePicker(ACtrl).OnChange  := nil;
          //����ֵ
          if TDateTimePicker(ACtrl).Kind = dtkDate then begin
               TDateTimePicker(ACtrl).Date    := StrToDate(joData.value);
          end else begin
               TDateTimePicker(ACtrl).Time    := StrToTime(StringReplace(joData.value,'%3A',':',[rfReplaceAll])+':00');
          end;
          //�ָ��¼�
          TDateTimePicker(ACtrl).OnChange  := TDateTimePicker(ACtrl).OnExit;

          //ִ���¼�
          if Assigned(TDateTimePicker(ACtrl).OnChange) then begin
               TDateTimePicker(ACtrl).OnChange(TDateTimePicker(ACtrl));
          end;

          //���OnExit�¼�
          TDateTimePicker(ACtrl).OnExit  := nil;
     end else if joData.event = 'onenter' then begin
     end;

end;


//ȡ��HTMLͷ����Ϣ
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(TControl(ACtrl));
     with TDateTimePicker(ACtrl) do begin
          //�����ַ���
          if kind =  dtkDate then begin
               //����  <el-date-picker v-model="value1"  type="date" placeholder="ѡ������"></el-date-picker>
               sCode     := '<el-date-picker type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd"'
                         +dwVisible(TControl(ACtrl))
                         +dwDisable(TControl(ACtrl))
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(TControl(ACtrl))
                         +'"' //style ���
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>{{'+Name+'__cap}}';
          end else begin
               sCode     := '<el-time-select :picker-options="{start: ''00:00'', step: ''00:01'', end: ''23:59''}" format="HH:mm" value-format="HH:mm"'
                         +dwVisible(TControl(ACtrl))
                         +dwDisable(TControl(ACtrl))
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(TControl(ACtrl))
                         +'"' //style ���
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>{{'+Name+'__cap}}';
          end;
          joRes.Add(sCode);
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
     if TDateTimePicker(ACtrl).Kind =  dtkDate then begin
          joRes.Add('</el-date-picker>');          //�˴���Ҫ��dwGetHead��Ӧ
     end else begin
          joRes.Add('</el-time-select>');          //�˴���Ҫ��dwGetHead��Ӧ
     end;

     //
     Result    := (joRes);
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TComponent;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
begin
     //���ɷ���ֵ����
     joRes    := _Json('[]');
     //
     with TDateTimePicker(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if kind =  dtkDate then begin
               joRes.Add(Name+'__val'+ASeparator+'"'+FormatDateTime('yyyy-mm-dd',Date)+'"');
          end else begin
               joRes.Add(Name+'__val'+ASeparator+'"'+FormatDateTime('hh:MM:ss',Time)+'"');
          end;
     end;
     //
     Result    := (joRes);
end;


exports
     dwGetExtra,
     dwGetEvent,
     dwGetHead,
     dwGetTail,
     dwGetData;
     
begin
end.
 
