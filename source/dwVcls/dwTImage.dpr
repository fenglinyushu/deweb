library dwTImage;

uses
     ShareMem,      //必须添加

     //
     dwCtrlBase,    //一些基础函数

     //
     SynCommons,    //mormot用于解析JSON的单元

     //
     SysUtils,DateUtils,ComCtrls, ExtCtrls,
     Classes,
     Dialogs,
     StdCtrls,
     Windows,
     Controls,
     Forms;

//当前控件需要引入的第三方JS/CSS ,一般为不做改动,目前仅在TChart使用时需要用到
function dwGetExtra(ACtrl:TComponent):string;stdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     {
     //以下是TChart时的代码,供参考
     joRes.Add('<script src="dist/charts/echarts.min.js"></script>');
     joRes.Add('<script src="dist/charts/lib/index.min.js"></script>');
     joRes.Add('<link rel="stylesheet" href="dist/charts/lib/style.min.css">');
     }

     //
     Result    := joRes;
end;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
var
     joData    : Variant;
begin
     //
     joData    := _Json(AData);

     if joData.event = 'onclick' then begin
          //
          if Assigned(TImage(ACtrl).OnClick) then begin
               TImage(ACtrl).OnClick(TImage(ACtrl));
          end;
     end else if joData.event = 'onenter' then begin
          //
          if Assigned(TImage(ACtrl).OnMouseEnter) then begin
               TImage(ACtrl).OnMouseEnter(TImage(ACtrl));
          end;
     end else if joData.event = 'onexit' then begin
          //
          if Assigned(TImage(ACtrl).OnMouseLeave) then begin
               TImage(ACtrl).OnMouseLeave(TImage(ACtrl));
          end;
     end;

end;


//取得HTML头部消息
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     sSize     : string;
     sName     : string;
     sRadius   : string;
     //
     joHint    : Variant;
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(TControl(ACtrl));

     //得到圆角半径信息
     sRadius   := dwGetHintValue(joHint,'radius','border-radius','');
     sRadius   := StringReplace(sRadius,'=',':',[]);
     sRadius   := Trim(StringReplace(sRadius,'"','',[rfReplaceAll]));
     if sRadius<>'' then begin
          sRadius   := sRadius + ';';
     end;

     with TImage(ACtrl) do begin
          //如果没有手动设置图片源，则自动保存当前图片，并设置为图片源
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               sName     := 'dist\webimages\'+Name+'.jpg';
               //保存图片到本地
               if not FileExists(sName) then begin
                    Picture.SaveToFile(sName);
               end;
          end;

          if Proportional then begin
               joRes.Add('<el-image :src="'+Name+'__src" fit="contain"'
                         +dwVisible(TControl(ACtrl))
                         +dwDisable(TControl(ACtrl))
                         +dwLTWH(TControl(ACtrl))
                         +sRadius
                         +dwIIF(Assigned(OnClick),'cursor: pointer;','')
                         +'"'
                         +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                         +dwIIF(Assigned(OnMouseEnter),Format(_DWEVENT,['mouseenter.native',Name,'0','onenter','']),'')
                         +dwIIF(Assigned(OnMOuseLeave),Format(_DWEVENT,['mouseleave.native',Name,'0','onexit','']),'')
                         +'>');
          end else begin
               if Stretch then begin
                    joRes.Add('<el-image :src="'+Name+'__src" fit="fill"'
                              +dwVisible(TControl(ACtrl))
                              +dwDisable(TControl(ACtrl))
                              +dwLTWH(TControl(ACtrl))
                              +sRadius
                              +dwIIF(Assigned(OnClick),'cursor: pointer;','')
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                              +dwIIF(Assigned(OnMouseEnter),Format(_DWEVENT,['mouseenter.native',Name,'0','onenter','']),'')
                              +dwIIF(Assigned(OnMOuseLeave),Format(_DWEVENT,['mouseleave.native',Name,'0','onexit','']),'')
                         +'>');
               end else begin
                    joRes.Add('<el-image :src="'+Name+'__src" fit="none"'
                              +dwVisible(TControl(ACtrl))
                              +dwDisable(TControl(ACtrl))
                              +dwLTWH(TControl(ACtrl))
                              +sRadius
                              +dwIIF(Assigned(OnClick),'cursor: pointer;','')
                              +'"'
                              +dwIIF(Assigned(OnClick),Format(_DWEVENT,['click',Name,'0','onclick','']),'')
                              +dwIIF(Assigned(OnMouseEnter),Format(_DWEVENT,['mouseenter.native',Name,'0','onenter','']),'')
                              +dwIIF(Assigned(OnMOuseLeave),Format(_DWEVENT,['mouseleave.native',Name,'0','onexit','']),'')
                         +'>');
               end;
          end;
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
     joRes.Add('</el-Image>');          //此处需要和dwGetHead对应

     //
     Result    := (joRes);
end;

//取得Data
function dwGetData(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TImage(ACtrl) do begin
          joRes.Add(Name+'__lef:"'+IntToStr(Left)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(Top)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Width)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Height)+'px",');
          //
          joRes.Add(Name+'__vis:'+dwIIF(Visible,'true,','false,'));
          joRes.Add(Name+'__dis:'+dwIIF(Enabled,'false,','true,'));
          //
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               joRes.Add(Name+'__src:"dist/webimages/'+Name+'.jpg",');
          end else begin
               joRes.Add(Name+'__src:"'+dwGetProp(TControl(ACtrl),'src')+'",');
          end;
     end;
     //
     Result    := (joRes);
end;

function dwGetMethod(ACtrl:TComponent):string;StdCall;
var
     joRes     : Variant;
begin
     //生成返回值数组
     joRes    := _Json('[]');
     //
     with TImage(ACtrl) do begin
          joRes.Add('this.'+Name+'__lef="'+IntToStr(Left)+'px";');
          joRes.Add('this.'+Name+'__top="'+IntToStr(Top)+'px";');
          joRes.Add('this.'+Name+'__wid="'+IntToStr(Width)+'px";');
          joRes.Add('this.'+Name+'__hei="'+IntToStr(Height)+'px";');
          //
          joRes.Add('this.'+Name+'__vis='+dwIIF(Visible,'true;','false;'));
          joRes.Add('this.'+Name+'__dis='+dwIIF(Enabled,'false;','true;'));
          //
          if dwGetProp(TControl(ACtrl),'src')='' then begin
               joRes.Add('this.'+Name+'__src="dist/webimages/'+Name+'.jpg";');
          end else begin
               joRes.Add('this.'+Name+'__src="'+dwGetProp(TControl(ACtrl),'src')+'";');
          end;
     end;
     //
     Result    := (joRes);
end;


exports
     dwGetExtra,
     dwGetEvent,
     dwGetHead,
     dwGetTail,
     dwGetMethod,
     dwGetData;
     
begin
end.
 
