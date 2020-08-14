unit dwListBoxs;

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
var
     sValue    : String;
     iItem     : Integer;
begin
     //�����¼�
     TListBox(ACtrl).OnExit    := TListBox(ACtrl).OnClick;
     //����¼�,�Է�ֹ�Զ�ִ��
     TListBox(ACtrl).OnClick  := nil;
     //����ֵ
     sValue    := dwUnescape(AData.value);
     sValue    := ','+sValue+',';
     for iItem := 0 to TListBox(ACtrl).Items.Count-1 do begin
          TListBox(ACtrl).Selected[iItem]    := Pos(','+IntToStr(iItem)+',',sValue)>0;
     end;
     //�ָ��¼�
     TListBox(ACtrl).OnClick  := TListBox(ACtrl).OnExit;

     //ִ���¼�
     if Assigned(TListBox(ACtrl).OnClick) then begin
          TListBox(ACtrl).OnClick(TListBox(ACtrl));
     end;

     //���OnExit�¼�
     TListBox(ACtrl).OnExit  := nil;
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


     with TListBox(ACtrl) do begin
          //
          Result.Add('<select class="dwselect" size=2'
                    +dwIIF(MultiSelect,' multiple','')
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +' v-model="'+Name+'__val"'
                    +dwLTWH(ACtrl)
                    +'"' //style ���
                    +Format(_DWEVENT,['change',Name,'String(this.'+Name+'__val)','onchange',''])
                    +'>');
          Result.Add('    <option class="dwoption" v-for=''(item,index) in '+Name+'__its''  :value=item.value :key=''index''>{{ item.text }}</option>');

     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</select>"]');
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
     with TListBox(ACtrl) do begin
          //
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //���ѡ��
          sCode     := Name+'__its'+ASeparator+'[';
          for iItem := 0 to Items.Count-1 do begin
               sCode     := sCode + '{text:'''+Items[iItem]+''',value:'''+IntToStr(iItem)+'''},';
          end;
          Delete(sCode,Length(sCode),1);
          sCode     := sCode + ']';
          Result.Add(sCode);
          //
          sCode     := '';
          for iItem := 0 to Items.Count-1 do begin
               if Selected[iItem] then begin
                    sCode     := sCode + IntToStr(iItem)+',';
               end
          end;
          if sCode<>'' then begin
               Delete(sCode,Length(sCode),1);
          end;
          Result.Add(Name+'__val'+ASeparator+'['+sCode+']');
     end;
end;


end.
