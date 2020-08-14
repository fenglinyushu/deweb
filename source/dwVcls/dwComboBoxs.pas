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
     TComboBox(ACtrl).OnExit    := TComboBox(ACtrl).OnChange;
     //清空事件,以防止自动执行
     TComboBox(ACtrl).OnChange  := nil;
     //更新值
     TComboBox(ACtrl).Text    := dwUnescape(AData.value);
     //恢复事件
     TComboBox(ACtrl).OnChange  := TComboBox(ACtrl).OnExit;

     //执行事件
     if Assigned(TComboBox(ACtrl).OnChange) then begin
          TComboBox(ACtrl).OnChange(TComboBox(ACtrl));
     end;

     //清空OnExit事件
     TComboBox(ACtrl).OnExit  := nil;
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var

     //
     joHint    : Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);

     //


     with TComboBox(ACtrl) do begin
          //
          Result.Add('<el-select'
                    +' v-model="'+Name+'__txt"'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +Format(_DWEVENT,['change',Name,'this.'+Name+'__txt','onchange',''])
                    +'>');
          Result.Add('    <el-option v-for="item in '+Name+'__options" :key="item.value" :label="item.value" :value="item.value"/>');

     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-select>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
var
     iItem     : Integer;
     sCode     : String;
begin
     //生成返回值数组
     Result    := _Json('[]');

     //生成Data:选项

     //
     with TComboBox(ACtrl) do begin
          //添加选项
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
