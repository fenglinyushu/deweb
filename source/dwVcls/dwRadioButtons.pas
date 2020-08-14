unit dwRadioButtons;

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
     TRadioButton(ACtrl).OnExit := TRadioButton(ACtrl).OnClick;
     //����¼�,�Է�ֹ�Զ�ִ��
     TRadioButton(ACtrl).OnClick := nil;
     //����ֵ
     TRadioButton(ACtrl).Checked := dwUnescape(AData.Value)='true';
     //�ָ��¼�
     TRadioButton(ACtrl).OnClick := TRadioButton(ACtrl).OnExit;
     //ִ���¼�
     if Assigned(TRadioButton(ACtrl).OnClick) then begin
          TRadioButton(ACtrl).OnClick(TRadioButton(ACtrl));
     end;
     //���OnExit�¼�
     TRadioButton(ACtrl).OnExit := nil;

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

     //               
     with TRadioButton(ACtrl) do begin
          sCode     := '<el-radio'
                    +' label="1"'       //ѡ��ֵ
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__chk"'
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +dwIIF(Assigned(OnClick),Format(_DWEVENT,['change',Name,'(this.'+Name+'__chk)','onclick','']),'')
                    +'>{{'+Name+'__cap}}';
          //��ӵ�����ֵ����
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-radio>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TRadioButton(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__cap'+ASeparator+'"'+dwProcessCaption(Caption)+'"');
          Result.Add(Name+'__chk'+ASeparator+'"'+dwIIF(Checked,'1','0')+'"');
     end;
end;


end.
