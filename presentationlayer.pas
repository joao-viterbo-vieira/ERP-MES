unit PresentationLayer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, Unit1;

procedure updateGrids();


implementation


procedure updateGrids();
begin

    Form2.SQLCorders.Active                := False;
    Form2.SQLCorders.Active                := True;
    Form2.SQLEorders.Active                := False;
    Form2.SQLEorders.Active                := True;
    Form2.SQLProducts.Active               := False;
    Form2.SQLProducts.Active               := True;
    Form2.SQLMaterials.Active              := False;
    Form2.SQLMaterials.Active              := True;
    Form2.SQLPorders.Active                := False;
    Form2.SQLPorders.Active                := True;
    Form2.SQLSorders.Active                := False;
    Form2.SQLSorders.Active                := True;
    Form2.SQLCustomers.Active              := False;
    Form2.SQLCustomers.Active              := True;
    Form2.SQLCustomersData.Active          := False;
    Form2.SQLCustomersData.Active          := True;
    Form2.SQLProductsData.Active           := False;
    Form2.SQLProductsData.Active           := True;
    Form2.SQLMaterialsData.Active          := False;
    Form2.SQLMaterialsData.Active          := True;
    Form2.SQLCordersData.Active            := False;
    Form2.SQLCordersData.Active            := True;


    Form2.DBGridCorders.Columns[0].Width   := 80;
    Form2.DBGridCorders.Columns[1].Width   := 0;
    Form2.DBGridCorders.Columns[2].Width   := 140;
    Form2.DBGridCorders.Columns[3].Width   := 0;
    Form2.DBGridCorders.Columns[4].Width   := 130;
    Form2.DBGridCorders.Columns[5].Width   := 80;
    Form2.DBGridCorders.Columns[6].Width   := 130;
    Form2.DBGridCorders.Columns[7].Width   := 180;
    Form2.DBGridCorders.Columns[8].Width   := 180;

    Form2.DBGridEorders.Columns[0].Width   := 80;
    Form2.DBGridEorders.Columns[1].Width   := 80;
    Form2.DBGridEorders.Columns[2].Width   := 90;
    Form2.DBGridEorders.Columns[3].Width   := 0;
    Form2.DBGridEorders.Columns[4].Width   := 110;
    Form2.DBGridEorders.Columns[5].Width   := 0;
    Form2.DBGridEorders.Columns[6].Width   := 80;
    Form2.DBGridEorders.Columns[7].Width   := 120;
    Form2.DBGridEorders.Columns[8].Width   := 0;
    Form2.DBGridEorders.Columns[9].Width   := 0;

    Form2.DBGridProducts.Columns[0].Width  := 100;
    Form2.DBGridProducts.Columns[1].Width  := 170;
    Form2.DBGridProducts.Columns[2].Width  := 150;
    Form2.DBGridProducts.Columns[3].Width  := 120;
    Form2.DBGridProducts.Columns[4].Width  := 0;
    Form2.DBGridProducts.Columns[5].Width  := 150;
    Form2.DBGridProducts.Columns[6].Width  := 0;
    Form2.DBGridProducts.Columns[7].Width  := 0;

    Form2.DBGridPorders.Columns[0].Width   := 80;
    Form2.DBGridPorders.Columns[1].Width   := 100;
    Form2.DBGridPorders.Columns[2].Width   := 100;
    Form2.DBGridPorders.Columns[3].Width   := 100;
    Form2.DBGridPorders.Columns[4].Width   := 180;
    Form2.DBGridPorders.Columns[5].Width   := 190;
    Form2.DBGridPorders.Columns[6].Width   := 120;

    Form2.DBGridMaterials.Columns[0].Width := 100;
    Form2.DBGridMaterials.Columns[1].Width := 150;
    Form2.DBGridMaterials.Columns[2].Width := 150;
    Form2.DBGridMaterials.Columns[3].Width := 150;
    Form2.DBGridMaterials.Columns[4].Width := 150;

    Form2.DBGridSorders.Columns[0].Width   := 80;
    Form2.DBGridSorders.Columns[1].Width   := 0;
    Form2.DBGridSorders.Columns[2].Width   := 150;
    Form2.DBGridSorders.Columns[3].Width   := 0;
    Form2.DBGridSorders.Columns[4].Width   := 150;
    Form2.DBGridSorders.Columns[5].Width   := 80;
    Form2.DBGridSorders.Columns[6].Width   := 150;
    Form2.DBGridSorders.Columns[7].Width   := 150;
    Form2.DBGridSorders.Columns[8].Width   := 150;

    Form2.DBGridCustomers.Columns[0].Width := 100;
    Form2.DBGridCustomers.Columns[1].Width := 150;


end;

end.

