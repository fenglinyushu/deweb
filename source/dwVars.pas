unit dwVars;

interface

uses

     //
     OverbyteIcsWinSock,  OverbyteIcsWSocket, OverbyteIcsWndControl,
     OverbyteIcsHttpSrv, OverbyteIcsUtils, OverbyteIcsFormDataDecoder, OverbyteIcsMimeUtils,

     //
     Windows, Messages, SysUtils, Classes, Controls, Forms,Dialogs,
     StdCtrls, ExtCtrls, StrUtils;

var
     gsMainDir           : string;           //Ö´ÐÐÄ¿Â¼

     //
     giPort              : Integer = 80;     //¶Ë¿Ú

     //
     gfStartTime         : Double;           //DeWeb Start Time

Type
     PdwGetExtra    = function (ACtrl:TComponent):string;stdcall;
     PdwGetEvent    = function (ACtrl:TComponent;AData:String):string;StdCall;
     PdwGetHead     = function (ACtrl:TComponent):string;StdCall;
     PdwGetTail     = function (ACtrl:TComponent):string;StdCall;
     PdwGetData     = function (ACtrl:TComponent):string;StdCall;
     PdwGetMethod   = function (ACtrl:TComponent):string;StdCall;



implementation






end.
