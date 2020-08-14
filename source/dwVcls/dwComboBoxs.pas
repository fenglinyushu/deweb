unit dwComboBoxs;

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
     TComboBox(ACtrl).OnExit    := TComboBox(ACtrl).OnChange;
     //����¼�,�Է�ֹ�Զ�ִ��
     TComboBox(ACtrl).OnChange  := nil;
     //����ֵ
     TComboBox(ACtrl).Text    := dwUnescape(AData.value);
     //�ָ��¼�
     TComboBox(ACtrl).OnChange  := TComboBox(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TComboBox(ACtrl).OnChange) then begin
          TComboBox(ACtrl).OnChange(TComboBox(ACtrl));
     end;

     //���OnExit�¼�
     TComboBox(ACtrl).OnExit  := nil;
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var

     //
     joHint    : Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);

     //


     with TComboBox(ACtrl) do begin
          //
          Result.Add('<el-select'
                    +' v-model="'+Name+'__txt"'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +Format(_DWEVENT,['change',Name,'this.'+Name+'__txt','onchange',''])
                    +'>');
          Result.Add('    <el-option v-for="item in '+Name+'__options" :key="item.value" :label="item.value" :value="item.value"/>');

     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-select>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
var
     iItem     : Integer;
     sCode     : String;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //����Data:ѡ��

     //
     with TComboBox(ACtrl) do begin
          //���ѡ��
          sCode     := Name+'__options'+ASeparator+'[';
          for iItem := 0 to Items.Count-1 do begin
               sCode     := sCode + '{value:'''+Items[iItem]+'''},';
          end;
          Delete(sCode,Length(sCode),1);
          sCode     := sCode + ']';
          Result.Add(sCode);
          //
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          if dwGetProp(ACtrl,'height')='' then begin
               Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          end else begin
               Result.Add(Name+'__hei'+ASeparator+'"'+dwGetProp(ACtrl,'height')+'px"');
          end;
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__txt'+ASeparator+'"'+Text+'"');
     end;
end;


end.
