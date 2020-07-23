unit dwCtrlBase;

interface

uses
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;

//根据控件的Hint生成JSON
function dwGetHintJson(ACtrl:TControl):Variant;

//生成可见性字符串
function dwVisible(ACtrl:TControl):String;

//生成可用性字符串
function dwDisable(ACtrl:TControl):String;

//生成LTWH字符串
function dwLTWH(ACtrl:TControl):String;      //可以更新位置的用法

//检查HINT的JOSN对象中如果存在在某属性,则返回字符串
//如果存在 AJsonName 则 返回 AHtmlName = AJson.AJsonName;
//                 否则 返回 ADefault
function dwGetHintValue(AHint:Variant;AJsonName,AHtmlName,ADefault:String):String;

function dwIIF(ABool:Boolean;AYes,ANo:string):string;

const
     _DWEVENT = ' @%s="dwevent(''{'                         //%s = onclick / onchange
               +'&quot;mode&quot;:&quot;event&quot;'        //"mode" : event
               +',&quot;cid&quot;:[!clientid!]'             //"cid" : 234203
               +',&quot;component&quot;:&quot;%s&quot;'     //%s = "component" : "Button1"
               +',&quot;value&quot;:%s'                     //%s = "value" : this.Edit1__tex 注意这里没有双引号
               +',&quot;event&quot;:&quot;%s&quot;'         //%s = "event" : "onclick"
               +'%s'                                        //%s = 备用, 一般为空
               +'}'')"';

implementation

function dwIIF(ABool:Boolean;AYes,ANo:string):string;
begin
     if ABool then begin
          Result    := AYes;
     end else begin
          Result    := ANo;
     end;
end;

function dwVisible(ACtrl:TControl):String;
begin
     Result    := ' v-if="'+ACtrl.Name+'__vis"';
end;

function dwDisable(ACtrl:TControl):String;
begin
     Result    := ' :disabled="'+ACtrl.Name+'__dis"';
end;

function dwGetHintJson(ACtrl:TControl):Variant;
var
     sHint     : String;
begin
     sHint     := ACtrl.Hint;
     TDocVariant.New(Result);
     if ( sHint <> '' ) and ( sHint[1] = '{' ) and ( sHint[Length(sHint)] = '}' ) then begin
          try
               Result    := _Json(sHint);
          except
               TDocVariant.New(Result);
          end;
     end;
end;

function dwLTWH(ACtrl:TControl):String;  //可以更新位置的用法
var
     joHint    : Variant;
     sZI       : String;
begin
     //
     joHint    := dwGetHintJson(ACtrl);

     //
     if joHint.Exists('z-index')  then begin
          sZI  := 'z-index:'+IntToStr(Min(joHint._('z-index'),998))+';';
     end;

     //
     with ACtrl do begin
          Result    := ' :style="{left:'+Name+'__lef,top:'+Name+'__top,width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;'+sZI;
     end;
end;

function dwGetHintValue(AHint:Variant;AJsonName,AHtmlName,ADefault:String):String;
begin
     if AHint.Exists(AJsonName) then begin
          Result    := AnsiString(' '+AHtmlName+'="'+AHint._(AJsonName)+'"');
     end else begin
          Result    := ADefault;
     end;
end;



end.
