unit Unit2;

interface

uses
     //
     dwBase,

     //
     Forms, SysUtils,
     Math, StdCtrls, Graphics, ExtCtrls, Controls, Classes;

type
  Tdwsdk = class(TForm)
    Panel_Content: TPanel;
    Panel_Banner: TPanel;
    Image1: TImage;
    Label_deweb: TLabel;
    Panel2: TPanel;
    Panel_Space1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label16: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Panel_Buttons: TPanel;
    Button_SDK: TButton;
    Button_Next: TButton;
    Button_Hello: TButton;
    Button_Demos: TButton;
    procedure Button_SDKClick(Sender: TObject);
    procedure Button_NextClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button_HelloClick(Sender: TObject);
    procedure Button_DemosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    dwsdk: Tdwsdk;

implementation

{$R *.dfm}

procedure Tdwsdk.Button_SDKClick(Sender: TObject);
begin
     dwCreateForm('TForm4',Self.Handle);
end;

procedure Tdwsdk.Button_DemosClick(Sender: TObject);
begin
     dwCreateForm('TDemos',Self.Handle);

end;

procedure Tdwsdk.Button_HelloClick(Sender: TObject);
begin
     dwCreateForm('TTest',Self.Handle);

end;

procedure Tdwsdk.Button_NextClick(Sender: TObject);
begin
     dwCreateForm('TDriver',Self.Handle);

end;

procedure Tdwsdk.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
     I         : Integer;
     oLabel    : TLabel;
begin
     //
     if (X>700) and (Y>700) then begin
          //PC等高分辨率

          //
          Panel_Content.Top        := 30;
          Panel_Content.Height     := Height-60;


          Width     := X;
          Height    := Y;

          for I := 1 to 11 do begin
               oLabel    := TLabel(Self.FindComponent('Label'+IntToStr(I)));
               if oLabel <> nil  then begin
                    oLabel.AutoSize       := False;
                    oLabel.AutoSize       := True;
                    oLabel.Height         := oLabel.Height +10;
               end;

          end;


     end else begin
          if (Button = mbLeft) and (Y>X) then begin//屏幕纵向
               ////移动设备 纵向


               Width     := X;
               Height    := Y;

               //
               Panel_Content.Top        := 30;
               Panel_Content.Height     := Height-60;

               for I := 1 to 11 do begin
                    oLabel    := TLabel(Self.FindComponent('Label'+IntToStr(I)));
                    if oLabel <> nil  then begin
                         oLabel.AutoSize       := False;
                         oLabel.AutoSize       := True;
                         oLabel.Height         := oLabel.Height +10;
                    end;

               end;
          end else begin
               ////移动设备 横向

               Width     := Max(X,Y);
               Height    := Min(X,Y);


               //
               Panel_Content.Top        := 0;
               Panel_Content.Height     := Height;

               for I := 1 to 11 do begin
                    oLabel    := TLabel(Self.FindComponent('Label'+IntToStr(I)));
                    if oLabel <> nil  then begin
                         oLabel.AutoSize       := False;
                         oLabel.AutoSize       := True;
                         oLabel.Height         := oLabel.Height;
                    end;

               end;

               //
               Height    := Max(Height, Panel_Buttons.Top + Panel_Buttons.Height);
               Panel_Content.Height     := Height;

          end;

     end;

end;

end.
