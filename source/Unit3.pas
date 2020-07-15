unit Unit3;

interface

uses
     dwCore,
     Forms,SysUtils,
     Math, StdCtrls, Graphics, Controls, ExtCtrls, Classes;

type
  TForm_OnlineTestSystem = class(TForm)
    Panel_Content: TPanel;
    Panel_00_Logo: TPanel;
    Img: TImage;
    Label_Title: TLabel;
    Panel_ZZ_Buttons: TPanel;
    Button_Login: TButton;
    Panel1: TPanel;
    Panel_Space1: TPanel;
    Panel_03: TPanel;
    Label_ItemTitle: TLabel;
    Panel_ABCD: TPanel;
    Panel_CD: TPanel;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    Panel_AB: TPanel;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    Panel_02: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Panel5: TPanel;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    Panel_01: TPanel;
    Label2: TLabel;
    Panel8: TPanel;
    Panel9: TPanel;
    RadioButton15: TRadioButton;
    RadioButton16: TRadioButton;
    Panel10: TPanel;
    RadioButton17: TRadioButton;
    RadioButton18: TRadioButton;
    Panel2: TPanel;
    procedure Panel_ABCDResize(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioButton17Click(Sender: TObject);
    procedure Button_LoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_OnlineTestSystem: TForm_OnlineTestSystem;

implementation

{$R *.dfm}

procedure TForm_OnlineTestSystem.Button_LoginClick(Sender: TObject);
var
     iScore    : Integer;
begin
     iScore    := 0;
     if RadioButton7.Checked then begin
          iScore    := iScore + 33;
     end;
     if RadioButton9.Checked then begin
          iScore    := iScore + 33;
     end;
     if RadioButton15.Checked then begin
          iScore    := iScore + 33;
     end;
     //
     if iScore=0 then begin
          dwShowMessage('成绩很差,不要偷懒哟!','成绩','OK',Self);
     end else if iScore = 33 then begin
          dwShowMessage('成绩较差,加油!','成绩','OK',Self);
     end else if iScore = 66 then begin
          dwShowMessage('成绩还可以!,继续努力!','成绩','OK',Self);
     end else if iScore = 99 then begin
          dwShowMessage('成绩很好! 你真棒!','成绩','OK',Self);
     end;


end;

procedure TForm_OnlineTestSystem.FormMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     //
     if (X>700) and (Y>700) then begin
          //PC等高分辨率


          Width     := X;
          Height    := Y;

     end else begin
          if (Button = mbLeft) and (Y>X) then begin//屏幕纵向
               ////移动设备 纵向
               Width     := Min(X,Y);
               Height    := Max(X,Y);
          end else begin
               ////移动设备 横向

               Width     := Max(X,Y);
               Height    := Min(X,Y);

          end;
     end;
end;

procedure TForm_OnlineTestSystem.Panel_ABCDResize(Sender: TObject);
var
     oPanel    : TPanel;
     oPanelAB  : TPanel;
     oPanelCD  : TPanel;
begin
     oPanel    := TPanel(Sender);
     oPanelAB  := TPanel(oPanel.Controls[1]);
     oPanelCD  := TPanel(oPanel.Controls[0]);
     //
     if oPanel.Width>600 then begin
          //
          oPanel.OnResize     := nil;
          oPanel.Height       := 40;
          oPanel.OnResize     := Panel_ABCDResize;
          //水平排列
          oPanelAB.Align      := alLeft;
          oPanelAB.Width      := 300;
          oPanelCD.Align      := alClient;

     end else begin
          //垂直排列
          oPanelAB.Align      := alTop;
          oPanelAB.Height     := 40;
          oPanelCD.Align      := alTop;
          oPanelCD.Height     := 40;
          //
          oPanel.OnResize     := nil;
          oPanel.Height       := 40*2+oPanel.BorderWidth*2;
          oPanel.OnResize     := Panel_ABCDResize;
     end;
     //
     TPanel(oPanel.Parent).AutoSize     := False;
     TPanel(oPanel.Parent).AutoSize     := True;
     //
     TPanel(oPanel.Parent.Parent).AutoSize     := False;
     TPanel(oPanel.Parent.Parent).AutoSize     := True;
     //
     Panel_Content.Parent.Height   := Panel_ZZ_Buttons.Top + Panel_ZZ_Buttons.Height+30;
     //
     dwSetHeight(TForm(Panel_Content.Parent),Panel_Content.Parent.Height);
end;


procedure TForm_OnlineTestSystem.RadioButton17Click(Sender: TObject);
var
     oPanel    : TPanel;
     oPanelAB  : TPanel;
     oPanelCD  : TPanel;
begin
     oPanel    := TPanel(TRadioButton(Sender).Parent.Parent);
     oPanelAB  := TPanel(oPanel.Controls[1]);
     oPanelCD  := TPanel(oPanel.Controls[0]);

     //先禁止事件
     TRadioButton(oPanelAB.Controls[0]).OnClick   := nil;
     TRadioButton(oPanelAB.Controls[1]).OnClick   := nil;
     TRadioButton(oPanelCD.Controls[0]).OnClick   := nil;
     TRadioButton(oPanelCD.Controls[1]).OnClick   := nil;

     //
     TRadioButton(oPanelAB.Controls[0]).Checked   := False;
     TRadioButton(oPanelAB.Controls[1]).Checked   := False;
     TRadioButton(oPanelCD.Controls[0]).Checked   := False;
     TRadioButton(oPanelCD.Controls[1]).Checked   := False;

     //
     TRadioButton(Sender).Checked  := True;

     //恢复事件
     TRadioButton(oPanelAB.Controls[0]).OnClick   := RadioButton17Click;
     TRadioButton(oPanelAB.Controls[1]).OnClick   := RadioButton17Click;
     TRadioButton(oPanelCD.Controls[0]).OnClick   := RadioButton17Click;
     TRadioButton(oPanelCD.Controls[1]).OnClick   := RadioButton17Click;
end;

end.

