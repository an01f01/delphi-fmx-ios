program SampleFmx;

uses
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  Sample.Form.Main in '..\Src\Sample.Form.Main.pas' {Form1};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
