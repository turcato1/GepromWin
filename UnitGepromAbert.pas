unit UnitGepromAbert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
const
  crEprCur1=5;
  crEprCur2=6;
  crEprCur3=7;
  crEprCur4=8;

implementation

{$R *.DFM}

procedure TForm2.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
//Form2.Cursor:='Eprcur1.cur';
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Screen.Cursors[crEprCur1] :=
  LoadCursor(HInstance, 'f:\Thiago\Delphi~1\Gepromwin\EprCur1.cur');
  //Cursor := crEprCur1;
  Screen.Cursors[crEprCur2] := LoadCursor(HInstance, 'EprCur2.cur');
  //Cursor := crEprCur2;
  Screen.Cursors[crEprCur3] := LoadCursor(HInstance, 'EprCur3.cur');
  //Cursor := crEprCur3;
  Screen.Cursors[crEprCur4] := LoadCursor(HInstance, 'EprCur4.cur');
  //Timer1.Enabled:=True;
  //Cursor := crEprCur4;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var indice:integer;
begin
If indice>4 then indice:=0;
inc(indice);
Case indice of
     1:Form2.Cursor:=crEprCur1;
     2:Form2.Cursor:=crEprCur2;
     3:Form2.Cursor:=crEprCur3;
     4:Form2.Cursor:=crEprCur4;
   end;
end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
Cursor:=crEprCur1;
end;

end.
