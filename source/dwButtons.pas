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



//返回值说明 : 返回一个字符串数组(每个元素代表一行,自带当前缩进)

//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;

//取得Data消息
function dwGetData(ACtrl:TControl):Variant;

//检查当前控件是否是父控件
function dwIsParent(ACtrl:TControl):Boolean;


implementation


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);

     with TButton(ACtrl) do begin
          sCode     := '<el-button'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwGetHintValue(joHint,'type','type',' type="default"')         //sButtonType
                    +dwGetHintValue(joHint,'icon','icon','')         //ButtonIcon
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    //+dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                    +'>{{'+Name+'__cap}}';
          //添加到返回值数据
          Result.Add(sCode);
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-button>"]');
end;

//取得Data消息
function dwGetData(ACtrl:TControl):Variant;
begin
     //生成返回值数组
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

//检查当前控件是否是父控件
function dwIsParent(ACtrl:TControl):Boolean;
begin
     Result    := False;
end;




end.
