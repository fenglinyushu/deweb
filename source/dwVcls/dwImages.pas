unit dwImages;

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
     //
     TImage(ACtrl).OnClick(TImage(ACtrl));
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     sSize     : string;
     sName     : string;
     sRadius   : string;
     
     //
     joHint    : Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');

     //ȡ��HINT����JSON
     joHint    := dwGetHintJson(ACtrl);

     //
     sRadius   := dwGetHintValue(joHint,'radius','border-radius','');
     sRadius   := StringReplace(sRadius,'=',':',[]);
     sRadius   := Trim(StringReplace(sRadius,'"','',[rfReplaceAll]));

     with TImage(ACtrl) do begin
          //���û���ֶ�����ͼƬԴ�����Զ����浱ǰͼƬ��������ΪͼƬԴ
          if dwGetProp(ACtrl,'src')='' then begin
               sName     := 'dist\webimages\'+Name+'.jpg';
               //����ͼƬ������
               if not FileExists(sName) then begin
                    Picture.SaveToFile(sName);
               end;
          end;

          if Proportional then begin
               Result.Add('<el-image :src="'+Name+'__src" fit="contain"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +dwLTWH(ACtrl)
                         +sRadius
                         +'"'
                         +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +'>');
          end else begin
               if Stretch then begin
                    Result.Add('<el-image :src="'+Name+'__src" fit="fill"'
                              +dwVisible(ACtrl)
                              +dwDisable(ACtrl)
                              +dwLTWH(ACtrl)
                              +sRadius
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +'>');
               end else begin
                    Result.Add('<el-image :src="'+Name+'__src" fit="none"'
                              +dwVisible(ACtrl)
                              +dwDisable(ACtrl)
                              +dwLTWH(ACtrl)
                              +sRadius
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +'>');
               end;
          end;
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-Image>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TImage(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+dwIIF(Enabled,'false','true'));
          //
          if dwGetProp(ACtrl,'src')='' then begin
               Result.Add(Name+'__src'+ASeparator+'"dist/webimages/'+Name+'.jpg"');
          end else begin
               Result.Add(Name+'__src'+ASeparator+'"'+dwGetProp(ACtrl,'src')+'"');
          end;
     end;
end;


end.
