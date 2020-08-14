unit dwSpinEdits;

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
     TSpinEdit(ACtrl).OnExit    := TSpinEdit(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TSpinEdit(ACtrl).OnChange  := nil;
     //����ֵ
     TSpinEdit(ACtrl).Text    := dwUnescape(AData.value);
     //�ָ��¼�
     TSpinEdit(ACtrl).OnChange  := TSpinEdit(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TSpinEdit(ACtrl).OnChange) then begin
          TSpinEdit(ACtrl).OnChange(TSpinEdit(ACtrl));
     end;

     //���OnExit�¼�
     TSpinEdit(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     joHint    : Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);
     with TSpinEdit(ACtrl) do begin
          if ( maxvalue =  0 ) and  ( maxvalue =  0 ) then begin
               Result.Add('<el-input-number'
                         +' v-model="'+Name+'__val"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +dwLTWH(ACtrl)
                         +'"' //style ���
                         +Format(_DWEVENT,['change',Name,'(this.'+Name+'__val)','onchange',''])
                         +'>');
                         //+sVI+_DIS+LTWHex+'"></el-input-number>');
                         //@change="'+AJson.name+'__onchange"
          end else begin
               Result.Add('<el-input-number'
                         +' v-model="'+Name+'__val"'
                         +' :min="'+Name+'__min" :max="'+Name+'__max"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +dwLTWH(ACtrl)
                         +'"' //style ���
                         +Format(_DWEVENT,['change',Name,'(this.'+Name+'__val)','onchange',''])
                         +'>');
               //Result.Add(SP+'<el-input-number @change="'+AJson.name+'__onchange" v-model="'+AJson.name+'"'
               //          +' :min="'+sNA+'__min" :max="'+sNA+'__max"'+sVI+_DIS+LTWHex+'"></el-input-number>');
          end;
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-input-number>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TSpinEdit(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__val'+ASeparator+'"'+IntToStr(Value)+'"');
          Result.Add(Name+'__min'+ASeparator+'"'+IntToStr(MinValue)+'"');
          Result.Add(Name+'__max'+ASeparator+'"'+IntToStr(MaxValue)+'"');
     end;
end;







end.
