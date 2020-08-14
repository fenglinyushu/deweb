unit dwMainMenu;

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

function _GetFont(AFont:TFont):string;
begin
     Result    := 'color:'+dwColor(AFont.color)+';'
               +'font-family:'''+AFont.name+''';'
               +'font-size:'+IntToStr(AFont.size)+'pt;';

     //粗体
     if fsBold in AFont.Style then begin
          Result    := Result+'font-weight:bold;';
     end else begin
          Result    := Result+'font-weight:normal;';
     end;

     //斜体
     if fsItalic in AFont.Style then begin
          Result    := Result+'font-style:italic;';
     end else begin
          Result    := Result+'font-style:normal;';
     end;

     //下划线
     if fsUnderline in AFont.Style then begin
          Result    := Result+'text-decoration:underline;';
          //删除线
          if fsStrikeout in AFont.Style then begin
               Result    := Result+'text-decoration:line-through;';
          end;
     end else begin
          //删除线
          if fsStrikeout in AFont.Style then begin
               Result    := Result+'text-decoration:line-through;';
          end else begin
               Result    := Result+'text-decoration:none;';
          end;
     end;
end;




//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwEvent(ACtrl:TControl;AData:Variant):String;
begin
     //
     //TMainMenu(ACtrl).OnClick(TMainMenu(ACtrl));
end;


//取得HTML头部消息
function dwGetHtmlHead(ACtrl:TControl):Variant;
var
     sCode     : string;
     joHint    : Variant;
     function _CreateItems (AItem:TMenuItem;APath:String; var ACode:String):Integer;
     var
          ii        : Integer;
          ii1       : Integer;
          jjItem    : TMenuItem;
          jjItem1   : TMenuItem;
          ssPath    : String;
     begin
          //
          for ii := 0 to AItem.Count-1 do begin
               jjItem   := AItem.items[ii];
               //
               if jjItem.Count = 0 then begin
                    if APath = '' then begin
                         ACode     := ACode + #13 + '<el-menu-item index="'+IntToStr(ii)+'">'+jjItem.caption+'</el-menu-item>';
                    end else begin
                         ACode     := ACode + #13 + '<el-menu-item index="'+APath+'-'+IntToStr(ii)+'">'+jjItem.caption+'</el-menu-item>';
                    end;
               end else begin
                    if APath = '' then begin
                         ACode     := ACode + #13 + '<el-submenu index="'+IntToStr(ii)+'">';
                    end else begin
                         ACode     := ACode + #13 + '<el-submenu index="'+APath+'-'+IntToStr(ii)+'">';
                    end;
                    ACode     := ACode + #13 + '<template slot="title">'+jjItem.caption+'</template>';

                    //
                    if APath = '' then begin
                         ssPath    := IntToStr(ii);
                    end else begin
                         ssPath    := APath+'-'+IntToStr(ii);
                    end;

                    _CreateItems(jjItem,ssPath,ACode);


                    //
                    ACode     := ACode + #13 + '    </template>';
                    ACode     := ACode + #13 + '</el-submenu>';
               end;
          end;

     end;

begin
(*

               //
               AHtml.Add(sp + '<el-menu  class="el-menu-demo" mode="horizontal"'
                    +' background-color="#545c64" text-color="#fff" active-text-color="#ffd04b"'
                    +' @select="'+AJson.name+'__click"'+LTWH+'line-height:'+IntToStr(AJson.height-2)+'px;">');

               //递归生成
               _CreateItems(AJson,'',s1);

               //
               AHtml.Add(sp + '</el-menu>');

*)
     //生成返回值数组
     Result    := _Json('[]');

     //取得HINT对象JSON
     joHint    := dwGetHintJson(ACtrl);

     with TMainMenu(ACtrl) do begin
          sCode     := '<el-menu'
                    +' class="el-menu-demo" mode="horizontal"'
                    +' background-color="#545c64" text-color="#fff" active-text-color="#ffd04b"'
                    +dwVisible(ACtrl)
                    +dwDisable(ACtrl)
                    +dwLTWH(ACtrl)
                    +'"' //style 封闭
                    +Format(_DWEVENT,['click',Name,'0','onclick',''])
                    +'>';
          //添加数据
          Result.Add(sCode);

          //
          sCode      := '';
          _CreateItems(TMainMenu(ACtrl),'',sCode);
     end;
end;

//取得HTML尾部消息
function dwGetHtmlTail(ACtrl:TControl):Variant;
begin
     //生成返回值数组
     Result    := _Json('["</el-menu>"]');
end;

//取得Data消息, ASeparator为分隔符, 一般为:或=
function dwGetData(ACtrl:TControl;ASeparator:String):Variant;
begin
     //生成返回值数组
     Result    := _Json('[]');
     //
     with TMainMenu(ACtrl) do begin
          //Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(Left)+'px"');
          //Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(Top)+'px"');
          //Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Width)+'px"');
          //Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Height)+'px"');
          //
          //Result.Add(Name+'__vis'+ASeparator+''+dwIIF(Visible,'true','false'));
          //Result.Add(Name+'__dis'+ASeparator+''+dwIIF(Enabled,'false','true'));
          //
          //Result.Add(Name+'__cap'+ASeparator+'"'+dwProcessCaption(Caption)+'"');
     end;
end;



end.
