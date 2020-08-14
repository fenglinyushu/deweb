unit dwDBEdits;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, DBCtrls,
     ExtCtrls, Grids,  Math,typinfo, DateUtils, StdCtrls, Menus, Windows,Types;

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
     TDBEdit(ACtrl).OnExit    := TDBEdit(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TDBEdit(ACtrl).OnChange  := nil;
     //����ֵ
     TDBEdit(ACtrl).Text    := dwUnescape(AData.value);
     //�ָ��¼�
     TDBEdit(ACtrl).OnChange  := TDBEdit(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TDBEdit(ACtrl).OnChange) then begin
          TDBEdit(ACtrl).OnChange(TDBEdit(ACtrl));
     end;

     //���OnExit�¼�
     TDBEdit(ACtrl).OnExit  := nil;
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
     with TDBEdit(ACtrl) do begin
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
     with TDBEdit(ACtrl) do begin
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
