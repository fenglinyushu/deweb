unit dwEdits;

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
     TEdit(ACtrl).OnExit    := TEdit(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TEdit(ACtrl).OnChange  := nil;
     //����ֵ
     TEdit(ACtrl).Text    := dwUnescape(AData.value);
     //�ָ��¼�
     TEdit(ACtrl).OnChange  := TEdit(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TEdit(ACtrl).OnChange) then begin
          TEdit(ACtrl).OnChange(TEdit(ACtrl));
     end;

     //���OnExit�¼�
     TEdit(ACtrl).OnExit  := nil;
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
     with TEdit(ACtrl) do begin
          sCode     := '<el-input'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwIIF(PasswordChar=#0,'',' show-password')
                    +' v-model="'+Name+'__txt"'
                    +dwGetHintValue(joHint,'placeholder','placeholder','')         //placeholder
                    +dwGetHintValue(joHint,'prefix-icon','prefix-icon','')         //Icon
                    +dwGetHintValue(joHint,'suffix-icon','suffix-icon','')         //Icon
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +Format(_DWEVENT,['input',Name,'(this.'+Name+'__txt)','onchange',''])
                    +'>';
          //��ӵ�����ֵ����
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-input>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TEdit(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__txt'+ASeparator+'"'+(Text)+'"');
     end;
end;







end.
