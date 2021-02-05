unit qqconnect;

interface

uses
     //
     JsonDataObjects,
     IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
     //
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls  ;



function dwQQLogin(AForm:TForm;AAppID,AAppkey,ACallback:String):string;

implementation

function dwQQLogin(AForm:TForm;AAppID,AAppkey,ACallback:String):string;
var
     sHtm      : string;
     sUrl      : string;
     sParams   : string;
     sRes      : string;
     sAccessTk : String;
     sOpenId   : String;
     //
     joMsg     : TJsonObject;
     //
     slHtm     : TStringList;
begin
     //<如果当前htm不存在，则生成一个
     //取得回调HTM文件名
     sHtm      := ACallBack;
     while Pos('/',sHtm)>0 do begin
          Delete(sHtm,1,Pos('/',sHtm));
     end;

     //如果跳转文件不存在，则生成一个
     if not FileExists(sHtm) then begin
          slHtm     := TStringList.Create;
          slHtm.Add('<html><head><script type="text/javascript">function dwLoad(obj)');
          slHtm.Add('{var url0 = location.href; var sCode = url0.substring(url0.indexOf("?")+1,url0.length);');
          slHtm.Add('var url1 = ''https://www.web0000.com/qqconnect.dw?''+sCode; window.location.href = url1;}');
          slHtm.Add('</script></head><body onload="dwLoad()"></body></html>');
          slHtm.SaveToFile(sHtm);
          //
          slHtm.Destroy;
     end;
     //>

(*
     sParams   := dwGetProp(Self,'params');

     //           'https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=101559562&client_secret=75aa0edc5eaaaf452d924172bdc043fc&code=9A823FB16E6F4404FA19AC397244E0CD&redirect_uri=http://delphibbs.com/qq_login-return.htm
     sUrl      := 'https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=%s'
                    +'&client_secret=75aa0edc5eaaaf452d924172bdc043fc&'
                    +sParams
                    +'&redirect_uri=%s';
     sUrl      := Format(sUrl,[_APP_ID,_RETURN]);
     sRes      := idHttp.Get(sUrl);     //access_token=B530D1ECD731BA2144B7DE9C5A5D8A6F&expires_in=7776000&refresh_token=695053C9C9FA82BF9C124B56D89D0E1B
     Label1.Caption := sRes;


     //第三步
     sAccessTk := Copy(sRes,1,Pos('&',sRes)-1);
     sUrl      := 'https://graph.qq.com/oauth2.0/me?'+sAccessTk;
     sRes      := idHttp.Get(sUrl);     //callback( {"client_id":"101559562","openid":"FDBE598E88707259E7B8242D307BAF41"} );
     Label2.Caption := sRes;

     //第四步：https://graph.qq.com/user/get_user_info?access_token=B530D1ECD731BA2144B7DE9C5A5D8A6F&oauth_consumer_key=101559562&openid=FDBE598E88707259E7B8242D307BAF41
     Delete(sRes,1,Pos('"openid":"',sRes)+9);
     sOpenId   := Copy(sRes,1,Pos('"',sRes)-1);
     sUrl      := 'https://graph.qq.com/user/get_user_info?%s&oauth_consumer_key=%s&openid=%s';
     sUrl      := Format(sUrl,[sAccessTk,_APP_ID,sOpenId]);
     Label3.Caption := sUrl;
     sRes      := idHttp.Get(sUrl);
     //
     joMsg     := TJsonObject(TJsonObject.Parse(sRes));
     Label4.Caption := 'nickname : '+joMsg.S['nickname']+'   province : '+joMsg.S['province'];
*)
end;


end.
