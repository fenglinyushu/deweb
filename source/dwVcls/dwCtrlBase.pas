unit dwCtrlBase;

interface

uses
     SynCommons,
     
     //��MD5
     IdHashMessageDigest,IdGlobal, IdHash,
     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;

//���ݿؼ���Hint����JSON
function dwGetHintJson(ACtrl:TControl):Variant;

//���ɿɼ����ַ���
function dwVisible(ACtrl:TControl):String;

//���ɿ������ַ���
function dwDisable(ACtrl:TControl):String;

//����LTWH�ַ���
function dwLTWH(ACtrl:TControl):String;      //���Ը���λ�õ��÷�
function dwLTWHComp(ACtrl:TComponent):String;  //���Ը���λ�õ��÷�

//���HINT��JOSN���������������ĳ����,�򷵻��ַ���
//������� AJsonName �� ���� AHtmlName = AJson.AJsonName;
//                 ���� ���� ADefault
function dwGetHintValue(AHint:Variant;AJsonName,AHtmlName,ADefault:String):String;

function dwIIF(ABool:Boolean;AYes,ANo:string):string;

const
     _DWEVENT = ' @%s="dwevent($event,''%s'',''%s'',''%s'',''%s'')"';            //��������Ϊ:JS�¼����� ---  �ؼ�����,�ؼ�ֵ,D�¼�����,����

//���ܺ���
function dwDecryptKey (Src:String; Key:String):string;

//Delphi ��ɫתHTML ��ɫ�ַ���
function dwColor(AColor:Integer):string;

//
function dwEncodeURIComponent(S:AnsiString):AnsiString;

function dwBoolToStr(AVal:Boolean):string;
function dwIsNull(AVar:Variant):Boolean;

//����DELPHI�е������ַ�
function dwConvertStr(AStr:String):String;

//����DELPHI��Caption�������ַ�
function dwProcessCaption(AStr:String):String;

//���ڶ����Ľ��б���, ��ӦJS�е�escape����
function dwEscape(const StrToEscape:string):String;
function dwUnescape(S: string): string;

//����/��ȡ��Hint�д�ŵ�ֵ
function dwSetProp(ACtrl:TControl;AAttr,AValue:String):Integer;
function dwGetProp(ACtrl:TControl;AAttr:String):String;
function dwGetJsonAttr(AJson:Variant;AAttr:String):String;   //��JSON�����ж�ȡ����ֵ

//��ȡ������Բ����Ϣ
function dwRadius(AJson:Variant):string;

//����ACtrl����Ҫ��.   AHorzΪ��ʱ ˮƽ�ȿ�����, ����ֱ����
procedure dwRealignChildren(ACtrl:TWinControl;AHorz:Boolean;ASize:Integer);



//Memo.textת��Ϊelemenu Textarea �ĸ�ʽ
function  dwMemoValueToText(AText:string):string;
function  dwMemoTextToValue(AText:string):string;

procedure showMsg(AMsg:string);

//����Height
function  dwSetHeight(AControl:TControl;AHeight:Integer):Integer;

//����PlaceHolder
function  dwSetPlaceHodler(AControl:TControl;APH:String):Integer;

//����LTWH
function  dwSetCompLTWH(AComponent:TComponent;ALeft,ATop,AWidth,AHeight:Integer):Integer;

//�����뺯��
function  dwDecode(AText:string):string;

//
function dwPHPToDate(ADate:Integer):TDateTime;

//
function dwLongStr(AText:String):String;

//����Panel���ӿؼ�
procedure dwRealignPanel(APanel:TPanel;AHorz:Boolean);

const
     _Head : string =
          '<!DOCTYPE html>                                                                    '#13
          +'<html lang="en">                                                                  '#13
          +'                                                                                  '#13
          +'<head>                                                                            '#13
          +'    <meta charset="utf-8">                                                        '#13
          +'    <meta name="viewport" content="width=device-width, initial-scale=1.0">        '#13
          +'    <meta http-equiv="X-UA-Compatible" content="ie=edge">                         '#13
          +'    <title>[!!!]</title>                                                          '#13
          +'</head>                                                                           '#13;

     _LOADING  : string =
           '    <style type="text/css">                                             '#13
          +'         #Loading {                                                     '#13
          +'              top: 50%;                                                 '#13
          +'              left: 50%;                                                '#13
          +'              position: absolute;                                       '#13
          +'              -webkit-transform: translateY(-50%) translateX(-50%);     '#13
          +'              transform: translateY(-50%) translateX(-50%);             '#13
          +'              z-index: 100;                                             '#13
          +'         }                                                              '#13
          +'         @-webkit-keyframes ball-beat {                                 '#13
          +'              50% {                                                     '#13
          +'                   opacity: 0.2;                                        '#13
          +'                   -webkit-transform: scale(0.75);                      '#13
          +'                   transform: scale(0.75);                              '#13
          +'              }                                                         '#13
          +'              100% {                                                    '#13
          +'                   opacity: 1;                                          '#13
          +'                   -webkit-transform: scale(1);                         '#13
          +'                   transform: scale(1);                                 '#13
          +'              }                                                         '#13
          +'         }                                                              '#13
          +'         @keyframes ball-beat {                                         '#13
          +'              50% {                                                     '#13
          +'                   opacity: 0.2;                                        '#13
          +'                   -webkit-transform: scale(0.75);                      '#13
          +'                   transform: scale(0.75);                              '#13
          +'              }                                                         '#13
          +'              100% {                                                    '#13
          +'                   opacity: 1;                                          '#13
          +'                   -webkit-transform: scale(1);                         '#13
          +'                   transform: scale(1);                                 '#13
          +'              }                                                         '#13
          +'         }                                                              '#13
          +'         .ball-beat>div {                                               '#13
          +'              background-color: #279fcf;                                '#13
          +'              width: 15px;                                              '#13
          +'              height: 15px;                                             '#13
          +'              border-radius: 100% !important;                           '#13
          +'              margin: 2px;                                              '#13
          +'              -webkit-animation-fill-mode: both;                        '#13
          +'              animation-fill-mode: both;                                '#13
          +'              display: inline-block;                                    '#13
          +'              -webkit-animation: ball-beat 0.7s 0s infinite linear;     '#13
          +'              animation: ball-beat 0.7s 0s infinite linear;             '#13
          +'         }                                                              '#13
          +'         .ball-beat>div:nth-child(2n-1) {                               '#13
          +'              -webkit-animation-delay: 0.35s !important;                '#13
          +'              animation-delay: 0.35s !important;                        '#13
          +'         }                                                              '#13
          +'         #loader-wrapper {                                              '#13
          +'              position: fixed;                                          '#13
          +'              top: 0;                                                   '#13
          +'              left: 0;                                                  '#13
          +'              width: 100%;                                              '#13
          +'              height: 100%;                                             '#13
          +'              z-index: 999999;                                          '#13
          +'              background: #fff;                                         '#13
          +'         }                                                              '#13
          +'         #loader {                                                      '#13
          +'              display: block;                                           '#13
          +'              position: relative;                                       '#13
          +'              left: 50%;                                                '#13
          +'              top: 50%;                                                 '#13
          +'              width: 150px;                                             '#13
          +'              height: 150px;                                            '#13
          +'              margin: -75px 0 0 -75px;                                  '#13
          +'              border-radius: 50%;                                       '#13
          +'              border: 3px solid transparent;                            '#13
          +'              /* COLOR 1 */                                             '#13
          +'              border-top-color: #000;                                   '#13
          +'              -webkit-animation: spin 2s linear infinite;               '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -ms-animation: spin 2s linear infinite;                   '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -moz-animation: spin 2s linear infinite;                  '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -o-animation: spin 2s linear infinite;                    '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              animation: spin 2s linear infinite;                       '#13
          +'              /* Chrome, Firefox 16+, IE 10+, Opera */                  '#13
          +'              z-index: 1001;                                            '#13
          +'         }                                                              '#13
          +'         #loader:before {                                               '#13
          +'              content: "";                                              '#13
          +'              position: absolute;                                       '#13
          +'              top: 5px;                                                 '#13
          +'              left: 5px;                                                '#13
          +'              right: 5px;                                               '#13
          +'              bottom: 5px;                                              '#13
          +'              border-radius: 50%;                                       '#13
          +'              border: 3px solid transparent;                            '#13
          +'              /* COLOR 2 */                                             '#13
          +'              border-top-color: #000;                                   '#13
          +'              -webkit-animation: spin 3s linear infinite;               '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -moz-animation: spin 3s linear infinite;                  '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -o-animation: spin 3s linear infinite;                    '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -ms-animation: spin 3s linear infinite;                   '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              animation: spin 3s linear infinite;                       '#13
          +'              /* Chrome, Firefox 16+, IE 10+, Opera */                  '#13
          +'         }                                                              '#13
          +'         #loader:after {                                                '#13
          +'              content: "";                                              '#13
          +'              position: absolute;                                       '#13
          +'              top: 15px;                                                '#13
          +'              left: 15px;                                               '#13
          +'              right: 15px;                                              '#13
          +'              bottom: 15px;                                             '#13
          +'              border-radius: 50%;                                       '#13
          +'              border: 3px solid transparent;                            '#13
          +'              border-top-color: #000;                                   '#13
          +'              /* COLOR 3 */                                             '#13
          +'              -moz-animation: spin 1.5s linear infinite;                '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -o-animation: spin 1.5s linear infinite;                  '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -ms-animation: spin 1.5s linear infinite;                 '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              -webkit-animation: spin 1.5s linear infinite;             '#13
          +'              /* Chrome, Opera 15+, Safari 5+ */                        '#13
          +'              animation: spin 1.5s linear infinite;                     '#13
          +'              /* Chrome, Firefox 16+, IE 10+, Opera */                  '#13
          +'         }                                                              '#13
          +'         @-webkit-keyframes spin {                                      '#13
          +'              0% {                                                      '#13
          +'                   -webkit-transform: rotate(0deg);                     '#13
          +'                   /* Chrome, Opera 15+, Safari 3.1+ */                 '#13
          +'                   -ms-transform: rotate(0deg);                         '#13
          +'                   /* IE 9 */                                           '#13
          +'                   transform: rotate(0deg);                             '#13
          +'                   /* Firefox 16+, IE 10+, Opera */                     '#13
          +'              }                                                         '#13
          +'                                                                        '#13
          +'              100% {                                                    '#13
          +'                   -webkit-transform: rotate(360deg);                   '#13
          +'                   /* Chrome, Opera 15+, Safari 3.1+ */                 '#13
          +'                   -ms-transform: rotate(360deg);                       '#13
          +'                   /* IE 9 */                                           '#13
          +'                   transform: rotate(360deg);                           '#13
          +'                   /* Firefox 16+, IE 10+, Opera */                     '#13
          +'              }                                                         '#13
          +'         }                                                              '#13
          +'         @keyframes spin {                                              '#13
          +'              0% {                                                      '#13
          +'                   -webkit-transform: rotate(0deg);                     '#13
          +'                   /* Chrome, Opera 15+, Safari 3.1+ */                 '#13
          +'                   -ms-transform: rotate(0deg);                         '#13
          +'                   /* IE 9 */                                           '#13
          +'                   transform: rotate(0deg);                             '#13
          +'                   /* Firefox 16+, IE 10+, Opera */                     '#13
          +'              }                                                         '#13
          +'              100% {                                                    '#13
          +'                   -webkit-transform: rotate(360deg);                   '#13
          +'                   /* Chrome, Opera 15+, Safari 3.1+ */                 '#13
          +'                   -ms-transform: rotate(360deg);                       '#13
          +'                   /* IE 9 */                                           '#13
          +'                   transform: rotate(360deg);                           '#13
          +'                   /* Firefox 16+, IE 10+, Opera */                     '#13
          +'              }                                                         '#13
          +'         }                                                              '#13
          +'         #loader-wrapper .loader-section {                              '#13
          +'              position: fixed;                                          '#13
          +'              top: 0;                                                   '#13
          +'              width: 51%;                                               '#13
          +'              height: 100%;                                             '#13
          +'              background: #fff;                                         '#13
          +'              /* opacity: 0.7; */                                       '#13
          +'              /* Old browsers */                                        '#13
          +'              z-index: 1000;                                            '#13
          +'              -webkit-transform: translateX(0);                         '#13
          +'              /* Chrome, Opera 15+, Safari 3.1+ */                      '#13
          +'              -ms-transform: translateX(0);                             '#13
          +'              /* IE 9 */                                                '#13
          +'              transform: translateX(0);                                 '#13
          +'              /* Firefox 16+, IE 10+, Opera */                          '#13
          +'         }                                                              '#13
          +'         #loader-wrapper .loader-section.section-left {                 '#13
          +'              left: 0;                                                  '#13
          +'         }                                                              '#13
          +'         #loader-wrapper .loader-section.section-right {                '#13
          +'              right: 0;                                                 '#13
          +'         }                                                              '#13
          +'         /* Loaded */                                                   '#13
          +'         .loaded #loader-wrapper .loader-section.section-left {         '#13
          +'              -webkit-transform: translateX(-100%);                     '#13
          +'              /* Chrome, Opera 15+, Safari 3.1+ */                      '#13
          +'              -ms-transform: translateX(-100%);                         '#13
          +'              /* IE 9 */                                                '#13
          +'              transform: translateX(-100%);                             '#13
          +'              /* Firefox 16+, IE 10+, Opera */                          '#13
          +'              -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000); '#13
          +'              transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);         '#13
          +'         }                                                              '#13
          +'         .loaded #loader-wrapper .loader-section.section-right {        '#13
          +'              -webkit-transform: translateX(100%);                      '#13
          +'              /* Chrome, Opera 15+, Safari 3.1+ */                      '#13
          +'              -ms-transform: translateX(100%);                          '#13
          +'              /* IE 9 */                                                '#13
          +'              transform: translateX(100%);                              '#13
          +'              /* Firefox 16+, IE 10+, Opera */                          '#13
          +'              -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000); '#13
          +'              transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);         '#13
          +'         }                                                              '#13
          +'         .loaded #loader {                                              '#13
          +'              opacity: 0;                                               '#13
          +'              -webkit-transition: all 0.3s ease-out;                    '#13
          +'              transition: all 0.3s ease-out;                            '#13
          +'         }                                                              '#13
          +'         .loaded #loader-wrapper {                                      '#13
          +'              visibility: hidden;                                       '#13
          +'              -webkit-transform: translateY(-100%);                     '#13
          +'              /* Chrome, Opera 15+, Safari 3.1+ */                      '#13
          +'              -ms-transform: translateY(-100%);                         '#13
          +'              /* IE 9 */                                                '#13
          +'              transform: translateY(-100%);                             '#13
          +'              /* Firefox 16+, IE 10+, Opera */                          '#13
          +'              -webkit-transition: all 0.3s 1s ease-out;                 '#13
          +'              transition: all 0.3s 1s ease-out;                         '#13
          +'         }                                                              '#13
          +'         /* JavaScript Turned Off */                                    '#13
          +'                                                                        '#13
          +'         .no-js #loader-wrapper {                                       '#13
          +'              display: none;                                            '#13
          +'         }                                                              '#13
          +'                                                                        '#13
          +'         .no-js h1 {                                                    '#13
          +'              color: #222222;                                           '#13
          +'         }                                                              '#13
          +'         #loader-wrapper .load_title {                                  '#13
          +'              font-family: ''Open Sans'';                               '#13
          +'              color: rgb(245, 245, 245);                                '#13
          +'              font-size: 19px;                                          '#13
          +'              width: 100%;                                              '#13
          +'              text-align: center;                                       '#13
          +'              z-index: 9999999999999;                                   '#13
          +'              position: absolute;                                       '#13
          +'              top: 36px;                                                '#13
          +'              opacity: 1;                                               '#13
          +'              line-height: 30px;                                        '#13
          +'         }                                                              '#13
          +'         #loader-wrapper .load_title span {                             '#13
          +'              font-weight: normal;                                      '#13
          +'              font-style: italic;                                       '#13
          +'              font-size: 13px;                                          '#13
          +'              color: rgb(220, 220, 220);                                '#13
          +'              opacity: 0.5;                                             '#13
          +'         }                                                              '#13
          +'         @keyframes moveover {                                          '#13
          +'              0% {                                                      '#13
          +'                   transform: rotate(0deg);                             '#13
          +'              }                                                         '#13
          +'                                                                        '#13
          +'              100% {                                                    '#13
          +'                   transform: rotate(360deg);                           '#13
          +'              }                                                         '#13
          +'         }                                                              '#13
          +'         .box {                                                         '#13
          +'              position: relative;                                       '#13
          +'              width: 100px;                                             '#13
          +'              height: 100px;                                            '#13
          +'              margin: 18% auto;                                         '#13
          +'              /*������ת*/                                              '#13
          +'              animation: moveover 3s linear infinite;                   '#13
          +'         }                                                              '#13
          +'         .box_text {                                                    '#13
          +'              position: absolute;                                       '#13
          +'              top: 0;                                                   '#13
          +'              left: 0;                                                  '#13
          +'         }                                                              '#13
          +'         .box::before {                                                 '#13
          +'              content: "";                                              '#13
          +'              position: absolute;                                       '#13
          +'              width: 50px;                                              '#13
          +'              height: 100px;                                            '#13
          +'              border-radius: 50px 0 0 50px;                             '#13
          +'              background: linear-gradient(#999, rgb(220, 220, 220));    '#13
          +'              background-color: #999;                                   '#13
          +'              z-index: 2;                                               '#13
          +'         }                                                              '#13
          +'         .box2 {                                                        '#13
          +'              position: absolute;                                       '#13
          +'              width: 50px;                                              '#13
          +'              height: 100px;                                            '#13
          +'              border-radius: 0 50px 50px 0;                             '#13
          +'              left: 50%;                                                '#13
          +'              background: linear-gradient(rgb(255,255,255),rgb(220,220, 220));      '#13
          +'              z-index: 1;                                               '#13
          +'         }                                                              '#13
          +'         .box::after {                                                  '#13
          +'              content: "";                                              '#13
          +'              position: absolute;                                       '#13
          +'              width: 92px;                                              '#13
          +'              height: 92px;                                             '#13
          +'              top: 4px;                                                 '#13
          +'              left: 4px;                                                '#13
          +'              border-radius: 50%;                                       '#13
          +'              background-color: #fff;                                   '#13
          +'              z-index: 2;                                               '#13
          +'         }                                                              '#13
          +'         .wrapper {                                                     '#13
          +'              position: relative;                                       '#13
          +'         }                                                              '#13
          +'    </style>                                                            '#13
          +'    <div id="loader-wrapper">                                           '#13
          +'         <div class="wrapper">                                          '#13
          +'              <div class=''box''>                                       '#13
          +'                   <div class="box2"></div>                             '#13
          +'              </div>                                                    '#13
          +'              <div class="load_title">DeWeb                             '#13
          +'              </div>                                                    '#13
          +'                                                                        '#13
          +'         </div>                                                         '#13
          +'    </div>                                                              '#13
          +'    <script src="dist/vue.js" type="text/javascript"></script>          '#13
          +'    <script src="dist/index.js" type="text/javascript"></script>        '#13
          +'    <script src="dist/axios.min.js" type="text/javascript"></script>    '#13
                                                                                    
          +'    <script src="dist/charts/echarts.min.js"></script>                  '#13
          +'    <script src="dist/charts/lib/index.min.js"></script>                '#13
          +'    <link rel="stylesheet" href="dist/charts/lib/style.min.css">        '#13

          +'    <link rel="icon" href="dist/webimages/[###].ico" type="image/x-icon">       '#13
          +'    <link rel="stylesheet" type="text/css" href="dist/theme-chalk/index.css" /> '#13;

function dwGetText(AText:string;ALen:integer):string;

function dwGetMD5(AStr:String):string;

implementation      //==============================================================================


function dwGetMD5(AStr:String):string;
var
     oMD5      : TIdHashMessageDigest5;
begin
     oMD5      := TIdHashMessageDigest5.Create;
     {$IFDEF VER150}
     Result    := LowerCase(oMD5.AsHex(oMD5.HashValue(AStr)));
     {$ELSE}
     Result    := LowerCase(oMD5.HashStringAsHex(AStr));
     {$ENDIF}
     oMD5.Free;
end;


function dwGetText(AText:string;ALen:integer):string;
begin
     if Length(AText)<ALen then begin
          Result    := AText;
     end else begin
          //���ж�Ҫ��ȡ���ַ������һ���ֽڵ�����
          //���Ϊ���ֵĵ�һ���ֽ����(��)һλ
          if ByteType(AText,ALen) = mbLeadByte then
               ALen := ALen - 1;
          result := copy(AText,1,ALen) + '...';
     end;
end;

function dwLongStr(AText:String):String;
var
     slTmp     : TStringList;
     iItem     : Integer;
begin
     if AText = '' then begin
          Result    := AText;
     end else begin
          slTmp     := TStringList.Create;
          //AText     := StringReplace(AText,'<br/>','"'#13'+"',[rfReplaceAll]);
          //AText     := StringReplace(AText,'<br>', '"'#13'+"',[rfReplaceAll]);
          slTmp.Text     := AText;
          //
          Result    := '';
          for iItem := 0 to slTmp.Count-2 do begin
               Result    := Result + slTmp[iItem]+#13#10;
          end;
          Result    := Result + slTmp[slTmp.Count-1];
          slTmp.Destroy;
     end;
end;

function dwPHPToDate(ADate:Integer):TDateTime;
var
     f1970     : TDateTime;
begin
     //PHPʱ���Ǹ�������ʱ��1970-1-1 00:00:00����ǰ���ŵ�����
     f1970     := StrToDateTime('1970-01-01 00:00:00');
     Result    := IncSecond(f1970,ADate);
     //Result    := ((ADate+28800)/86400+25569);
end;


//�����뺯��                                                                    
function dwDecode(AText:string):string;
begin
     Result    := StringReplace(AText,'%7B','{',[rfReplaceAll]);
     Result    := StringReplace(Result,'%7D','}',[rfReplaceAll]);
     Result    := StringReplace(Result,'%22','"',[rfReplaceAll]);
end;


//����LTWH
function dwSetCompLTWH(AComponent:TComponent;ALeft,ATop,AWidth,AHeight:Integer):Integer;
begin
     AComponent.DesignInfo    := ALeft  * 10000 + ATop;
     AComponent.Tag           := AWidth * 10000 + AHeight;
     //
     Result    := 0;
end;

//����PlaceHolder
function dwSetPlaceHodler(AControl:TControl;APH:String):Integer;
var
     sHint     : String;
     joHint    : Variant;
begin
     sHint     := AControl.Hint;
     //joHint    := Variant.Create;
     TDocVariant.New(joHint);
     if (sHint<>'') then begin
          if (Copy(sHint,1,1) = '{') and (Copy(sHint,Length(sHint),1) = '}') then begin
               joHint    := _json(sHint);
          end;
     end;
     joHint.planeholder  := APH;
     AControl.Hint  := VariantSaveJSON(joHint);
     //
     Result    := 0;
end;

//����Height
function dwSetHeight(AControl:TControl;AHeight:Integer):Integer;
var
     sHint     : String;
     joHint    : Variant;
begin
     sHint     := AControl.Hint;
     TDocVariant.New(joHint);
     if (sHint<>'') then begin
          if (Copy(sHint,1,1) = '{') and (Copy(sHint,Length(sHint),1) = '}') then begin
               joHint    := _json(sHint);
          end;
     end;
     joHint.height  := AHeight;
     AControl.Hint  := VariantSaveJSON(joHint);
     //
     Result    := 0;
end;




function dwMemoValueToText(AText:string):string;
begin
     Result    := StringReplace(AText,'\r\n',#13,[rfReplaceAll]);
     Result    := dwUnescape(Result);
end;



function dwMemoTextToValue(AText:string):string;
var
     slTxt     : TStringList;
     iItem     : Integer;
begin
     slTxt     := TStringList.Create;
     slTxt.Text     := AText;
     Result    := '';
     for iItem := 0 to slTxt.Count-1 do begin
          if iItem <slTxt.Count-1 then begin
               Result     := Result + slTxt[iItem]+'\n';
          end else begin
               Result     := Result + slTxt[iItem];
          end;
     end;
     slTxt.Destroy;
end;


procedure showMsg(AMsg:string);
begin
     {$IFDEF DEBUG}
          //ShowMessage(AMsg);
     {$ENDIF}

end;

procedure dwRealignPanel(APanel:TPanel;AHorz:Boolean);
var
     iCtrl     : Integer;
     oCtrl     : TControl;
     oCtrl0    : TControl;
begin
     //
     if APanel.ControlCount<=1 then begin
          Exit;
     end;

     //ȡ�õ�һ���ؼ�, �Լ�⵱ǰ״̬
     oCtrl0    := APanel.Controls[0];

     if AHorz then begin
          //ˮƽ���е����
          if (oCtrl0.Align = alLeft) and (oCtrl0.Width = (APanel.Width-2*APanel.BorderWidth) div APanel.ControlCount) then begin
               //�Ѿ�ˮƽ����,
          end else begin
               APanel.Height  := APanel.BorderWidth*2+oCtrl0.Height;
               //
               for iCtrl := 0 to APanel.ControlCount-2 do begin
                    oCtrl     := APanel.Controls[iCtrl];
                    //
                    oCtrl.Align    := alLeft;
                    oCtrl.Width    := (APanel.Width-2*APanel.BorderWidth) div APanel.ControlCount;
                    oCtrl.Left     := 9000+iCtrl;
               end;
               //���һ��alClient
               oCtrl     := APanel.Controls[APanel.ControlCount-1];
               oCtrl.Align    := alClient;
          end;
     end else begin
          //��ֱ���е����
          if (oCtrl0.Align = alTop) and (oCtrl0.Height = (APanel.Height-2*APanel.BorderWidth) div APanel.ControlCount) then begin
               //�Ѿ���ֱ����,
          end else begin
               APanel.Height  := APanel.BorderWidth*2+oCtrl0.Height*APanel.ControlCount;
               //
               for iCtrl := 0 to APanel.ControlCount-2 do begin
                    oCtrl     := APanel.Controls[iCtrl];
                    //
                    oCtrl.Align    := alTop;
                    oCtrl.Height   := (APanel.Height-2*APanel.BorderWidth) div APanel.ControlCount;
                    oCtrl.Top      := 9000+iCtrl;
               end;
               //���һ��alClient
               oCtrl     := APanel.Controls[APanel.ControlCount-1];
               oCtrl.Align    := alClient;
          end;
     end;

end;

procedure dwRealignChildren(ACtrl:TWinControl;AHorz:Boolean;ASize:Integer);
var
     iCount    : Integer;
     iItem     : Integer;
     iW        : Integer;
     iItemW    : Integer;
     //
     oCtrl     : TControl;
     //
     procedure _AutoSize(ooCtrl:TControl);
     begin
          if Assigned(GetPropInfo(ooCtrl.ClassInfo,'AutoSize')) then begin
               TPanel(ooCtrl).AutoSize  := False;
               TPanel(ooCtrl).AutoSize  := True;
          end;
     end;
begin
     //����ACtrl���ӿؼ�
     //���ˮƽ(AHorz=True), ��ȡ���пؼ��ȿ�ˮƽ����
     //�����ֱ, �����пؼ�Align=alTop


     //�õ��ӿؼ�����
     iCount    := ACtrl.ControlCount;
     if iCount = 0 then begin
          Exit;
     end;


     if AHorz then begin
          //ˮƽ����

          //��ȡ���ܿ���
          if Assigned(GetPropInfo(ACtrl.ClassInfo,'BorderWidth')) then begin
               iW   := ACtrl.Width - TPanel(ACtrl).BorderWidth;
          end else begin
               iW   := ACtrl.Width;
          end;
          iItemW    := Round(iW / iCount);

          //��������
          for iItem := 0 to ACtrl.ControlCount-1 do begin
               oCtrl     := ACtrl.Controls[iItem];
               //�Զ���С
               //_AutoSize(oCtrl);
               //
               if iItem<ACtrl.ControlCount-1 then begin
                    oCtrl.Align    := alLeft;
                    oCtrl.Width    := iItemW;
                    oCtrl.Top      := 0;
                    oCtrl.Left     := 99999;
               end else begin
                    oCtrl.Align    := alClient;
               end;

               //�Զ���С
               _AutoSize(oCtrl);
          end;

          //�Զ���С
          _AutoSize(ACtrl);
     end else begin
          //��ֱ����

          //��������
          for iItem := 0 to ACtrl.ControlCount-1 do begin
               oCtrl     := ACtrl.Controls[iItem];
               //�Զ���С
               _AutoSize(oCtrl);
               //
               oCtrl.Align    := alTop;
               oCtrl.Top      := 99999;
               if ASize>0 then begin
                    oCtrl.Height   := ASize;
               end else begin
                    //�Զ���С
                    _AutoSize(oCtrl);
               end;
          end;

          //�Զ���С
          _AutoSize(ACtrl);
     end;

end;


//��ȡ������Բ����Ϣ
function dwRadius(AJson:Variant):string;
var
     sRadius   : string;
begin
     sRadius   := dwGetJsonAttr(AJson,'radius');
     //
     Result    := '';
     if sRadius<>'' then begin
          Result    := 'border-radius:'+sRadius+';'
     end;
end;

function dwGetJsonAttr(AJson:Variant;AAttr:String):String;
var
     sHint     : String;
     joHint    : Variant;
begin
     Result    := '';
     //
     sHint     := AJson.hint;

     //����HINT����, ��������һЩ��������
     TDocVariant.New(joHint);
     if ( sHint <> '' ) and ( Pos('{',sHint) >= 0 ) and ( Pos('}',sHint) > 0 ) then begin
          try
               joHint    := _Json(sHint);
          except
               TDocVariant.New(joHint);
          end;
     end;

     //
     if not dwIsNull(joHint) then begin
          Result    := joHint._(AAttr);
     end;
end;


function dwGetProp(ACtrl:TControl;AAttr:String):String;
var
     sHint     : String;
     joHint    : Variant;
begin
     //
     sHint     := ACtrl.Hint;

     //����HINT����, ��������һЩ��������
     TDocVariant.New(joHint);
     if ( sHint <> '' ) and ( Pos('{',sHint) >= 0 ) and ( Pos('}',sHint) > 0 ) then begin
          try
               joHint    := _JSON(UTF8ToWideString(sHint));
          except
               TDocVariant.New(joHint);
          end;
     end;

     //
     Result    := '';
     if joHint.Exists(AAttr) then begin
          Result    := joHint._(AAttr);
     end;
end;

function dwSetProp(ACtrl:TControl;AAttr,AValue:String):Integer;
var
     sHint     : String;
     joHint    : Variant;
begin
     Result    := 0;
     //
     sHint     := ACtrl.Hint;

     //����HINT����, ��������һЩ��������
     TDocVariant.New(joHint);
     if ( sHint <> '' ) and ( Pos('{',sHint) >= 0 ) and ( Pos('}',sHint) > 0 ) then begin
          try
               joHint    := _Json(sHint);
          except
               TDocVariant.New(joHint);
          end;
     end;

     //�����ǰ���ڸ�����, ����ɾ��
     if joHint.Exists(AAttr) then begin
          joHint.Delete(AAttr);
     end;

     //��������
     joHint.Add(AAttr,AValue);

     //���ص�HINT�ַ���
     ACtrl.Hint     := VariantSaveJSON(joHint);


end;


function dwEscape(const StrToEscape:string):String;
var
   i:Integer;

   w:Word;
begin
     Result:='';

     for i:=1 to Length(StrToEscape) do
     begin
          w:=Word(StrToEscape[i]);

          if w in [Ord('0')..Ord('9'),Ord('A')..Ord('Z'),Ord('a')..Ord('z')] then
             Result:=Result+Char(w)
          else if w<=255 then
               Result:=Result+'%'+IntToHex(w,2)
          else
               Result:=Result+'%u'+IntToHex(w,4);
     end;
end;

function dwUnescape(S: string): string;
var
     i0,i1     : Integer;
begin
     Result := '';
     while Length(S) > 0 do
     begin
          if S[1]<>'%' then
          begin
               Result    := Result + S[1];
               Delete(S,1,1);
          end
          else
          begin
               Delete(S,1,1);
               if S[1]='u' then
               begin
                    try
                         //Result    := Result + Chr(StrToInt('$'+Copy(S, 2, 2)))+ Chr(StrToInt('$'+Copy(S, 4, 2)));
                         i0   := StrToInt('$'+Copy(S, 2, 2));
                         i1   := StrToInt('$'+Copy(S, 4, 2));
                         Result    := Result + WideChar((i0 shl 8) or i1);
                    except
                         ShowMessage(Result);

                    end;
                    Delete(S,1,5);
               end
               else
               begin
                    try
                         Result    := Result + Chr(StrToInt('$'+Copy(S, 1, 2)));
                    except
                         ShowMessage(Result);

                    end;
                    Delete(S,1,2);
               end;
          end;
     end;
end;




function dwConvertStr(AStr:String):String;
begin
     //�滻�ո�
     Result    := StringReplace(AStr,' ','&ensp;',[rfReplaceAll]);
end;

function dwProcessCaption(AStr:String):String;
begin
     //�滻�ո�
     Result    := AStr;
     //Result    := StringReplace(Result,' ','&nbsp;',[rfReplaceAll]);
     Result    := StringReplace(Result,'"','\"',[rfReplaceAll]);
     Result    := StringReplace(Result,'''','\''',[rfReplaceAll]);
     Result    := StringReplace(Result,#13#10,'\n',[rfReplaceAll]);
     Result    := Trim(Result);
     //�쳣����(��������)
     if Length(Result)>800 then begin
          Result    := dwGetText(Result,800);
     end;

end;


function dwBoolToStr(AVal:Boolean):string;
begin
     if AVal then begin
          Result    := 'true';
     end else begin
          Result    := 'false';
     end;
end;

function dwIsNull(AVar:Variant):Boolean;
begin
     Result    := (lowerCase(VarToStr(AVar)) = 'null') or (VarToStr(AVar) = '');
end;


function HTTPEncodeEx(const AStr: String): String;
const
     NoConversion = ['A'..'Z','a'..'z','*','@','.','_','-','0'..'9','$','!','''','(',')'];
var
     Sp, Rp: PChar;
begin
     SetLength(Result, Length(AStr) * 3);
     Sp := PChar(AStr);
     Rp := PChar(Result);
     while Sp^ <> #0 do begin
          if Sp^ in NoConversion then begin
               Rp^ := Sp^
          end else begin
               FormatBuf(Rp^, 3, '%%%.2x', 6, [Ord(Sp^)]);
               Inc(Rp,2);
          end;
          Inc(Rp);
          Inc(Sp);
     end;
     SetLength(Result, Rp - PChar(Result));
end;

function dwEncodeURIComponent(S:AnsiString):AnsiString;
begin
     Result    := HTTPEncodeEx(AnsiToUtf8(S));
end;


function dwColor(AColor:Integer):string;
begin
     Result := Format('#%.2x%.2x%.2x',[GetRValue(ColorToRGB(AColor)),GetGValue(ColorToRGB(AColor)),GetBValue(ColorToRGB(AColor))]);
end;



//���ܺ���
function dwDecryptKey (Src:String; Key:String):string;
var
     KeyLen :Integer;
     KeyPos :Integer;
     offset :Integer;
     dest :string;
     SrcPos :Integer;
     SrcAsc :Integer;
     TmpSrcAsc :Integer;
begin
     try
          KeyLen:=Length(Key);
          if KeyLen = 0 then key:='Think Space';
          KeyPos:=0;
          offset:=StrToInt('$'+ copy(src,1,2));
          SrcPos:=3;
          repeat
               SrcAsc:=StrToInt('$'+ copy(src,SrcPos,2));
               if KeyPos < KeyLen Then KeyPos := KeyPos + 1 else KeyPos := 1;
               TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
               if TmpSrcAsc <= offset then
                    TmpSrcAsc := 255 + TmpSrcAsc - offset
               else
                    TmpSrcAsc := TmpSrcAsc - offset;
               dest := dest + chr(TmpSrcAsc);
               offset:=srcAsc;
               SrcPos:=SrcPos + 2;
          until SrcPos >= Length(Src);
               Result:=Dest;
     except
          Result    := 'ias@njw#oriu$we_em1!83~4r`mskjhr?';
     end;
end;


function dwIIF(ABool:Boolean;AYes,ANo:string):string;
begin
     if ABool then begin
          Result    := AYes;
     end else begin
          Result    := ANo;
     end;
end;

function dwVisible(ACtrl:TControl):String;
begin
     Result    := ' v-if="'+ACtrl.Name+'__vis"';
end;

function dwDisable(ACtrl:TControl):String;
begin
     Result    := ' :disabled="'+ACtrl.Name+'__dis"';
end;

function dwGetHintJson(ACtrl:TControl):Variant;
var
     sHint     : String;
begin
     sHint     := ACtrl.Hint;
     TDocVariant.New(Result);
     if ( sHint <> '' ) and ( sHint[1] = '{' ) and ( sHint[Length(sHint)] = '}' ) then begin
          try
               Result    := _Json(sHint);
          except
               TDocVariant.New(Result);
          end;
     end;
end;

function dwLTWH(ACtrl:TControl):String;  //���Ը���λ�õ��÷�
var
     //joHint    : Variant;
     sZI       : String;
begin
     //
     //joHint    := dwGetHintJson(ACtrl);

     //
     //if joHint.Exists('z-index')  then begin
     //     sZI  := 'z-index:'+IntToStr(Min(joHint._('z-index'),998))+';';
     //end;

     //
     with ACtrl do begin
          Result    := ' :style="{left:'+Name+'__lef,top:'+Name+'__top,width:'+Name+'__wid,'
                    +'height:'+Name+'__hei}" style="position:absolute;';
     end;
end;

function dwLTWHComp(ACtrl:TComponent):String;  //���Ը���λ�õ��÷�
begin

     //
     with ACtrl do begin
          Result    := ' :style="{left:'+Name+'__lef,top:'+Name+'__top,width:'+Name+'__wid,height:'+Name+'__hei}"'
                    +' style="position:absolute;';
     end;
end;

function dwGetHintValue(AHint:Variant;AJsonName,AHtmlName,ADefault:String):String;
begin
     if AHint.Exists(AJsonName) then begin
          Result    := AnsiString(' '+AHtmlName+'="'+AHint._(AJsonName)+'"');
     end else begin
          Result    := ADefault;
     end;
end;



end.