unit UnitGepromCarr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Gauges, StdCtrls;

type
  TForm6 = class(TForm)
    Gauge1: TGauge;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.DFM}

procedure TForm6.FormActivate(Sender: TObject);
begin
//If Gauge1.Progress=Gauge1.MaxValue then
//begin
//Form6.Close;
//Gauge1.Progress:=0;
//end;
end;

end.
