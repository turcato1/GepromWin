program Geprmwin;

uses
  Forms,
  UnitGepromMain in 'UnitGepromMain.pas' {Form1},
  UnitGepromInDados in 'UnitGepromInDados.pas' {Form3},
  UnitGepromAbout in 'UnitGepromAbout.pas' {AboutBox},
  UnitGepromAbert in 'UnitGepromAbert.pas' {Form2},
  UnitGepromDlgErro in 'UnitGepromDlgErro.pas' {Form4},
  UnitGepromOpc in 'UnitGepromOpc.pas' {Form5},
  UnitGepromCarr in 'UnitGepromCarr.pas' {Form6},
  UnitMacredapr in 'UnitMacredapr.pas' {Form7},
  UnitGepromMacroEditor in 'UnitGepromMacroEditor.pas' {Form8};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Mayumi Electric Corporation - G series EPROM Writers';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
