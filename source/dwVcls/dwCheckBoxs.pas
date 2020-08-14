unit dwCheckBoxs;

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
     TCheckBox(ACtrl).OnExit := TCheckBox(ACtrl).OnClick;
     //����¼�,�Է�ֹ�Զ�ִ��
     TCheckBox(ACtrl).OnClick := nil;
     //����ֵ
     TCheckBox(ACtrl).Checked := dwUnescape(AData.Value)='true';
     //�ָ��¼�
     TCheckBox(ACtrl).OnClick := TCheckBox(ACtrl).OnExit;
     //ִ���¼�
     if Assigned(TCheckBox(ACtrl).OnClick) then begin
          TCheckBox(ACtrl).OnClick(TCheckBox(ACtrl));
     end;
     //���OnExit�¼�
     TCheckBox(ACtrl).OnExit := nil;

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

     with TCheckBox(ACtrl) do begin
          sCode     := '<el-checkbox'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__chk"'
                    +dwGetHintValue(joHint,'type','type',' type="default"')         //sCheckBoxType
                    +dwGetHintValue(joHint,'icon','icon','')         //CheckBoxIcon
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +Format(_DWEVENT,['change',Name,'this.'+Name+'__chk','onclick',''])
                    +'>{{'+Name+'__cap}}';
          //��ӵ�����ֵ����
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-checkbox>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TCheckBox(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__cap'+ASeparator+'"'+dwProcessCaption(Caption)+'"');
          Result.Add(Name+'__chk'+ASeparator+''+dwIIF(Checked,'true','false'));
     end;
end;


end.
