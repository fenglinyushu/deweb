unit dwButtons;

interface

uses
     SynCommons,
     
     //
     Messages, SysUtils, Variants, Classes, Graphics,
     Controls, Forms, Dialogs, ComCtrls, ExtCtrls,
     Spin, Grids,
     Math,typinfo,
     DateUtils, StdCtrls, Menus,
     Windows,Types;

function dwGenerate(ACtrl:TControl):Variant;


implementation

function dwGenerate(ACtrl:TControl):Variant;
var
     oButton   : TButton;
     //
     sSize     : string;
     sCode     : string;
     sHint     : string;

     //
     jaHtml    : Variant;
     jaData    : Variant;
     jaMethod  : Variant;
     joHint    : Variant;

     function sNA :string;     //����
     begin
          Result    := ACtrl.name;
     end;
     function sZI : string;
     begin
          Result    := '';
     end;
     function sVI : string;     //��������
     begin
          Result    := ' v-if="'+sNA+'__visible"';
     end;
     function sLTWH:String;  //���Ը���λ�õ��÷�
     begin
          Result    := ' :style="{left:'+sNA+'__l,top:'+sNA+'__t,width:'+sNA+'__w,height:'+sNA+'__h}" style="position:absolute;'+sZI;
     end;
     function sEN:string;
     begin
          Result    := ' :disabled="'+sNA+'__disabled"';
     end;
     function sID:string;
     begin
          Result    := ' id="'+sNA+'"';
     end;
     function sVM:string;
     begin
          Result    := ' v-model="'+sNA+'"';
     end;
     function sL:string;
     begin
          Result    := sNA+'__l:"'+IntToStr(ACtrl.left)+'px",'
     end;
     function sT:string;
     begin
          Result    := sNA+'__t:"'+IntToStr(ACtrl.top)+'px",'
     end;
     function sW:string;
     begin
          Result    := sNA+'__w:"'+IntToStr(ACtrl.width)+'px",'
     end;
     function sH:string;
     begin
          Result    := sNA+'__h:"'+IntToStr(ACtrl.height)+'px",'
     end;
     function sC:string;
     begin
          //Result    := sNA+'__c:"'+Format('#%.2x%.2x%.2x',[GetRValue(oPanel.Color),GetGValue(oPanel.Color),GetBValue(oPanel.Color)])+'",';
     end;
     //----------------���е�����-------------------------------------------------------------------
     function sButtonType : String;
     begin
          Result    := ' type="default"';

          if joHint.Exists('type')  then begin
               Result    := ' type="'+joHint.type+'"';
          end;
     end;
     function sButtonIcon : String;
     begin
          Result    := '';

          if joHint.Exists('icon')  then begin
               Result    := ' icon="'+joHint.icon+'"';
          end;
     end;
begin
     try
          //ȡ�ÿؼ��Ա���
          oButton   := TButton(ACtrl);

          //����joHINT����, ��������һЩ��������
          sHint     := ACtrl.Hint;
          TDocVariant.New(joHint);
          if ( sHint <> '' ) and ( sHint[1] = '{' ) and ( sHint[Length(sHint)] = '}' ) then begin
               try
                    joHint    := _Json(sHint);
               except
                    TDocVariant.New(joHint);
               end;
          end;


          //����JSON
          Result    := _json('{"html":[],"data":[],"method":[]}');
          jaHtml    := Result.html;
          jaData    := Result.data;
          jaMethod  := Result.method;

          //--------------HTML----------------------------------------------------------------------
          //size="medium","small","mini"
          if oButton.Height>=35 then begin
               sSize     := ' size="medium"';
          end else if oButton.height>25 then begin
               sSize     := ' size="small"';
          end else begin
               sSize     := ' size="mini"';
          end;

          //�����ַ���
          sCode     := '<el-button'
                    +sVI
                    +sSize
                    +sEN
                    +sLTWH
                    +sButtonType
                    +sButtonIcon
                    +'" @click="'+sNA+'__onclick">{{'+sNA+'_ca}}</el-button>';
          //
          jaMethod.Add(sCode);

          //--------------DATA----------------------------------------------------------------------
          jaData.Add(sNA+'_ca:'''+oButton.caption+''',');
          jaData.Add(sVI);    //����
          jaData.Add(sEN);    //����
          jaData.Add(sL);      //
          jaData.Add(sT);      //
          jaData.Add(sW);      //
          jaData.Add(sH);      //


          //--------------METHOD--------------------------------------------------------------------
          //����Motheds
          sCode     := sNA+'__onclick() { '#13
               +'axios.get(''{"mode":"event","cid":[!clientid!],"component":"'+sNA+'","event":"onclick"}'') '#13
               +'.then(resp =>{this.procResp(resp.data)});'#13
               +'},';
          jaMethod.Add(sCode);

     except
          Result    := _json('{"html":[],"data":[],"method":[]}');
     end;
end;


end.
