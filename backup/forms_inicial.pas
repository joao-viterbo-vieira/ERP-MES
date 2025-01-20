unit forms_inicial;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  unitdispatcher, Unit1;
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  FormDispatcher.Show;
  //Form1.Hide;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.Show;
  //Form1.Hide;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form1.close;
end;

end.

