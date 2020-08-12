library dwTComboBox;

uses
     ShareMem,

     //
     dwCtrlBase,

     //
     SynCommons,

     //
     SysUtils,
     Classes,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//当前控件需要引入的第三方JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
end;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     joData    : Variant;
begin
     //
     joData    := _Json(AData);

     if joData.event = 'onchange' then begin
          //保存事件
          TComboBox(ACtrl).OnExit    := TComboBox(ACtrl).OnChange;
          //清空事件,以防止自动执行
          TComboBox(ACtrl).OnChange  := nil;
          //更新值
          TComboBox(ACtrl).Text    := dwUnescape(joData.value);
          //恢复事件
          TComboBox(ACtrl).OnChange  := TComboBox(ACtrl).OnExit;

          //执行事件
          if Assigned(TComboBox(ACtrl).OnChange) then begin
               TComboBox(ACtrl).OnChange(TComboBox(ACtrl));
          end;

          //清空OnExit事件
          TComboBox(ACtrl).OnExit  := nil;
     end;
end;


//取得HTML头部消息
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     with TComboBox(ACtrl) do begin
          //
          joRes.Add('<el-select'
                    +' v-model="'+Name+'__txt"'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style 封闭
                    +Format(_DWEVENT,['change',Name,'this.'+Name+'__txt','onchange',''])
                    +'>');
          joRes.Add('    <el-option v-for="item in '+Name+'__options" :key="item.value" :label="item.value" :value="item.value"/>');

     end;

     //
     Result    := (joRes);
end;

//取得HTML尾部消息
function dwGetTail(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //生成返回值数组
     joRes.Add('</el-select>');
     //
     Result    := (joRes);
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TComponent;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
     sCode     : string;
     iItem     : Integer;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TComboBox(ACtrl) do begin
          //添加选项
          sCode     := Name+'__options'+ASeparator+'[';
          for iItem := 0 to Items.Count-1 do begin
               sCode     := sCode + '{value:'''+Items[iItem]+'''},';
          end;
          Delete(sCode,Length(sCode),1);
          sCode     := sCode + ']';
          joRes.Add(sCode);
          //
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          if dwGetProp(TControl(ACtrl),'height')='' then begin
               joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          end else begin
               joRes.Add(Name+'__hei'+ASeparator+'"'+dwGetProp(TControl(ACtrl),'height')+'px"');
          end;
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__txt'+ASeparator+'"'+Text+'"');
     end;
     //
     Result    := (joRes);
end;


exports
     dwGetExtra,
     dwGetEvent,
     dwGetHead,
     dwGetTail,
     dwGetData;
     
begin
end.
 
