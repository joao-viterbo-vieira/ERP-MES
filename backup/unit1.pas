unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, PQConnection, SQLDB, DB, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, DBGrids, ComCtrls, Menus, TASources, TAGraph,
  TASeries, Types, TACustomSource;

type

  { TForm2 }

  TForm2 = class(TForm)
    inbo1: TEdit;
    inbo2: TEdit;
    inbo3: TEdit;
    inbo4: TEdit;
    inbo5: TEdit;
    inbo6: TEdit;
    inbo7: TEdit;
    inbo8: TEdit;
    inbo9: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    mmMaxCorders: TMemo;
    mmMaxCustomerProfit: TMemo;
    mmNoCorders: TMemo;
    mmNoCustomers: TMemo;
    mmNoProducts: TMemo;
    mmNoSuppliers: TMemo;
    Refresh2: TButton;
    CountExpTotal: TEdit;
    CountProdTotal: TEdit;
    CountSupTotal: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label9: TLabel;
    Shape1: TShape;
    Shape2: TShape;

    TabSheet9: TTabSheet;
    Tedit_weekp: TEdit;
    Image17: TImage;
    smartplanning: TButton;
    //Controlo Form
    Label1: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    LbTexpress: TLabel;
    LbDigicert: TLabel;
    LbArxa: TLabel;
    LblSupplyMatName: TLabel;
    LblCorderStatus: TLabel;
    LblMatPrice: TLabel;
    LblMatSS: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    LbTotally: TLabel;
    Nome: TLabel;


    Debug_Memo: TMemo;

    btInsertCustomer: TButton;
    btDeleteCustomer: TButton;
    btUpdateCustomer: TButton;
    btClearCustomer: TButton;
    btInsertCorder: TButton;
    btDeleteCorder: TButton;
    btUpdateCorder: TButton;
    btClearCorder: TButton;
    btPlanExpedition: TButton;
    btResetExpedition: TButton;
    btPlanProduction: TButton;
    btResetProduction: TButton;
    btPlanSorders: TButton;
    btResetSorders: TButton;
    AnaliseDados: TButton;
    btClearProduct: TButton;
    btDeleteProduct: TButton;
    btFilter: TButton;
    btClearFilter: TButton;
    btInsertProduct: TButton;
    btUpdateProduct: TButton;
    btBack: TButton;
    btUpdateMaterial: TButton;
    btInsertSorder: TButton;
    Button2: TButton;
    Button3: TButton;

    cbCustomer: TComboBox;
    cbProduct: TComboBox;
    cbMaterial: TComboBox;
    cbSorderMat: TComboBox;
    cbSupplierName: TComboBox;
    cbCustomerStatus: TComboBox;

    edCustomerName: TEdit;
    edQuantity: TEdit;
    edWeekPlanned: TEdit;
    edProductName: TEdit;
    edInventory: TEdit;
    edPrice: TEdit;
    DigicertOrders: TEdit;
    ArxaOrders: TEdit;
    edMatName: TEdit;
    TabSheet8: TTabSheet;
    TexpressOrders: TEdit;
    edSupplyWeekP: TEdit;
    edSupplyQnt: TEdit;
    edMatPrice: TEdit;
    edMatSS: TEdit;
    TotallyOrders: TEdit;

    DBGridCustomers: TDBGrid;
    DBGridCorders: TDBGrid;
    DBGridEorders: TDBGrid;
    DBGridPorders: TDBGrid;
    DBGridProducts: TDBGrid;
    DBGridMaterials: TDBGrid;
    DBGridSorders: TDBGrid;

    DSCustomers: TDataSource;
    DSMaterials: TDataSource;
    DSPorders: TDataSource;
    DSCorders: TDataSource;
    DSEorders: TDataSource;
    DSProducts: TDataSource;
    DSSorders: TDataSource;

    PageControl1: TPageControl;

    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;

    ChartProfitCustomer: TChart;
    ChartCorders1: TChart;
    ChartLateDeliveries: TChart;
    ChartProfitCustomer1: TChart;


    ChartProductBarLatenessSeries: TBarSeries;
    ChartProfitCustomerBarSeries: TBarSeries;
    ChartProfitCustomerBarSeries1: TBarSeries;

    ListChartSourceLateDeliveriesLG: TListChartSource;
    ListChartSourceLateDeliveriesBG: TListChartSource;
    ListChartSourceLateDeliveriesLB: TListChartSource;
    ListChartSourceLateDeliveriesBB: TListChartSource;
    ListChartSourceProfitCustomer: TListChartSource;
    ListChartSourceCorders: TListChartSource;
    ListChartSourceLatenessProducts: TListChartSource;
    ListChartSourceProducts: TListChartSource;

    ChartLateDeliveriesLineSeriesBB: TLineSeries;
    ChartLateDeliveriesLineSeriesBG: TLineSeries;
    ChartLateDeliveriesLineSeriesLB: TLineSeries;
    ChartLateDeliveriesLineSeriesLG: TLineSeries;

    Timer1: TTimer;

    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;

    //Controlo Base Dados
    PQConnection1  : TPQConnection;
    SQLProducts: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLCustomers: TSQLQuery;
    SQLCorders  : TSQLQuery;
    SQLEorders: TSQLQuery;
    SQLPorders: TSQLQuery;
    SQLMaterials: TSQLQuery;
    SQLSorders: TSQLQuery;
    SQLSuppliers: TSQLQuery;
    SQLCordersData: TSQLQuery;         //Duplicar queries para Análise Dados
    SQLCustomersData: TSQLQuery;
    SQLMaterialsData: TSQLQuery;
    SQLProductsData: TSQLQuery;
    SQLEordersData: TSQLQuery;
    SQLPordersData: TSQLQuery;
    SQLSordersData: TSQLQuery;


    //Procedures and functions
    procedure btBackClick(Sender: TObject);
    procedure btClearProductClick(Sender: TObject);
    procedure btDeleteProductClick(Sender: TObject);
    procedure btFilterClick(Sender: TObject);
    procedure btClearFilterClick(Sender: TObject);
    procedure btInsertProductClick(Sender: TObject);
    procedure btInsertSorderClick(Sender: TObject);
    procedure btUpdateProductClick(Sender: TObject);
    procedure mmNoCustomersChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Refresh2Click(Sender: TObject);
    procedure smartplanningClick(Sender: TObject);
    procedure btUpdateMaterialClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btClearCustomerClick(Sender: TObject);
    procedure btDeleteCustomerClick(Sender: TObject);
    procedure btInsertCustomerClick(Sender: TObject);
    procedure btPlanProductionClick(Sender: TObject);
    procedure btPlanSordersClick(Sender: TObject);
    procedure AnaliseDadosClick(Sender: TObject);
    procedure AnaliseDados2Click(Sender: TObject);
    procedure btResetProductionClick(Sender: TObject);
    procedure btResetSordersClick(Sender: TObject);
    procedure btUpdateCustomerClick(Sender: TObject);
    procedure btInsertCorderClick(Sender: TObject);
    procedure btDeleteCorderClick(Sender: TObject);
    procedure btUpdateCorderClick(Sender: TObject);
    procedure btClearCorderClick(Sender: TObject);
    procedure btPlanExpeditionClick(Sender: TObject);
    procedure btResetExpeditionClick(Sender: TObject);
    procedure DBGridMaterialsCellClick();
    procedure DBGridCustomersCellClick();
    procedure DBGridCordersCellClick();
    //procedure DBGridSordersCellClick();
    procedure DBGridProductsCellClick();
    procedure Timer1Timer(Sender: TObject);

  private

  public

  end;

var
  Form2: TForm2;
  numExpOrderParts     : integer = 0;
  numProOrderParts    : integer = 0;
  numSupOrderParts     : integer = 0;
  inb1: integer = 0;
  inb2: integer = 0;
  inb3: integer = 0;
  inb4: integer = 0;
  inb5: integer = 0;
  inb6: integer = 0;
  inb7: integer = 0;
  inb8: integer = 0;
  inb9: integer = 0;

implementation

{$R *.lfm}

uses DataLayer, PresentationLayer;

{ TForm2 }


//******* Criar Form

procedure TForm2.FormCreate(Sender: TObject);
var
  recordNumber     : integer;  // Indice para o ciclo for que corre para todas as linhas


begin

  Tedit_weekp.text := '6';

   //Conectar Base de Dados
   PQConnection1.Connected := True;
   PQConnection1.ExecuteDirect('Begin Work;');
   PQConnection1.ExecuteDirect('set idle_in_transaction_session_timeout = 0');
   PQConnection1.ExecuteDirect('set schema ''minierp''');
   PQConnection1.ExecuteDirect('Commit Work;');

   SQLCustomers.Active := True;


   // Popular combobox de clientes
   for recordNumber    := 1 to SQLCustomers.RecordCount do
   begin

        SQLCustomers.RecNo := recordNumber;
        cbCustomer.Items.Add(SQLCustomers.FieldByName('customer_name').AsString);

   end;


   SQLMaterials.Active := True;

   //Popular combobox de materiais               '

   for recordNumber := 1 to SQLMaterials.RecordCount do
   begin

        SQLMaterials.RecNo := recordNumber;
        cbMaterial.Items.Add(SQLMaterials.FieldByName('material_name').AsString);
   end;


   for recordNumber := 1 to SQLMaterials.RecordCount do
   begin

        SQLMaterials.RecNo := recordNumber;
        cbSorderMat.Items.Add(SQLMaterials.FieldByName('material_name').AsString);
   end;

   SQLSuppliers.Active := True;
   //Popular combobox de fornecimento                '

   for recordNumber := 1 to SQLSuppliers.RecordCount do
   begin

        SQLSuppliers.RecNo := recordNumber;
        cbSupplierName.Items.Add(SQLSuppliers.FieldByName('supplier_name').AsString);
   end;



   SQLProducts.Active  := True;

   //Popular combobox de produtos
   for recordNumber   := 1 to SQLProducts.RecordCount do
   begin

        SQLProducts.RecNo := recordNumber;
        cbProduct.Items.Add(SQLProducts.FieldByName('product_name').AsString);

   end;







   SQLPorders.Active       := True;
   SQLMaterials.Active     := True;
   SQLProducts.Active      := True;
   SQLEorders.Active       := True;
   SQLCorders.Active       := True;
   SQLSorders.Active       := True;
   SQLCustomers.Active     := True;
   SQLSuppliers.Active     := True;
   SQLCustomersData.Active := True;
   SQLProductsData.Active  := True;
   SQLMaterialsData.Active := True;
   SQLCordersData.Active   := True;
   SQLEordersData.Active    := True;
   SQLPordersData.Active    := True;
   SQLSordersData.Active    := True;


   updateGrids();

   Timer1.Enabled      := True;

end;


//******* Página Clientes

procedure TForm2.DBGridCustomersCellClick();
begin

   edCustomerName.Text := SQLCustomers.FieldByName('customer_name').AsString;

end;

procedure TForm2.btInsertCustomerClick(Sender: TObject);
var

  productName     : string;

begin

   productName    := edCustomerName.Text;

   if productName <> '' then
   begin

        insertCustomer(productName);

   end
   else
   begin

        Application.MessageBox('You need to fill in the name of the new product.','Error');

   end;

   updateGrids();

end;

procedure TForm2.btDeleteCustomerClick(Sender: TObject);
var
  customerId     : integer;
  corderId       : integer;
  eorderId       : integer;

  recordNumberC  : integer;
  recordNumberE  : integer;

begin

  customerId     := SQLCustomers.FieldByName('customer_id').AsInteger;

  for recordNumberC := 1 to SQLCorders.RecordCount do                // Se apagar cliente, vou apagar todas as corders associadas
  begin

      SQLCorders.RecNo := recordNumberC;

      if SQLCorders.FieldByName('customer_id').AsInteger = customerId then
      begin

          corderId := SQLCorders.FieldByName('corder_id').AsInteger;

          for recordNumberE := 1 to SQLEorders.RecordCount do         // Se apagar corder, vou apagar todas as eorders associadas
          begin

              SQLEorders.RecNo := recordNumberE;

              if SQLEorders.FieldByName('corder_id').AsInteger = corderId then
              begin

                  eorderId := SQLEorders.FieldByName('eorder_id').AsInteger;
                  deleteEorder(eorderId);

              end;

          end;

          deleteCorder(corderId);

      end;

  end;

  deleteCustomer(customerId);

  updateGrids();

end;

procedure TForm2.btUpdateCustomerClick(Sender: TObject);
var
   customerName      : string;
   customerId        : integer;

begin

  customerId         := SQLCustomers.FieldByName('customer_id').AsInteger;
  customerName       := edCustomerName.Text;

  if customerName <> '' then
  begin

      updateCustomer(customerId, customerName);

  end
  else
  begin

      Application.MessageBox('There are required fields you must fill.','Error');

  end;

  updateGrids();

end;

procedure TForm2.btClearCustomerClick(Sender: TObject);
begin

   edCustomerName.Clear;

end;


//*******Página Inventário

procedure TForm2.DBGridProductsCellClick();
var
  recordNumber    : integer;

begin

  for recordNumber := 1 to SQLMaterials.RecordCount do
     begin

       SQLMaterials.RecNo := recordNumber;

       if SQLMaterials.FieldByName('material_id').AsInteger = SQLProducts.FieldByName('material_id').AsInteger then
       begin

            cbMaterial.ItemIndex := recordNumber - 1;

       end;
     end;

    edProductName.Text    := SQLProducts.FieldByName('product_name').AsString;
    edInventory.Text := SQLProducts.FieldByName('product_inventory').AsString;
    edPrice.Text := SQLProducts.FieldByName('product_price').AsString;


end;


procedure TForm2.btInsertProductClick(Sender: TObject);
var
  productName: String;
  productInventory: Integer;
  materialId: Integer;
  productPrice: Extended;
begin
  productName := edProductName.Text;
  productInventory := StrToIntDef(edInventory.Text, 0);
  productPrice := StrToFloatDef(Trim(edPrice.Text), 0);

  // Verificar se os campos estão preenchidos
  if (productName = '') or (edInventory.Text = '') or (edPrice.Text = '') then
  begin
    ShowMessage('Please fill in all the fields.');
    Exit;
  end;

  //  Verificar se inventário é positivo
  if productInventory < 0 then
  begin
    ShowMessage('Product inventory must be a positive integer.');
    Exit;
  end;

  // Verificar se o preço é float positivo
  if productPrice < 0 then
  begin
    ShowMessage('Product price must be a positive number.');
    Exit;
  end;

  SQLMaterials.RecNo := cbMaterial.ItemIndex + 1;
  materialId := SQLMaterials.Fields[0].AsInteger;

  insertProduct(productName, productInventory, materialId, productPrice);

  updateGrids();
end;



procedure TForm2.btUpdateProductClick(Sender: TObject);
var
  productId: Integer;
  productName: String;
  productInventory: Integer;
  materialId: Integer;
  productPrice: Extended;
begin
  productId := SQLProducts.FieldByName('product_id').AsInteger;
  productName := edProductName.Text;
  productInventory := StrToIntDef(edInventory.Text, 0);
  productPrice := StrToFloatDef(edPrice.Text, 0);

  // Verificar se os campos estão preenchidos
  if (productName = '') or (edInventory.Text = '') or (edPrice.Text = '') then
  begin
    ShowMessage('Please fill in all the fields.');
    Exit;
  end;

  // Verificar se inventário é positivo
  if productInventory < 0 then
  begin
    ShowMessage('Product inventory must be a positive integer.');
    Exit;
  end;

  // Verificar se o preço é float positivo
  if productPrice < 0 then
  begin
    ShowMessage('Product price must be a positive number.');
    Exit;
  end;

  SQLMaterials.RecNo := cbMaterial.ItemIndex + 1;
  materialId := SQLMaterials.Fields[0].AsInteger;

  updateProduct(productId, productName, productInventory, materialId, productPrice);

  updateGrids();
end;

procedure TForm2.mmNoCustomersChange(Sender: TObject);
begin

end;

procedure TForm2.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm2.Refresh2Click(Sender: TObject);
begin
  AnaliseDados2Click(Self);
end;



procedure TForm2.DBGridMaterialsCellClick();

begin


  edMatSS.Text    := Form2.SQLMaterials.FieldByName('material_sstock').AsString;
  edMatPrice.Text := Form2.SQLMaterials.FieldByName('material_price').AsString;
  edMatName.Text  := Form2.SQLMaterials.FieldByName('material_name').AsString;


end;

procedure TForm2.btUpdateMaterialClick(Sender: TObject);
var
  materialId: Integer;
  materialName: String;
  materialInventory: Integer;
  materialSStock: Integer;
  materialPrice: Extended;
begin
  materialId := SQLMaterials.FieldByName('material_id').AsInteger;
  materialName := SQLMaterials.FieldByName('material_name').AsString;
  materialSStock := StrToIntDef(edMatSS.Text, 0);
  materialInventory := SQLMaterials.FieldByName('material_inventory').AsInteger;
  materialPrice := StrToFloatDef(edMatPrice.Text, 0);

  // Verificar se os campos estão preenchidos
  if (edMatSS.Text = '') or (edMatPrice.Text = '') then
  begin
    ShowMessage('Preenche todos os campos.');
    Exit;
  end;

  //  Verificar se inventário de segurança é positivo
  if materialSStock < 0 then
  begin
    ShowMessage('Stock Positivo.');
    Exit;
  end;

  // Verificar se o preço é float positivo
  if materialPrice < 0 then
  begin
    ShowMessage('O preço tem de ser positivo.');
    Exit;
  end;


  updateMaterials(materialId, materialName, materialInventory, materialSStock, materialPrice);

  updateGrids();
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  cbSorderMat.ItemIndex := -1;
  cbSupplierName.ItemIndex  := -1;
  edSupplyQnt.Clear;
  edSupplyWeekP.Clear;

  updateGrids();
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  updateGrids();
end;


procedure TForm2.smartplanningClick(Sender: TObject);
begin
  btPlanExpeditionClick(Sender);
  btPlanProductionClick(Sender);
  btPlanSordersClick(Sender);
  Application.MessageBox('Ordens Planeadas! Não carregue em mais nenhum botão planear nesta semana.','Alert');
end;


procedure TForm2.btDeleteProductClick(Sender: TObject);
var
  productId: integer;
begin
  productId    := SQLProducts.FieldByName('product_id').AsInteger;

  deleteProduct(productId);

  updateGrids();

end;

procedure TForm2.btClearProductClick(Sender: TObject);
begin
    cbMaterial.ItemIndex := -1;
    edProductName.Clear;
    edInventory.Clear;
    edPrice.Clear;

    updateGrids();

end;


//******* Página Corders

procedure TForm2.DBGridCordersCellClick();
var
  recordNumber    : integer;
  i: Integer;
  selectedStatus: String;

begin

     for recordNumber := 1 to SQLCustomers.RecordCount do
     begin

       SQLCustomers.RecNo := recordNumber;

       if SQLCustomers.FieldByName('customer_id').AsInteger = SQLCorders.FieldByName('customer_id').AsInteger then
       begin

            cbCustomer.ItemIndex := recordNumber - 1;

       end;
     end;

     for recordNumber := 1 to SQLProducts.RecordCount do
     begin

       SQLProducts.RecNo := recordNumber;

       if SQLProducts.FieldByName('product_id').AsInteger = SQLCorders.FieldByName('product_id').AsInteger then
       begin

            cbProduct.ItemIndex := recordNumber - 1;

       end;
     end;

     // Obtém o status da linha selecionada na DBGridOrders
    selectedStatus := SQLCorders.FieldByName('corder_status').AsString;

    // Percorre os itens da ComboBox cbStatus para encontrar e selecionar o status correspondente
    for i := 0 to cbCustomerStatus.Items.Count - 1 do
    begin
      if cbCustomerStatus.Items[i] = selectedStatus then
      begin
        cbCustomerStatus.ItemIndex := i;
        Break;
      end;
    end;



    edQuantity.Text    := SQLCorders.FieldByName('corder_qt').AsString;
    edWeekPlanned.Text := SQLCorders.FieldByName('corder_week_planned').AsString;

end;


procedure TForm2.btInsertCorderClick(Sender: TObject);
var
  customerId: Integer;
  productId: Integer;
  corderQt: Integer;
  corderWeekp: Integer;
  corderStatus: string;
begin
  corderQt := 0;
  corderWeekp := 0;

  // Verificar se a qnt é inteiro positivo
  if not TryStrToInt(edQuantity.Text, corderQt) or (corderQt <= 0) then
  begin
    ShowMessage('A quantidade tem de ser positiva.');
    Exit;
  end;

  //Verificar se semana planeada é inteiro válido
  if not TryStrToInt(edWeekPlanned.Text, corderWeekp) then
  begin
    ShowMessage('A weekp tem de ser um inteiro válido.');
    Exit;
  end;

  // Verificar se a week_planned é seguinte à semana atual
  if corderWeekp >= strtoint(Tedit_weekp.text) then
  begin
    //  Verificar a validade dos valores
    if (cbCustomerStatus.ItemIndex > -1) and (cbCustomer.ItemIndex > -1) and (cbProduct.ItemIndex > -1) and (corderWeekp <> 0) then
    begin
      SQLCustomers.RecNo := cbCustomer.ItemIndex + 1;
      SQLProducts.RecNo := cbProduct.ItemIndex + 1;;

      productId := SQLProducts.Fields[0].AsInteger;
      customerId := SQLCustomers.Fields[0].AsInteger;

      Form2.Debug_Memo.Lines.Add(cbCustomerStatus.Text);
      if cbCustomerStatus.Text <> 'accepted' then
      begin
         ShowMessage('Ordem inserida deve ser aceite.');
         Exit;
      end;

      insertCorder(customerId, productId, corderQt, corderWeekp);
    end
    else
    begin
      Application.MessageBox('Faltam ser preenchidos campos.', 'Error');
    end;
  end
  else
  begin
    Application.MessageBox(PChar('Não podes criar ordens anteriores à semana atual (' + Tedit_weekp.Text + ').'), 'Error');
  end;

  updateGrids();
end;

procedure TForm2.btDeleteCorderClick(Sender: TObject);
var
  corderId    : integer;

begin

  corderId    := SQLCorders.FieldByName('corder_id').AsInteger;

  deleteCorder(corderId);

  updateGrids();

end;

procedure TForm2.btUpdateCorderClick(Sender: TObject);
var
  corderId: Integer;
  customerId: Integer;
  productId: Integer;
  corderQt: Integer;
  corderWeekp: Integer;
  corderStatus: string;
begin
  corderQt := 0;
  corderWeekp := 0;

  corderId := SQLCorders.FieldByName('corder_id').AsInteger;

  //Verificar se a qnt é inteiro positivo
  if not TryStrToInt(edQuantity.Text, corderQt) or (corderQt <= 0) then
  begin
    ShowMessage('A quantidade tem de ser positiva.');
    Exit;
  end;

  //Verificar se semana planeada é inteiro válido
  if not TryStrToInt(edWeekPlanned.Text, corderWeekp) then
  begin
    ShowMessage('A semana planeada tem de ser um inteiro.');
    Exit;
  end;

  // Verificar se a week_planned é seguinte à semana atual
  if corderWeekp >= strtoint(Tedit_weekp.text) then
  begin
    // Verificar a validade dos valores
    if (cbCustomerStatus.ItemIndex > -1) and (cbCustomer.ItemIndex > -1) and (cbProduct.ItemIndex > -1) and (corderWeekp <> 0) then
    begin
      SQLCustomers.RecNo := cbCustomer.ItemIndex + 1;
      SQLProducts.RecNo := cbProduct.ItemIndex + 1;

      customerId := SQLCustomers.FieldByName('customer_id').AsInteger;
      productId := SQLProducts.FieldByName('product_id').AsInteger;
      corderstatus := cbCustomerStatus.Text;

      updateCorder(corderId, customerId, productId, corderQt, corderWeekp, corderstatus);
    end
    else
    begin
      Application.MessageBox('Há campos que precisas de preencher.', 'Error');
    end;
  end
  else
  begin
    Application.MessageBox(PChar('Não podes criar ordens anteriores à semana atual (' + Tedit_weekp.Text + ').'), 'Error');
  end;

  updateGrids();
end;

procedure TForm2.btClearCorderClick(Sender: TObject);
begin

    cbCustomer.ItemIndex := -1;
    cbProduct.ItemIndex  := -1;
    cbCustomerStatus.ItemIndex     := -1;
    edQuantity.Clear;
    edWeekPlanned.Clear;

    updateGrids();

end;

procedure TForm2.btFilterClick(Sender: TObject);
var
  selectedCustomerName: string;
  selectedProductName: string;
  selectedQt: Integer;
  selectedWeekp: Integer;
  selectedStatus: string;

begin

  // Inicializar variaveis de filtro
  selectedCustomerName := '';
  selectedProductName  := '';
  selectedStatus       := '';
  selectedQt           := -1;
  selectedWeekp        := -1;

  // Verificar opções de filtro e obter seus valores
  if cbCustomer.ItemIndex > -1 then
    selectedCustomerName := cbCustomer.Items[cbCustomer.ItemIndex];

  if cbProduct.ItemIndex > -1 then
    selectedProductName := cbProduct.Items[cbProduct.ItemIndex];

  if cbCustomerStatus.ItemIndex > -1 then
    selectedStatus      := cbCustomerStatus.Items[cbCustomerStatus.ItemIndex];

  // Validar entradas de qnt e week planned
  if (edQuantity.Text <> '') and (not TryStrToInt(edQuantity.Text, selectedQt)) then
  begin
    Application.MessageBox('A quantidade tem de ser um número inteiro.', 'Error');

    Exit;
  end;

  if (edWeekPlanned.Text <> '') and (not TryStrToInt(edWeekPlanned.Text, selectedWeekp)) then
  begin
    Application.MessageBox('A Semana planeada tem de ser um número inteiro.', 'Error');
    Exit;
  end;

  // Verificar validade dos valores
  if (selectedStatus = '') and (selectedCustomerName = '') and (selectedProductName = '') and (selectedQt = -1) and (selectedWeekp = -1) then
  begin
    Application.MessageBox('Não há campos para fazer a filtragem.','Error');
    Exit;
  end;

  filterCorder(selectedCustomerName, selectedProductName, selectedStatus, selectedQt, selectedWeekp);

  // Executar a querie e returnar valores filtrados
  updateGrids();

  btClearFilter.Enabled := True;

end;

procedure TForm2.btClearFilterClick(Sender: TObject);
begin

  clearFilterCorder();

  updateGrids();

  btClearFilter.Enabled := False;

  btClearCorderClick(nil);

end;


//******* Página Eorders (ordens de expedição)

procedure TForm2.btPlanExpeditionClick(Sender: TObject);
var
  corderID                : integer;
  corderQt                : integer;
  corderWeekPlanned       : integer;
  corderStatus            : string;

  productId               : integer;

  initialProductInventory : integer;
  newProductInventory     : integer;

  recordNumber            : integer;

begin
    btClearFilterClick(nil);
    for recordNumber := 1 to SQLCorders.RecordCount do
    begin

       SQLCorders.RecNo := recordNumber;
       Debug_Memo.Lines.Add('Cycle for row: ' + IntToStr(recordNumber));

       productId := SQLCorders.FieldByName('product_id').AsInteger;
       initialProductInventory := getInventoryByProductId(productId);


       if (SQLCorders.FieldByName('corder_status').AsString = 'accepted') and
          (SQLCorders.FieldByName('corder_week_planned').AsInteger <= strtoint(Tedit_weekp.text)) and     //Só vai enviar as ordens desta semana
          (SQLCorders.FieldByName('corder_qt').AsInteger <= initialProductInventory) then

       begin

          Debug_Memo.Lines.Add('Product id: ' + IntToStr(productId) + ', initial inventory: ' +
                            IntToStr(initialProductInventory) + '. Lets create the expedition order ' +
                            'and update the status of the customer order to planned, and the inventory of the product!');


          //Inserir eorder
          corderId          := SQLCorders.FieldByName('corder_id').AsInteger;
          corderQt          := SQLCorders.FieldByName('corder_qt').AsInteger;
          corderWeekPlanned := SQLCorders.FieldByName('corder_week_planned').AsInteger;
          corderStatus      := 'planned';
          insertEorder(corderId, corderQt, corderWeekPlanned, corderStatus);


          //Atualizar inventário de produto
          newProductInventory := initialProductInventory - SQLCorders.FieldByName('corder_qt').AsInteger;
          updateProductInventory(productId, newProductInventory);


          //Atualizar estado de corder
          updateCordersStatus(corderId, 'planned');


          //Atualizar a interface
          updateGrids();

       end
       else  // O status da ordem é diferente de aceira, ou não há produtos suficientes para concretizar a ordem
       begin

          Debug_Memo.Lines.Add('Order status: ' +  SQLCorders.FieldByName('corder_status').AsString +
                            ', and order quantity: ' + SQLCorders.FieldByName('corder_qt').AsString);
          Debug_Memo.Lines.Add('Product id: ' + IntToStr(productId) + ', initial inventory: '
                            + IntToStr(initialProductInventory) + '. the order status <> accepted OR ' +
                            'there is no sufficient stock.Lets skip this order!');

       end;

    end;

    updateGrids();

end;

procedure TForm2.btResetExpeditionClick(Sender: TObject);
begin

 PQConnection1.ExecuteDirect('UPDATE corders SET status = ''accepted'', weekd = NULL; ' +
                                'DELETE FROM eorders; ' +
                                'UPDATE products SET inventory = 3 WHERE id = 4;'+
                                'delete from porders;' +
                              'delete from sorders;' +
                              'UPDATE materials SET inventory = 1 where id = 1;UPDATE materials SET inventory = 0 where id = 3;UPDATE materials SET inventory = 0 where id = 2;');

  updateGrids();

end;


//******* Página Porders

procedure TForm2.btPlanProductionClick(Sender: TObject);
var
  recordNumber             : integer;
  recordNumber2            : integer;

  productId                : integer;
  materialId               : integer;

  porderQt : integer;
  corderWeekPlanned        : integer;
  corderStatus             : string;

  initialProductInventory  : integer;
  initialMaterialInventory : integer;
  newProductInventory      : integer;
  newMaterialInventory     : integer;

begin

  for recordNumber := 1 to SQLCorders.RecordCount do
    begin

       SQLCorders.RecNo := recordNumber;
       Debug_Memo.Lines.Add('Cycle for row: ' + IntToStr(recordNumber));

       productId := SQLCorders.FieldByName('product_id').AsInteger;
       initialProductInventory := getInventoryByProductId(productId);

       for recordNumber2 := 1 to SQLProducts.RecordCount do
       begin

            SQLProducts.RecNo := recordNumber2;

            if SQLProducts.FieldByName('product_id').AsInteger = productId then
            begin

                 materialId := SQLProducts.FieldByName('material_id').AsInteger;
                 initialMaterialInventory := getInventoryByMaterialId(materialId);

            end;

       end;

       if (SQLCorders.FieldByName('corder_status').AsString = 'accepted')  and
          (SQLCorders.FieldByName('corder_qt').AsInteger > initialProductInventory) then

       begin

            if (SQLCorders.FieldByName('corder_week_planned').AsInteger <= (strtoint(Tedit_weekp.text)+1)) then       // Não produz mais que 1 semana de avanço
            begin

                Debug_Memo.Lines.Add('Product id: ' + IntToStr(productId) + ', product inventory: ' +
                                  IntToStr(initialProductInventory) + ', material inventory: ' +
                                  IntToStr(initialMaterialInventory) + '. Lets create the production order ' +
                                  '(status: planned) and update the inventory of the product and material!');


                // Inserir porder
                corderWeekPlanned := SQLCorders.FieldByName('corder_week_planned').AsInteger;
                corderStatus      := 'planned';


                if ((SQLCorders.FieldByName('corder_qt').AsInteger - initialProductInventory) <= initialMaterialInventory) then
                begin

                    porderQt     := SQLCorders.FieldByName('corder_qt').AsInteger - initialProductInventory;
                    insertPorder(productId, porderQt, corderWeekPlanned, corderStatus);

                    // Atualizar inventário de produto
                    newProductInventory := initialProductInventory + porderQt;
                    updateProductInventory(productId, newProductInventory);

                    //Atualizar inventário de material
                    newMaterialInventory := initialMaterialInventory - porderQt;
                    updateMaterialInventory(materialId, newMaterialInventory);

                    //Atualizar interface
                    updateGrids();

                end

                else if initialMaterialInventory > 0 Then            //Partial production
                begin

                    porderQt     := initialMaterialInventory;

                    // Criar ordem de produção auxiliar com qnt que resta para produzir
                    insertPorder(productId, SQLCorders.FieldByName('corder_qt').AsInteger - initialMaterialInventory,
                                 corderWeekPlanned, 'accepted');     // trocar para planned ?

                     //Criar ordem de produção auxiliar com qnt para produzir
                    insertPorder(productId, porderQt, corderWeekPlanned, corderStatus);  //Corder status = Planned

                    // Atualizar inventário de produto
                    newProductInventory := initialProductInventory + porderQt;
                    updateProductInventory(productId, newProductInventory);

                    // Atualizar inventário de material
                    newMaterialInventory := initialMaterialInventory - porderQt;
                    updateMaterialInventory(materialId, newMaterialInventory);

                    //Atualizar interface
                    updateGrids();

                end

                else
                begin

                     Debug_Memo.Lines.Add('Product id: ' + IntToStr(productId) + ', material inventory: ' +
                                       IntToStr(initialMaterialInventory) + '. Lets create the production order (status:accepted)!');

                     //Inserir porder
                     porderQt          := SQLCorders.FieldByName('corder_qt').AsInteger;
                     corderWeekPlanned := SQLCorders.FieldByName('corder_week_planned').AsInteger;
                     corderStatus      := 'accepted';  // trocar para planed????
                     insertPorder(productId, porderQt, corderWeekPlanned, corderStatus);

                     //Atualizar interface
                     updateGrids();

                end;

            end
            else
            begin

              Debug_Memo.Lines.Add('Product id: ' + IntToStr(productId) + ', material inventory: ' +
                                IntToStr(initialMaterialInventory) + '. Lets create the production order (status:accepted)!');

              //Inserir porder
              porderQt          := SQLCorders.FieldByName('corder_qt').AsInteger;
              corderWeekPlanned := SQLCorders.FieldByName('corder_week_planned').AsInteger;
              corderStatus      := 'accepted';
              insertPorder(productId, porderQt, corderWeekPlanned, corderStatus);

              //Atualizar interface
              updateGrids();

            end;
       end;
    end;

end;

procedure TForm2.btResetProductionClick(Sender: TObject);
begin

  PQConnection1.ExecuteDirect('UPDATE corders SET status = ''accepted'', weekd = NULL; ' +
                                'DELETE FROM eorders; ' +
                                'UPDATE products SET inventory = 3 WHERE id = 4;'+
                                'delete from porders;' +
                              'delete from sorders;' +
                              'UPDATE materials SET inventory = 1 where id = 1;UPDATE materials SET inventory = 0 where id = 3;UPDATE materials SET inventory = 0 where id = 2;');


  updateGrids();

end;


//******* Sorders Tab
(*procedure TForm2.DBGridSordersCellClick();
var
  recordNumber5    : integer = 0;

begin


  edSupplyQnt.Text    := SQLSorders.FieldByName('sorder_qt').AsString;
  edSupplyWeekP.Text  := SQLSorders.FieldByName('sorder_weekp').AsString;
  edSupplierName.Text := SQLSuppliers.FieldByName('supplier_name').AsString;
  edSorderMatName.Text     := SQLSorders.FieldByName('material_name').AsString;



end;*)

procedure TForm2.btInsertSorderClick(Sender: TObject);
var
  recordNumber : integer = 0;
  recordNumber2: integer = 0;
  sorderId     : integer;
  sorderIdmax  : integer = 0;
  supplierName : String;
  supplierId   : integer;
  sorderqnt    : Integer;
  materialId   : Integer;
  sorderweekp  : Integer;
begin
  //supplierName := edSupplierName.Text;
  sorderqnt := StrToIntDef(edSupplyQnt.Text, 0);
  sorderweekp := StrToIntDef(edSupplyWeekP.Text, 0);

  // Verificar valores
  if (edSupplyQnt.Text = '') or (edSupplyWeekP.Text = '') then
  begin
    ShowMessage('Please fill in all the fields.');
    Exit;
  end;

  if (cbSupplierName.ItemIndex < 0) or (cbSorderMat.ItemIndex < 0) then
  begin
    ShowMessage('Please fill in all the fields.');
    Exit;
  end;

  //Verificar se qnt é positiva
  if sorderqnt <= 0 then
  begin
    ShowMessage('Product quantity must be a positive integer.');
    Exit;
  end;

  // Verificar se weekp é inteiro positivo
  if sorderweekp <> strtoint(Tedit_weekp.text) then
  begin
    ShowMessage('A semana da entrega tem de ser a atual.');
    Exit;
  end;


  SQLSuppliers.RecNo := cbSupplierName.ItemIndex + 1 ;
  supplierId := SQLSuppliers.Fields[0].AsInteger;


  SQLMaterials.RecNo := cbSorderMat.ItemIndex + 1;
  materialId := SQLMaterials.Fields[0].AsInteger;


  for recordNumber := 1 to SQLSorders.RecordCount do
     begin

       SQLSorders.RecNo := recordNumber;

       sorderId := SQLSorders.FieldByName('sorder_id').AsInteger;

       if sorderId > sorderIdmax then
       begin
          sorderIdmax :=  sorderId;
       end;
     end;
  sorderIdmax := sorderIdmax + 1;

  //insertSorderManual(sorderIdmax,materialId, supplierId, sorderqnt, sorderweekp);
  updateMaterialInventory(materialId, sorderqnt);


  updateGrids();

end;

procedure TForm2.btPlanSordersClick(Sender: TObject);
var
  recordNumber             : integer;
  recordNumber2            : integer;

  porderId                 : integer;
  productId                : integer;
  materialId               : integer;
  porderQt                 : integer;
  porderWeekPlanned        : integer;
  porderStatus             : string;
  supplierId               : integer;

  initialMaterialInventory : integer;
  newMaterialInventory     : integer;
  materialSstock           : integer;

  sorderId                 : integer;
  PK_SoerderID   : integer;

begin
  PK_SoerderID := 1;
  for recordNumber := 1 to SQLPorders.RecordCount do
    begin

       SQLPorders.RecNo := recordNumber;
       Debug_Memo.Lines.Add('Cycle for row: ' + IntToStr(recordNumber));

       productId := SQLPorders.FieldByName('product_id').AsInteger;


       for recordNumber2 := 1 to SQLProducts.RecordCount do
       begin

            SQLProducts.RecNo := recordNumber2;

            if SQLProducts.FieldByName('product_id').AsInteger = productId then
            begin

                 materialId := SQLProducts.FieldByName('material_id').AsInteger;
                 initialMaterialInventory := getInventoryByMaterialId(materialId);

            end;

       end;

       if (trim(SQLPorders.FieldByName('porder_status').AsString) = 'accepted') then
       begin

              Debug_Memo.Lines.Add('Material id: ' + IntToStr(materialId) + ', material inventory: ' +
                                IntToStr(initialMaterialInventory) + '. Lets create the purchase order ' +
                                'and update the inventory of the material!');


              //Inserir sorder
              porderId          := SQLPorders.FieldByName('porder_id').AsInteger;
              porderQt          := SQLPorders.FieldByName('porder_qtp').AsInteger;
              porderWeekPlanned := SQLPorders.FieldByName('porder_week_planned').AsInteger;
              porderStatus      := 'planned';

              Randomize;
              supplierId        :=  random(2) + 1 ;        //Get random supplier

              insertSorder(porderId,materialId, supplierId, porderQt, porderWeekPlanned, porderStatus);   //estava porderId, insertSorder2 testar
                                                                                   //a dar erro aqui a repetir a PK
              PK_SoerderID := PK_SoerderID+1 ;

              //Atualizar inventário de material
              newMaterialInventory := initialMaterialInventory + porderQt;
              updateMaterialInventory(materialId, newMaterialInventory);


              //Atualizar interface
              updateGrids();

       end

       else    //O estado da ordem é dif de aceite
       begin

          Debug_Memo.Lines.Add('Order status: ' +  SQLCorders.FieldByName('corder_status').AsString +
                            ', and order quantity: ' + SQLCorders.FieldByName('corder_qt').AsString);
          Debug_Memo.Lines.Add('Product id: ' + IntToStr(productId) + ', material inventory: ' +
                             IntToStr(initialMaterialInventory) + '. the order status <> accepted OR ' +
                             'there is no sufficient stock.Lets skip this order!');

       end;
    end;


   //Stock Segurança
   sorderId := 100;                  //Novo id(grande) para encomendas de stock segurança

   for recordNumber := 1 to SQLMaterials.RecordCount do
   begin

      SQLMaterials.RecNo := recordNumber;
      Debug_Memo.Lines.Add('Cycle for row: ' + IntToStr(recordNumber));

      materialId         := SQLMaterials.FieldByName('material_id').AsInteger;
      materialSstock     := SQLMaterials.FieldByName('material_sstock').AsInteger;

      initialMaterialInventory := getInventoryByMaterialId(materialId);

      Debug_Memo.Lines.Add('Material id: ' + IntToStr(materialId) + ', material sstock: ' + IntToStr(materialSstock) +
                        ', material inventory: ' + IntToStr(initialMaterialInventory));



      if initialMaterialInventory < materialSstock then
      begin

          // Inserir sorder para cumprir stock de segurança
          porderQt          := materialSstock - initialMaterialInventory;
          porderWeekPlanned := strtoint(Tedit_weekp.text);
          porderStatus      := 'planned';

          Randomize;
          supplierId        :=  random(2) + 1 ;          //Get random supplier

          insertSorder(sorderId, materialId, supplierId, porderQt, porderWeekPlanned, porderStatus);


          // Atualizar inventário de material
          newMaterialInventory := initialMaterialInventory + porderQt;
          updateMaterialInventory(materialId, newMaterialInventory);


          //Atualizar interface
          updateGrids();

          sorderId := sorderId + 1;

       end;

   end;

end;

procedure TForm2.btResetSordersClick(Sender: TObject);
begin

  PQConnection1.ExecuteDirect('UPDATE corders SET status = ''accepted'', weekd = NULL; ' +
                                'DELETE FROM eorders; ' +
                                'UPDATE products SET inventory = 3 WHERE id = 4;'+
                                'delete from porders;' +
                              'delete from sorders;' +
                              'UPDATE materials SET inventory = 1 where id = 1;UPDATE materials SET inventory = 0 where id = 3;UPDATE materials SET inventory = 0 where id = 2;');


  updateGrids();

end;


//******* Página de Estatística

procedure TForm2.Timer1Timer(Sender: TObject);
begin

     AnaliseDadosClick(Self);    // Timer vai ativar botão Refresh2 para atualizar estatísticas

end;

procedure TForm2.AnaliseDadosClick(Sender: TObject);
var

  recordNumber           : integer;
  recordNumber2          : integer;
  recordNumber3          : integer;
  recordNumber4          : integer;

  numberLateDeliveriesBB : integer = 0;
  numberLateDeliveriesBG : integer = 0;
  numberLateDeliveriesLB : integer = 0;
  numberLateDeliveriesLG : integer = 0;

  sumYValues             : double = 0;

  countOrders            : integer = 0;
  countProducts          : integer = 0;
  profit                 : integer = 0;

  countOrdersDigicert    : integer = 0;
  countOrdersArxa        : integer = 0;
  countOrdersTexpress    : integer = 0;
  countOrdersTotally     : integer = 0;

begin

  ListChartSourceLateDeliveriesBB.DataPoints.Delete(5);
  ListChartSourceLateDeliveriesBG.DataPoints.Delete(5);
  ListChartSourceLateDeliveriesLB.DataPoints.Delete(5);
  ListChartSourceLateDeliveriesLG.DataPoints.Delete(5);

  (*mmAvgLateBB.Clear;
  mmAvgLateBG.Clear;
  mmAvgLateLB.Clear;
  mmAvgLateLG.Clear;*)




  //Atualizar ChartLateDeliveries com o nº de entregas para a semana atual
  for recordNumber := 1 to SQLCordersData.RecordCount do
  begin

      SQLCordersData.RecNo := recordNumber;

      if  (SQLCordersData.FieldByName('corder_week_delivered').AsInteger > SQLCordersData.FieldByName('corder_week_planned').AsInteger) then

      begin

          if SQLCordersData.FieldByName('product_id').AsInteger = 4 then
          begin
               numberLateDeliveriesBB := numberLateDeliveriesBB + 1;
          end
          else if SQLCordersData.FieldByName('product_id').AsInteger = 5 then
          begin
               numberLateDeliveriesBG := numberLateDeliveriesBG + 1;
          end
          else if SQLCordersData.FieldByName('product_id').AsInteger = 7 then
          begin
               numberLateDeliveriesLB := numberLateDeliveriesLB + 1;
          end
          else if SQLCordersData.FieldByName('product_id').AsInteger = 8 then
          begin
               numberLateDeliveriesLG := numberLateDeliveriesLG + 1;
          end;

      end;

  end;

  ListChartSourceLateDeliveriesBB.Add(6, numberLateDeliveriesBB);
  ListChartSourceLateDeliveriesBG.Add(6, numberLateDeliveriesBG);
  ListChartSourceLateDeliveriesLB.Add(6, numberLateDeliveriesLB);
  ListChartSourceLateDeliveriesLG.Add(6, numberLateDeliveriesLG);

  (*ListChartSourceLateDeliveriesBB.Add(numberLateDeliveriesBB, 6);
  ListChartSourceLateDeliveriesBG.Add(numberLateDeliveriesBG, 6);
  ListChartSourceLateDeliveriesLB.Add(numberLateDeliveriesLB, 6);
  ListChartSourceLateDeliveriesLG.Add(numberLateDeliveriesLG, 6);*)


  //Atualizar nº médio de entregas atrasadas na memo
  for recordNumber := 0 to ListChartSourceLateDeliveriesBB.Count -1 do
  begin

       sumYValues :=  sumYValues + ChartLateDeliveriesLineSeriesBB.GetYValue(recordNumber);
  end;

  //mmAvgLateBB.Text := FormatFloat('0.00', sumYValues/ListChartSourceLateDeliveriesBB.Count);

  ListChartSourceLatenessProducts.Add(1,sumYValues/ListChartSourceLateDeliveriesBB.Count);

  for recordNumber := 0 to ListChartSourceLateDeliveriesBG.Count -1 do
  begin

       sumYValues :=  sumYValues + ChartLateDeliveriesLineSeriesBG.GetYValue(recordNumber);
  end;

  //mmAvgLateBG.Text := FormatFloat('0.00', sumYValues/ListChartSourceLateDeliveriesBG.Count);

  ListChartSourceLatenessProducts.Add(2,sumYValues/ListChartSourceLateDeliveriesBG.Count, 'Green Base');


  for recordNumber := 0 to ListChartSourceLateDeliveriesLB.Count -1 do
  begin

       sumYValues :=  sumYValues + ChartLateDeliveriesLineSeriesLB.GetYValue(recordNumber);
  end;

  //mmAvgLateLB.Text := FormatFloat('0.00', sumYValues/ListChartSourceLateDeliveriesLB.Count);

  ListChartSourceLatenessProducts.Add(3,sumYValues/ListChartSourceLateDeliveriesLB.Count, 'Blue Lid');


  for recordNumber := 0 to ListChartSourceLateDeliveriesLG.Count -1 do
  begin

       sumYValues :=  sumYValues + ChartLateDeliveriesLineSeriesLG.GetYValue(recordNumber);
  end;

  //mmAvgLateLG.Text := FormatFloat('0.00', sumYValues/ListChartSourceLateDeliveriesLG.Count);

  ListChartSourceLatenessProducts.Add(4,sumYValues/ListChartSourceLateDeliveriesLG.Count, 'Green Lid');


  //Atualizar nº ordens por cliente
   for recordNumber := 1 to SQLCordersData.RecordCount do

   begin

      SQLCordersData.RecNo := recordNumber;


      if SQLCordersData.FieldByName('customer_id').AsInteger = 1 then
      begin

         countOrdersDigicert := countOrdersDigicert +1;

      end
      else if  SQLCordersData.FieldByName('customer_id').AsInteger = 2 then
      begin
         countOrdersArxa := countOrdersArxa + 1;
      end
      else if  SQLCordersData.FieldByName('customer_id').AsInteger = 3 then
      begin
         countOrdersTexpress := countOrdersTexpress + 1;
      end
      else if  SQLCordersData.FieldByName('customer_id').AsInteger = 4 then
      begin
         countOrdersTotally := countOrdersTotally + 1;
      end;


   end;

   DigicertOrders.Text :=  IntToStr(countOrdersDigicert);
   ArxaOrders.Text :=  IntToStr(countOrdersArxa);
   TexpressOrders.Text :=  IntToStr(countOrdersTexpress);
   TotallyOrders.Text :=  IntToStr(countOrdersTotally);




  // Atualizar ChartCorders com corders
  for recordNumber2 := 1 to SQLCustomersData.RecordCount do
  begin

       countOrders := 0;
       SQLCustomersData.RecNo := recordNumber2;

       for recordNumber := 1 to SQLCordersData.RecordCount do
       begin

          SQLCordersData.RecNo := recordNumber;

          if SQLCordersData.FieldByName('customer_id').AsInteger = SQLCustomersData.FieldByName('customer_id').AsInteger then
          begin

             countOrders := countOrders +1;

          end;

       end;

       ListChartSourceCorders.Add(recordNumber2, countOrders, SQLCustomersData.FieldByName('customer_name').AsString);

  end;

  //Atualizar ChartCorders com produtos
  for recordNumber4 := 1 to SQLProductsData.RecordCount do
  begin

       countProducts := 0;
       SQLProductsData.RecNo := recordNumber4;

       for recordNumber := 1 to SQLCordersData.RecordCount do
       begin

          SQLCordersData.RecNo := recordNumber;

          if SQLCordersData.FieldByName('product_id').AsInteger = SQLProductsData.FieldByName('product_id').AsInteger then
          begin

             countProducts := countProducts +1;

          end;

       end;

       ListChartSourceProducts.Add(recordNumber4, countProducts, SQLProductsData.FieldByName('product_name').AsString);

  end;




  // Atualizar ChartProfitCustomer com lucro das corders
  for recordNumber2 := 1 to SQLCustomersData.RecordCount do
  begin

       profit := 0;
       SQLCustomersData.RecNo := recordNumber2;

       for recordNumber := 1 to SQLCordersData.RecordCount do
       begin

          SQLCordersData.RecNo := recordNumber;

          if SQLCordersData.FieldByName('customer_id').AsInteger = SQLCustomersData.FieldByName('customer_id').AsInteger then
          begin

             for recordNumber3 := 1 to SQLProductsData.RecordCount do
             begin

                  SQLProductsData.RecNo := recordNumber3;

                  if SQLProductsData.FieldByName('product_id').AsInteger = SQLCordersData.FieldByName('product_id').AsInteger then
                  begin

                       profit := profit + (SQLCordersData.FieldByName('corder_qt').AsInteger *
                                (SQLProductsData.FieldByName('product_price').AsInteger - SQLMaterialsData.FieldByName('material_price').AsInteger));

                  end;

             end;

          end;

       end;

       ListChartSourceProfitCustomer.Add(recordNumber2, profit, SQLCustomersData.FieldByName('customer_name').AsString);

  end;






end;

procedure TForm2.AnaliseDados2Click(Sender: TObject);
var
  recordNumber : integer;
begin

  mmMaxCorders.Clear;
  mmMaxCustomerProfit.Clear;

  mmNoCustomers.Clear;
  mmNoProducts.Clear;
  mmNoSuppliers.Clear;
  mmNoCorders.Clear;


  // Atualizar clientes com o maior nº de ordens na memo
  for recordNumber := 1 to SQLCustomersData.RecordCount do
  begin

       SQLCustomersData.RecNo :=  recordNumber;

       if SQLCustomersData.FieldByName('customer_id').AsString = FloatToStr(ListChartSourceCorders.XOfMax()) then
       begin

          mmMaxCorders.Text := SQLCustomersData.FieldByName('customer_name').AsString;

       end;

  end;

  //Atualizar cliente que deu mais lucro na memo
  for recordNumber := 1 to SQLCustomersData.RecordCount do
  begin

       SQLCustomersData.RecNo :=  recordNumber;

       if SQLCustomersData.FieldByName('customer_id').AsString = FloatToStr(ListChartSourceCorders.XOfMax()) then
       begin

          mmMaxCustomerProfit.Text := SQLCustomersData.FieldByName('customer_name').AsString;

       end;

  end;

  //Atualizar nº clientes na memo
  mmNoCustomers.Text := IntToStr(SQLCustomersData.RecordCount);

  //Atualizar nº produtos na memo
  mmNoProducts.Text  := IntToStr(SQLProductsData.RecordCount);

  //Atualizar nº fornecedores na memo
  mmNoSuppliers.Text := IntToStr(SQLSuppliers.RecordCount);

  //Atualizar nº corders na memo
  mmNoCorders.Text   := IntToStr(SQLCordersData.RecordCount);
  //Incrementar nºordens expedição

  numExpOrderParts:=0 ;
  numProOrderParts := 0;
  numSupOrderParts := 0;


  for recordNumber := 1 to SQLEordersData.RecordCount do
  begin

       SQLEordersData.RecNo :=  recordNumber;


       if SQLEordersData.FieldByName('eorder_status').AsString = 'done      ' then
       begin
          numExpOrderParts := numExpOrderParts + SQLEordersData.FieldByName('eorder_qt').AsInteger;

       end;

  end;

  //Incrementar nºordens produção

  for recordNumber := 1 to SQLPordersData.RecordCount do
  begin

       SQLPordersData.RecNo :=  recordNumber;

       if SQLPordersData.FieldByName('porder_status').AsString = 'done      ' then
       begin

          numProOrderParts  := numProOrderParts + SQLPordersData.FieldByName('porder_qtp').AsInteger;

       end;

  end;

  //Incrementar nºordens produção

  for recordNumber := 1 to SQLSordersData.RecordCount do
  begin

       SQLSordersData.RecNo :=  recordNumber;

       if SQLSordersData.FieldByName('sorder_status').AsString = 'done      ' then
       begin

          numSupOrderParts   := numSupOrderParts + SQLSordersData.FieldByName('sorder_qt').AsInteger;

       end;

  end;

  inb1 := 0;
  inb2 := 0;
  inb3 := 0;
  inb4 := 0;
  inb5 := 0;
  inb6 := 0;
  inb7 := 0;
  inb8 := 0;
  inb9 := 0;

  for recordNumber := 1 to SQLSordersData.RecordCount do
  begin
    SQLSordersData.RecNo := recordNumber;

    if SQLSordersData.FieldByName('sorder_status').AsString = 'done      ' then
    begin
      if SQLSordersData.FieldByName('material_id').AsInteger = 1 then
      begin
        inb1 := inb1 + SQLSordersData.FieldByName('sorder_qt').AsInteger;
      end
      else if SQLSordersData.FieldByName('material_id').AsInteger = 2 then
      begin
        inb2 := inb2 + SQLSordersData.FieldByName('sorder_qt').AsInteger;
      end
      else if SQLSordersData.FieldByName('material_id').AsInteger = 3 then
      begin
        inb3 := inb3 + SQLSordersData.FieldByName('sorder_qt').AsInteger;
      end;
    end;
  end;


  //Atualizar nº peças expedidas
  CountExpTotal.Text := IntToStr(numExpOrderParts);

  //Atualizar nº peças produzidas
  CountProdTotal.Text  := IntToStr(numProOrderParts);

  //Atualizar nº peças inbound
  CountSupTotal.Text := IntToStr(numSupOrderParts);
  // fornecimentos totais
  inbo1.Text := IntToStr(inb1);
  inbo2.Text := IntToStr(inb2);
  inbo3.Text := IntToStr(inb3);

  for recordNumber := 1 to SQLEordersData.RecordCount do
  begin
    SQLEordersData.RecNo := recordNumber;

    if SQLCordersData.FieldByName('corder_status').AsString = 'done      ' then
    begin
      if SQLCordersData.FieldByName('product_id').AsString = '4' then
      begin
        inb4 := inb4 + SQLEordersData.FieldByName('eorder_qt').AsInteger;
      end
      else if SQLCordersData.FieldByName('product_id').AsString = '5' then
      begin
        inb5 := inb5 + SQLEordersData.FieldByName('eorder_qt').AsInteger;
      end
      else if SQLCordersData.FieldByName('product_id').AsString = '6' then
      begin
        inb6 := inb6 + SQLEordersData.FieldByName('eorder_qt').AsInteger;
      end
      else if SQLCordersData.FieldByName('product_id').AsString = '7' then
      begin
        inb7 := inb7 + SQLEordersData.FieldByName('eorder_qt').AsInteger;
      end
      else if SQLCordersData.FieldByName('product_id').AsString = '8' then
      begin
        inb8 := inb8 + SQLEordersData.FieldByName('eorder_qt').AsInteger;
      end
      else if SQLCordersData.FieldByName('product_id').AsString = '9' then
      begin
        inb9 := inb9 + SQLEordersData.FieldByName('eorder_qt').AsInteger;
      end;
    end;
  end;

  // Update text fields for inb4 to inb9
  inbo4.Text := IntToStr(inb4);
  inbo5.Text := IntToStr(inb5);
  inbo6.Text := IntToStr(inb6);
  inbo7.Text := IntToStr(inb7);
  inbo8.Text := IntToStr(inb8);
  inbo9.Text := IntToStr(inb9);


end;


//******* Conecção forms

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    Application.MainForm.Show;
end;

procedure TForm2.btBackClick(Sender: TObject);
begin
  Close;
end;
end.

