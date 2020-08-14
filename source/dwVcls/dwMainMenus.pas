unit dwMainMenus;

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



//����ֵ˵�� : ����һ���ַ�������(ÿ��Ԫ�ش���һ��,�Դ���ǰ����)

//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TComponent):Variant;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TComponent):Variant;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TComponent;ASeparator:String):Variant;

//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TComponent;AData:Variant):String;


implementation

function _GetFont(AFont:TFont):string;
begin
     Result    := 'color:'+dwColor(AFont.color)+';'
               +'font-family:'''+AFont.name+''';'
               +'font-size:'+IntToStr(AFont.size)+'pt;';

     //����
     if fsBold in AFont.Style then begin
          Result    := Result+'font-weight:bold;';
     end else begin
          Result    := Result+'font-weight:normal;';
     end;

     //б��
     if fsItalic in AFont.Style then begin
          Result    := Result+'font-style:italic;';
     end else begin
          Result    := Result+'font-style:normal;';
     end;

     //�»���
     if fsUnderline in AFont.Style then begin
          Result    := Result+'text-decoration:underline;';
          //ɾ����
          if fsStrikeout in AFont.Style then begin
               Result    := Result+'text-decoration:line-through;';
          end;
     end else begin
          //ɾ����
          if fsStrikeout in AFont.Style then begin
               Result    := Result+'text-decoration:line-through;';
          end else begin
               Result    := Result+'text-decoration:none;';
          end;
     end;
end;




//����JSON����ADataִ�е�ǰ�ؼ����¼�, �����ؽ���ַ���
function dwEvent(ACtrl:TComponent;AData:Variant):String;
begin
     //
     //TMainMenu(ACtrl).OnClick(TMainMenu(ACtrl));
end;


//ȡ��HTMLͷ����Ϣ
function dwGetHtmlHead(ACtrl:TComponent):Variant;
var
     sCode     : string;
     joHint    : Variant;
     iItem     : Integer;
     //
     oItem     : TMenuItem;
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
                    ACode     := ACode + '<el-menu-item index="'+APath+'-'+IntToStr(ii)+'">'+jjItem.caption+'</el-menu-item>'#13;
               end else begin
                    ACode     := ACode + '<el-submenu index="'+APath+'-'+IntToStr(ii)+'">'#13;
                    ACode     := ACode + '<template slot="title">'+jjItem.caption+'</template>'#13;

                    //
                    ssPath    := APath+'-'+IntToStr(ii);

                    _CreateItems(jjItem,ssPath,ACode);


                    //
                    ACode     := ACode + '    </template>'#13;
                    ACode     := ACode + '</el-submenu>'#13;
               end;
          end;

     end;

begin
(*

               //
               AHtml.Add(sp + '<el-menu  class="el-menu-demo" mode="horizontal"'
                    +' background-color="#545c64" text-color="#fff" active-text-color="#ffd04b"'
                    +' @select="'+AJson.name+'__click"'+LTWH+'line-height:'+IntToStr(AJson.height-2)+'px;">');

               //�ݹ�����
               _CreateItems(AJson,'',s1);

               //
               AHtml.Add(sp + '</el-menu>');

*)
     //���ɷ���ֵ����
     Result    := _Json('[]');


     with TMainMenu(ACtrl) do begin
          sCode     := '<el-menu'
                    +' class="el-menu-demo"'
                    +dwIIF(ownerDraw,'',' mode="horizontal"')
                    +' background-color="#545c64" text-color="#fff" active-text-color="#ffd04b"'
                    //+dwVisible(ACtrl)
                    //+dwDisable(ACtrl)
                    +dwLTWHComp(ACtrl)
                    +'"' //style ���
                    //+Format(_DWEVENT,['click',Name,'0','onclick',''])
                    +'>';
          //�������
          Result.Add(sCode);

          //
          sCode      := '';

          for iItem := 0 to Items.Count-1 do begin
               oItem     := Items[iItem];
               if oItem.Count = 0 then begin
                    Result.Add('<el-menu-item index="'+IntToStr(iItem)+'">'+oItem.Caption+'</el-menu-item>');
               end else begin
                    Result.Add('<el-submenu index="'+IntToStr(iItem)+'">');
                    Result.Add('<template slot="title">'+oItem.Caption+'</template>');
                    //
                    _CreateItems(oItem,IntToStr(iItem+1),sCode);
                    Result.Add(sCode);
                    sCode     := '';
                    //
                    Result.Add('</el-submenu>');
               end;
          end;
          //�������
          Result.Add(sCode);
     end;
end;

//ȡ��HTMLβ����Ϣ
function dwGetHtmlTail(ACtrl:TComponent):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('["</el-menu>"]');
end;

//ȡ��Data��Ϣ, ASeparatorΪ�ָ���, һ��Ϊ:��=
function dwGetData(ACtrl:TComponent;ASeparator:String):Variant;
begin
     //���ɷ���ֵ����
     Result    := _Json('[]');
     //
     with TMainMenu(ACtrl) do begin
          Result.Add(Name+'__lef'+ASeparator+'"'+IntToStr(DesignInfo div 10000)+'px"');
          Result.Add(Name+'__top'+ASeparator+'"'+IntToStr(DesignInfo mod 10000)+'px"');
          Result.Add(Name+'__wid'+ASeparator+'"'+IntToStr(Tag div 10000)+'px"');
          Result.Add(Name+'__hei'+ASeparator+'"'+IntToStr(Tag mod 10000)+'px"');
     end;
end;



end.
