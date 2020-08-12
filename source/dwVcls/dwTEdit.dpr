library dwTEdit;

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
          TEdit(ACtrl).OnExit    := TEdit(ACtrl).OnChange;
          //清空事件,以防止自动执行
          TEdit(ACtrl).OnChange  := nil;
          //更新值
          TEdit(ACtrl).Text    := dwUnescape(joData.value);
          //恢复事件
          TEdit(ACtrl).OnChange  := TEdit(ACtrl).OnExit;

          //执行事件
          if Assigned(TEdit(ACtrl).OnChange) then begin
               TEdit(ACtrl).OnChange(TEdit(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
          //保存事件
          TEdit(ACtrl).OnExit    := TEdit(ACtrl).OnEnter;
          //清空事件,以防止自动执行
          TEdit(ACtrl).OnEnter  := nil;
          //更新值
          TEdit(ACtrl).Text    := dwUnescape(joData.value);
          //恢复事件
          TEdit(ACtrl).OnEnter  := TEdit(ACtrl).OnExit;

          //执行事件
          if Assigned(TEdit(ACtrl).OnEnter) then begin
               TEdit(ACtrl).OnEnter(TEdit(ACtrl));
          end;
     end;

     //清空OnExit事件
     TEdit(ACtrl).OnExit  := nil;
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
     with TEdit(ACtrl) do begin
          sCode     := '<el-input'
                    +dwVisible(TControl(ACtrl))
                    +dwDisable(TControl(ACtrl))
                    +dwIIF(PasswordChar=#0,'',' show-password')
                    +' v-model="'+Name+'__txt"'
                    +dwGetHintValue(joHint,'placeholder','placeholder','')         //placeholder
                    +dwGetHintValue(joHint,'prefix-icon','prefix-icon','')         //Icon
                    +dwGetHintValue(joHint,'suffix-icon','suffix-icon','')         //Icon
                    +dwLTWH(TControl(ACtrl))
                    +'"' //style 封闭
                    +Format(_DWEVENT,['input',Name,'(this.'+Name+'__txt)','onchange',''])
                    +Format(_DWEVENT,['focus',Name,'(this.'+Name+'__txt)','onenter',''])
                    +'>';
          //添加到返回值数据
          joRes.Add(sCode);
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
     joRes.Add('</el-input>');
     //
     Result    := (joRes);
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TComponent;ASeparator:String):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TEdit(ACtrl) do begin
          joRes.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          joRes.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          joRes.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          joRes.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          joRes.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          joRes.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          joRes.Add(Name+'__txt'+ASeparator+'"'+(Text)+'"');
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
 
