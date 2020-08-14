unit dwSpinEdits;

interface

uses
     //
     dwCtrlBase,

     //
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,     Controls, Forms, Dialogs, ComCtrls,
     ExtCtrls, Spin, Grids,  Math,typinfo, DateUtils, StdCtrls, Menus, Windows,Types;

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
     //保存事件
     TSpinEdit(ACtrl).OnExit    := TSpinEdit(ACtrl).OnChange;
     //清空事件,以防止自动执行
     TSpinEdit(ACtrl).OnChange  := nil;
     //更新值
     TSpinEdit(ACtrl).Text    := dwUnescape(AData.value);
     //恢复事件
     TSpinEdit(ACtrl).OnChange  := TSpinEdit(ACtrl).OnExit;

     //执行事件
     if Assigned(TSpinEdit(ACtrl).OnChange) then begin
          TSpinEdit(ACtrl).OnChange(TSpinEdit(ACtrl));
     end;

     //清空OnExit事件
     TSpinEdit(ACtrl).OnExit  := nil;
end;


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
     with TSpinEdit(ACtrl) do begin
          if ( maxvalue =  0 ) and  ( maxvalue =  0 ) then begin
               Result.Add('<el-input-number'
                         +' v-model="'+Name+'__val"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +dwLTWH(ACtrl)
                         +'"' //style 封闭
                         +Format(_DWEVENT,['change',Name,'(this.'+Name+'__val)','onchange',''])
                         +'>');
                         //+sVI+_DIS+LTWHex+'"></el-input-number>');
                         //@change="'+AJson.name+'__onchange"
          end else begin
               Result.Add('<el-input-number'
                         +' v-model="'+Name+'__val"'
                         +' :min="'+Name+'__min" :max="'+Name+'__max"'
                         +dwVisible(ACtrl)
                         +dwDisable(ACtrl)
                         +dwLTWH(ACtrl)
                         +'"' //style 封闭
                         +Format(_DWEVENT,['change',Name,'(this.'+Name+'__val)','onchange',''])
                         +'>');
               //Result.Add(SP+'<el-input-number @change="'+AJson.name+'__onchange" v-model="'+AJson.name+'"'
               //          +' :min="'+sNA+'__min" :max="'+sNA+'__max"'+sVI+_DIS+LTWHex+'"></el-input-number>');
          end;
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-input-number>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TSpinEdit(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          Result.Add(Name+'__val'+ASeparator+'"'+IntToStr(Value)+'"');
          Result.Add(Name+'__min'+ASeparator+'"'+IntToStr(MinValue)+'"');
          Result.Add(Name+'__max'+ASeparator+'"'+IntToStr(MaxValue)+'"');
     end;
end;







end.
