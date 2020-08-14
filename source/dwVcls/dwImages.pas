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



//返回值说明 : 返回一个字符串数组(每个元素代表一行,自带当前缩进)

//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;


implementation

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;
begin
     //
     TImage(ACtrl).OnClick(TImage(ACtrl));
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     sSize     : string;
     sName     : string;
     sRadius   : string;
     
     //
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);

     //
     sRadius   := dwGetHintValue(joHint,'radius','border-radius','');
     sRadius   := StringReplace(sRadius,'=',':',[]);
     sRadius   := Trim(StringReplace(sRadius,'"','',[rfReplaceAll]));

     with TImage(ACtrl) do begin
          //如果没有手动设置图片源，则自动保存当前图片，并设置为图片源
          if dwGetProp(ACtrl,'src')='' then begin
               sName     := 'dist\webimages\'+Name+'.jpg';
               //保存图片到本地
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

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-Image>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
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
