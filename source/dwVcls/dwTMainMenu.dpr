library dwTMainMenu;

uses
     ShareMem,

     //
     dwCtrlBase,

     //
     SynCommons,

     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls, Menus,
     StdCtrls, Windows;

//当前控件需要引入的第三方JS/CSS
function dwGetExtra(ACtrl:TComponent):string;stdCall;
begin
     Result    := '[]';
end;

//根据JSON对象AData执行当前控件的事件, 并返回结果字符串
function dwGetEvent(ACtrl:TComponent;AData:String):string;StdCall;
begin
     //
     //if Assigned(TMainMenu(ACtrl).OnClick) then begin
     //     TMainMenu(ACtrl).OnClick(TMainMenu(ACtrl));
     //end;
end;

function _CreateItems (AItem:TMenuItem;APath:String; var ACode:String):Integer;
var
     ii        : Integer;
     ii1       : Integer;
     miItem    : TMenuItem;
     ssPath    : String;
begin
     //
     for ii := 0 to AItem.Count-1 do begin
          miItem   := AItem.items[ii];
          //
          if miItem.Count = 0 then begin
{
<el-menu-item index="3" disabled>
        <i class="el-icon-document"></i>
        <span slot="title">导航三</span>
      </el-menu-item>
}
               if (miItem.ImageIndex>0)and(miItem.ImageIndex<=High(dwIcons)) then begin
                    ACode     := ACode + '<el-menu-item index="'+APath+'-'+IntToStr(ii)+'">'
                    +'<i class="'+dwIcons[miItem.ImageIndex]+'"></i>'
                    +'<span slot="title">'+miItem.caption+'</span>'
                    +'</el-menu-item>'#13;
               end else begin

                    ACode     := ACode + '<el-menu-item index="'+APath+'-'+IntToStr(ii)+'">'
                    +miItem.caption+'</el-menu-item>'#13;
               end;
          end else begin
               ACode     := ACode + '<el-submenu index="'+APath+'-'+IntToStr(ii)+'"><template slot="title">'#13;
               if (miItem.ImageIndex>0)and(miItem.ImageIndex<=High(dwIcons)) then begin
                    ACode     := ACode + '<i class="'+dwIcons[miItem.ImageIndex]+'"></i>';
               end;
               ACode     := ACode + '<span>'+miItem.caption+'</span></template>'#13;

               //
               ssPath    := APath+'-'+IntToStr(ii);

               _CreateItems(miItem,ssPath,ACode);


               //
               ACode     := ACode + '    </template>'#13;
               ACode     := ACode + '</el-submenu>'#13;
          end;
     end;

end;



//取得HTML头部消息
function dwGetHead(ACtrl:TComponent):string;StdCall;
var
     sCode     : string;
     joHint    : Variant;
     joRes     : Variant;
     iItem     : Integer;
     oItem     : TMenuItem;
begin
     //生成返回值数组
     joRes    := _Json('[]');

     with TMainMenu(ACtrl) do begin
          sCode     := '<el-menu'
                    +' class="el-menu-demo"'
                    +dwIIF(ownerDraw,'',' mode="horizontal"')
                    +' background-color="#545c64"'
                    +' text-color="#fff"'
                    +' active-text-color="#ffd04b"'
                    //+dwVisible(ACtrl)
                    //+dwDisable(ACtrl)
                    +dwLTWHComp(ACtrl)
                    +dwIIF(ownerDraw,'line-height:30px;','line-height:'+IntToStr((Tag mod 10000)-22)+'px;')
                    +'"' //style 封闭
                    //+Format(_DWEVENT,['click',Name,'0','onclick',''])
                    +'>';
          //添加数据
          joRes.Add(sCode);

          //
          sCode      := '';

          for iItem := 0 to Items.Count-1 do begin
               oItem     := Items[iItem];
               if oItem.Count = 0 then begin
                    if (oItem.ImageIndex>0)and(oItem.ImageIndex<=High(dwIcons)) then begin
                         joRes.Add('<el-menu-item index="'+IntToStr(iItem)+'">'
                              +'<i class="'+dwIcons[oItem.ImageIndex]+'"></i>'
                              +'<span slot="title">'+oItem.caption+'</span>'
                              +'</el-menu-item>');
                    end else begin
                         joRes.Add('<el-menu-item index="'+IntToStr(iItem)+'">'+oItem.Caption+'</el-menu-item>');
                    end;

               end else begin
                    joRes.Add('<el-submenu index="'+IntToStr(iItem)+'"><template slot="title">');
                    if (oItem.ImageIndex>0)and(oItem.ImageIndex<=High(dwIcons)) then begin
                         joRes.Add('<i class="'+dwIcons[oItem.ImageIndex]+'"></i>');
                    end;
                    joRes.Add('<span>'+oItem.Caption+'</span></template>');
                    //
                    _CreateItems(oItem,IntToStr(iItem+1),sCode);
                    joRes.Add(sCode);
                    sCode     := '';
                    //
                    joRes.Add('</el-submenu>');
               end;
          end;
          //添加数据
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
     joRes.Add('</el-menu>');
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
     with TMainMenu(ACtrl) do begin
          joRes.Add(Name+'__lef:"'+IntToStr(DesignInfo div 10000)+'px",');
          joRes.Add(Name+'__top:"'+IntToStr(DesignInfo mod 10000)+'px",');
          joRes.Add(Name+'__wid:"'+IntToStr(Tag div 10000)+'px",');
          joRes.Add(Name+'__hei:"'+IntToStr(Tag mod 10000)+'px",');
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
     with TMainMenu(ACtrl) do begin
          joRes.Add('this.'+Name+'__lef="'+IntToStr(DesignInfo div 10000)+'px";');
          joRes.Add('this.'+Name+'__top="'+IntToStr(DesignInfo mod 10000)+'px";');
          joRes.Add('this.'+Name+'__wid="'+IntToStr(Tag div 10000)+'px";');
          joRes.Add('this.'+Name+'__hei="'+IntToStr(Tag mod 10000)+'px";');
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
 
