unit dwDateTimePickers;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,

     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;



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
     TDateTimePicker(ACtrl).OnExit    := TDateTimePicker(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TDateTimePicker(ACtrl).OnChange  := nil;
     //����ֵ
     if TDateTimePicker(ACtrl).Kind = dtkDate then begin
          TDateTimePicker(ACtrl).Date    := StrToDate(AData.value);
     end else begin
          TDateTimePicker(ACtrl).Time    := StrToTime(StringReplace(AData.value,'%3A',':',[rfReplaceAll])+':00');
     end;
     //�ָ��¼�
     TDateTimePicker(ACtrl).OnChange  := TDateTimePicker(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TDateTimePicker(ACtrl).OnChange) then begin
          TDateTimePicker(ACtrl).OnChange(TDateTimePicker(ACtrl));
     end;

     //���OnExit�¼�
     TDateTimePicker(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     with TDateTimePicker(ACtrl) do begin
          //�����ַ���
          if kind =  dtkDate then begin
               //����  <el-date-picker v-model="value1"  type="date" placeholder="ѡ������"></el-date-picker>
               sCode     := '<el-date-picker type="date" format="yyyy-MM-dd" value-format="yyyy-MM-dd"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(ACtrl)
                         +'"' //style ���
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>{{'+Name+'__cap}}';
          end else begin
               sCode     := '<el-time-select :picker-options="{start: ''00:00'', step: ''00:01'', end: ''23:59''}" format="HH:mm" value-format="HH:mm"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +' v-model="'+Name+'__val"'
                         +dwLTWH(ACtrl)
                         +'"' //style ���
                         +SysUtils.Format(_DWEVENT,['change',Name,'this.'+Name+'__val','onchange',''])
                         +'>{{'+Name+'__cap}}';
          end;
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     if TDateTimePicker(ACtrl).Kind =  dtkDate then begin
          Result    := _Json('["</el-date-picker>"]');
     end else begin
          Result    := _Json('["</el-time-select>"]');
     end;
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TDateTimePicker(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          if kind =  dtkDate then begin
               Result.Add(Name+'__val'+ASeparator+'"'+FormatDateTime('yyyy-mm-dd',Date)+'"');
          end else begin
               Result.Add(Name+'__val'+ASeparator+'"'+FormatDateTime('hh:MM:ss',Time)+'"');
          end;
     end;
end;


end.
