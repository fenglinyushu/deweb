unit dwButtons;

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

//ȡ��Data��Ϣ
function dwGetData(ACtrl:TControl):Variant;

//��鵱ǰ�ؼ��Ƿ��Ǹ��ؼ�
function dwIsParent(ACtrl:TControl):Boolean;


implementation


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

     with TButton(ACtrl) do begin
          sCode     := '<el-button'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwGetHintValue(joHint,'type','type',' type="default"')         //sButtonType
                    +dwGetHintValue(joHint,'icon','icon','')         //ButtonIcon
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    //+dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                    +'>{{'+Name+'__cap}}';
          //��ӵ�����ֵ����
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-button>"]');
end;

//ȡ��Data��Ϣ
function dwGetData(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TButton(ACtrl) do begin
          Result.Add(Name+'__lef:"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top:"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid:"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei:"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis:'+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis:'+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__cap:"'+Caption+'"');
     end;
end;

//��鵱ǰ�ؼ��Ƿ��Ǹ��ؼ�
function dwIsParent(ACtrl:TControl):Boolean;
begin
     Result    := False;
end;




end.
