program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, comTestUnit, comUnit, unitdispatcher, forms_inicial,
  Unit1, PresentationLayer, DataLayer, unit2, unit3;

{$R *.res}

begin
     RequireDerivedFormResource:=True;
     Application.Scaled:=True;
     Application.Initialize;
     Application.CreateForm(TForm1, Form1);
     Application.CreateForm(TFormDispatcher, FormDispatcher);
     Application.CreateForm(TFormComTest, FormComTest);
     Application.CreateForm(TComForm, ComForm);
     Application.CreateForm(TForm2, Form2);
     Application.Run;
end.

