unit UnitGepromAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Timer4: TTimer;
    Timer5: TTimer;
    Timer6: TTimer;
    Timer3: TTimer;
    procedure OKButtonClick(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Timer6Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;
  IndexTop1,IndexTop2:integer;
  IndexLeft1,IndexLeft2:integer;

implementation

{$R *.DFM}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
Self.Close;
end;

procedure TAboutBox.Timer4Timer(Sender: TObject);
begin
If IndexTop1>88 then Dec(IndexTop1)
else
 begin
 Timer4.Enabled:=False;
 Timer5.Enabled:=True;
 end;
Copyright.Top:=IndexTop1;
end;

procedure TAboutBox.Timer5Timer(Sender: TObject);
begin
If Comments.Top>120 then Dec(IndexTop2)
else
 begin
 Timer5.Enabled:=False;
 Timer3.Enabled:=True;
 end;
Comments.Top:=IndexTop2;
end;

procedure TAboutBox.Timer6Timer(Sender: TObject);
begin

If (IndexLeft1<178) or (IndexLeft2>280) then
 begin
 Dec(IndexLeft1);
 AboutBox.Copyright.Left:=IndexLeft1;
 Inc(IndexLeft2);
 AboutBox.Comments.Left:=IndexLeft2;
 end
else
 begin
 Aboutbox.Comments.Top:=146;
 Aboutbox.Copyright.Top:=146;
 AboutBox.Copyright.Left:=48;
 AboutBox.Comments.Left:=120;
 IndexTop1:=Aboutbox.Copyright.Top;
 IndexTop2:=Aboutbox.Comments.Top;
 IndexLeft1:=Aboutbox.Copyright.Left;
 IndexLeft2:=Aboutbox.Comments.Left;
 Timer3.Enabled:=False;
 Timer4.Enabled:=True;
 end;

end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Timer4.Enabled:=False;
Timer5.Enabled:=False;
Timer6.Enabled:=False;
end;

procedure TAboutBox.FormActivate(Sender: TObject);
begin
IndexTop1:=146;
IndexTop2:=146;
IndexLeft1:=48;
IndexLeft2:=120;
AboutBox.Timer3.Enabled:=False;
AboutBox.Timer4.Enabled:=True;
AboutBox.Timer5.Enabled:=False;
AboutBox.Timer6.Enabled:=False;
end;

procedure TAboutBox.Timer3Timer(Sender: TObject);
begin
Timer6.Enabled:=True;
Timer3.Enabled:=False;
end;

end.

