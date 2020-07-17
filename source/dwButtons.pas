unit dwButtons;

interface

uses

     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;

function dwCreateHtml(ACtrl:TControl):String;


implementation

function dwCreateHtml(ACtrl:TControl):String;
var
     oButton   : TButton;
     sSize     : string;
     sCode     : string;
begin
     try
(*          //
          oButton   := TButton(ACtrl);

          //
          //size="medium","small","mini"
          if oButton.height>=35 then begin
               sSize     := ' size="medium"';
          end else if AJson.height>25 then begin
               sSize     := ' size="small"';
          end else begin
               sSize     := ' size="mini"';
          end;

          //生成字符串
          sCode     := SP+'<el-button'+sVI+sSize+_DIS+jhButtonType(joHint)+jhButtonIcon(joHint)+LTWHex+'" @click="'+AJson.name+'__onclick">{{'+AJson.name+'}}</el-button>';

          //
          AHtml.Add(sCode);

          //生成Data
          AData.Add(sSP6+AJson.name+':'''+AJson.caption+''',');
          AData.Add(sSP6+sVIV);    //可视
          AData.Add(sSP6+sDIS);    //禁用
          AData.Add(sSP6+sL);      //
          AData.Add(sSP6+sT);      //
          AData.Add(sSP6+sW);      //
          AData.Add(sSP6+sH);      //

          //生成Motheds
          sCode     := sSP5+AJson.name+'__onclick() { '#13
               +sSP6+'axios.get(''{"mode":"event","cid":[!clientid!],"component":"'+AJson.name+'","event":"onclick"}'') '#13
               +sSP6+'.then(resp =>{this.procResp(resp.data)});'#13
               +sSP5+'},                                                                                    ';
          AMethods.Add(sCode);
          //
          Result    := joRes.AsString;
*)
     except
          Result    := '{"html":[],"data":[],"method":[]}';
     end;
end;


end.
