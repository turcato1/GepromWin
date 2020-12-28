unit UnitMacredapr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm7 = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses UnitGepromMacroEditor;

{$R *.DFM}

procedure TForm7.Timer1Timer(Sender: TObject);
begin
Form7.Close;
Form8.Show;
Timer1.Enabled:=False;
end;

end.
