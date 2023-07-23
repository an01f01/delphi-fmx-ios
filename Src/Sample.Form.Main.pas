unit Sample.Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Notification, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects,
  Skia, Skia.FMX, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFrmMain = class(TForm)
    NotificationCenter1: TNotificationCenter;
    RctNotificationButton: TRectangle;
    SbCreateNotification: TSpeedButton;
    SkNotificationLabel: TSkLabel;
    Memo1: TMemo;
    procedure SbCreateNotificationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

uses
  System.Permissions;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

  {$IFDEF IOS}
    if NotificationCenter1.AuthorizationStatus <> TAuthorizationStatus.Authorized then begin
      NotificationCenter1.RequestPermission;
    end;
  {$ENDIF}
  {$IFDEF ANDROID}
    if NotificationCenter1.AuthorizationStatus <> TAuthorizationStatus.Authorized then begin
      NotificationCenter1.RequestPermission;
    end;

    if PermissionsService.IsPermissionGranted('android.permission.POST_NOTIFICATIONS') <> True then begin
      PermissionsService.RequestPermissions(['android.permission.POST_NOTIFICATIONS'],
        procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
        begin
          if AGrantResults[0] <> TPermissionStatus.Granted then
            Memo1.Lines.Add('Please enable notifications for EMA reminders');
        end
      );
    end;
  {$ENDIF}

end;

procedure TFrmMain.SbCreateNotificationClick(Sender: TObject);
begin

  if NotificationCenter1.AuthorizationStatus = TAuthorizationStatus.Authorized then
  begin
    var vNotification:= NotificationCenter1.CreateNotification;
    try
      vNotification.Name:= 'TEST';
      vNotification.AlertBody:= 'This is a test notification';
      vNotification.Title:= 'Test Title';
      vNotification.EnableSound:= true;
      NotificationCenter1.PresentNotification(vNotification);
    finally
      vNotification.DisposeOf;
    end;
  end;

end;

end.
