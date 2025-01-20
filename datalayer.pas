unit DataLayer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, Unit1;

//inserir cliente
procedure insertCustomer(customerName : string);
//apagar cliente
procedure deleteCustomer(customerId: integer);
//atualizar cliente
procedure updateCustomer(customerId : integer; customerName : string);


//inserir produto
procedure insertProduct(productName: string; productInventory: integer; materialId : integer; productPrice: extended);
//apagar produto
procedure deleteProduct(productId: integer);
//atualizar produto
procedure updateProduct(productId: integer; productName: string; productInventory: integer; materialId : integer; productPrice: extended);

//atualizar material
procedure updateMaterials(materialId: integer; materialName: string; materialInventory: integer; materialSStock: integer; materialPrice: extended);

//inserir corder
procedure insertCorder(customerId: integer; productId: integer; corderQt: integer; corderWeekp : integer);
//apagar corder
procedure deleteCorder(corderId: integer);
//atualizar corder
procedure updateCorder(corderId: integer; customerId: integer; productId: integer; corderQt: integer; corderWeekp : integer; corderStatus: string);
//filtrar corder
procedure filterCorder(selectedCustomerName : string; selectedProductName : string;  selectedStatus : string; selectedQt : integer; selectedWeekp : integer);
//limpar corder filtrada
procedure clearFilterCorder();

//inserir eorder
procedure insertEorder(corderId:integer; corderQt:integer; corderWeekPlanned:integer; corderStatus:string);
//apagar eorder
procedure deleteEorder(eorderId: integer);
//atualizar corder status
procedure updateCordersStatus(corderId:integer; corderStatus:string);
// obter inventário atraves de ProductId
function getInventoryByProductId(productId:integer) : integer;
//Atualizar inventário produto
procedure updateProductInventory(productId:integer; newProductInventory:integer);

//inserir porder
procedure insertPorder(productId: integer; corderQtp:integer; corderWeekPlanned:integer; corderStatus:string);
//obter inventario atraves de MaterialId
function getInventoryByMaterialId(materialId:integer) : integer;
// atualizar inv de material
procedure updateMaterialInventory(materialId:integer; newMaterialInventory:integer);

//inserir sorder
procedure insertSorder(porderId: integer; materialId : integer; supplierId : integer; porderQt : integer; porderWeekPlanned : integer; porderStatus : string);
procedure insertSorderManual(sorderId: integer; materialId : integer; supplierId : integer; sorderQt : integer; sorderWeekPlanned : integer);

//procedure insertSorder2( materialId : integer; supplierId : integer; porderQt : integer; porderWeekPlanned : integer; porderStatus : string);

//outros
procedure execute(query: string);


implementation


//******* Tabela Clientes

procedure insertCustomer(customerName : string);
var
  query  : string;

begin

   query := 'INSERT INTO customers (name)' +
            ' VALUES (''' + customerName + ''')';

   Form2.Debug_Memo.Lines.Add(query);

   execute(query);

end;

procedure deleteCustomer(customerId: integer);
var
   query         : string;

   strCustomerId : string;

begin

   strCustomerId := IntToStr(customerId);

   query         := 'DELETE FROM customers WHERE id = ' +  strCustomerId;

   Form2.Debug_Memo.Lines.Add(query);

   execute(query);

end;

procedure updateCustomer(customerId : integer; customerName : string);
var
  query           : string;

  strCustomerId   : string;

begin

  strCustomerId   := IntToStr(customerId);

  query           := 'UPDATE customers SET' +
                     ' name = ''' + customerName +
                     ''' WHERE id = ' + strCustomerId;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;


//******* Tabela Produtos

procedure insertProduct(productName: string; productInventory: integer; materialId : integer; productPrice: extended);
var
   query                  : string;

   strProductName         : string;
   strProductInventory    : string;
   strMaterialId          : string;
   strProductPrice        : string;

begin

   strProductName        := productName;
   strProductInventory   := IntToStr(productInventory);
   strMaterialId         := IntToStr(materialId);
   strProductPrice       := FloatToStr(productPrice);

   query := 'INSERT INTO products (name, inventory, material_id, price)' +
            ' VALUES (''' + strProductName + ''', ' + strProductInventory + ', ' + strMaterialId + ', ' + strProductPrice + ')';

   Form2.Debug_Memo.Lines.Add(query);

   execute(query);

end;

procedure deleteProduct(productId: integer);
var
  query: string;
  strProductId: string;
begin
  strProductId := IntToStr(productId);

  // Apagar eorders associadas primeiro
  query := 'DELETE FROM eorders WHERE corder_id IN ' +
           '(SELECT corder_id FROM corders WHERE product_id = ' + strProductId + ')';
  execute(query);

  //Apagar corders associadas
  query := 'DELETE FROM corders WHERE product_id = ' + strProductId;
  execute(query);

  //Apagar produto
  query := 'DELETE FROM products WHERE id = ' + strProductId;
  execute(query);
end;

procedure updateProduct(productId: integer; productName: string; productInventory: integer; materialId : integer; productPrice: extended);
var
  query           : string;


  strProductId           : string;
  strProductName         : string;
  strProductInventory    : string;
  strMaterialId          : string;
  strProductPrice        : string;

begin

  strProductId          := IntToStr(productId);
  strProductName        := productName;
  strProductInventory   := IntToStr(productInventory);
  strMaterialId         := IntToStr(materialId);
  strProductPrice       := FloatToStr(productPrice);

  query           := 'UPDATE products SET' +
                     ' name = ''' + strProductName +
                     ''', inventory = ' + strProductInventory +
                     ', material_id = ' + strMaterialId +
                     ', price = ' + strProductPrice +
                     ' WHERE id = ' + strProductId;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;

procedure updateMaterials(materialId: integer; materialName: string; materialInventory: integer; materialSStock: integer; materialPrice: extended);
var
  query           : string;

  strMaterialName         : string;
  strMaterialInventory    : string;
  strMaterialId           : string;
  strMaterialSStock       : string;
  strMaterialPrice        : string;

begin

  strMaterialName        := materialName;
  strMaterialInventory   := IntToStr(materialInventory);
  strMaterialId          := IntToStr(materialId);
  strMaterialSStock      := IntToStr(materialSStock);
  strMaterialPrice       := FloatToStr(materialPrice);

  query           := 'UPDATE materials SET' +
                     ' name = ''' + strMaterialName +
                     ''', inventory = ' + strMaterialInventory +
                     ', sstock = ' + strMaterialSStock +
                     ', price = ' + strMaterialPrice +
                     ' WHERE id = ' + strMaterialId;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;


//******* Customer orders tabela corder

procedure insertCorder(customerId: integer; productId: integer; corderQt: integer; corderWeekp : integer);
var
  query           : string;

  strCustomerId   : string;
  strProductId    : string;
  strCorderQt     : string;
  strCorderWeekp  : string;

begin

   strCustomerId  := IntToStr(customerId);
   strProductId   := IntToStr(productId);
   strCorderQt    := IntToStr(corderQt);
   strCorderWeekp := IntToStr(corderWeekp);

   query          := 'INSERT INTO corders (customer_id, product_id, qt, weekp, status)' +
                     ' VALUES (' + strCustomerId + ', ' + strProductId + ', ' + strCorderQt + ', ' + strCorderWeekp + ', ''accepted'')';

   Form2.Debug_Memo.Lines.Add(query);

   execute(query);

end;

procedure deleteCorder(corderId: integer);
var
   query       : string;

   strCorderId : string;

begin

   strCorderId := IntToStr(corderId);

   query       := 'DELETE FROM corders WHERE id = ' +  strCorderId;

   Form2.Debug_Memo.Lines.Add(query);

   execute(query);

end;

procedure updateCorder(corderId: integer; customerId: integer; productId: integer; corderQt: integer; corderWeekp : integer; corderstatus: string);
var
  query           : string;

  strCustomerId   : string;
  strProductId    : string;
  strCorderId     : string;
  strCorderQt     : string;
  strCorderWeekp  : string;
  strCorderStatus : string;

begin

  strCustomerId   := IntToStr(customerId);
  strProductId    := IntToStr(productId);
  strCorderId     := IntToStr(corderId);
  strCorderQt     := IntToStr(corderQt);
  strCorderWeekp  := IntToStr(corderWeekp);
  strCorderStatus  := corderStatus;

  query           := 'UPDATE corders SET' +
                     ' customer_id = ' + strCustomerId +
                     ', product_id = ' + strProductId +
                     ', qt = ' + strCorderQt +
                     ', weekp = ' + strCorderWeekp +
                     ', status = ''' + strCorderStatus + '''' +
                     ' WHERE id = ' + strCorderId;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;

procedure filterCorder(selectedCustomerName : string; selectedProductName : string; selectedStatus : string; selectedQt : integer; selectedWeekp : integer);
var
  query               : string;

begin

  // Construir o query base
  query       := 'SELECT corders.id AS corder_id, ' +
                 'customers.id AS customer_id, ' +
                 'customers.name AS customer_name, ' +
                 'products.id AS product_id, ' +
                 'products.name AS product_name, ' +
                 'corders.qt AS corder_qt, ' +
                 'corders.status AS corder_status, ' +
                 'corders.weekp AS corder_week_planned, ' +
                 'corders.weekd AS corder_week_delivered ' +
                 'FROM corders ' +
                 'JOIN customers ON corders.customer_id = customers.id ' +
                 'JOIN products ON corders.product_id = products.id ';

  // Adicionar Where clause e filtrar condições com base nas opções selecionadas
     query := query + 'WHERE 1 = 1 ';  // Condição Placeholder para começar a WHERE clause

  if selectedCustomerName <> '' then
     query := query + 'AND customers.name = ' + QuotedStr(selectedCustomerName) + ' ';

  if selectedProductName <> '' then
     query := query + 'AND products.name = ' + QuotedStr(selectedProductName) + ' ';

  if selectedStatus <> '' then
     query := query + 'AND corders.status = ' + QuotedStr(selectedStatus) + ' ';

  if selectedQt <> -1 then
     query := query + 'AND corders.qt = ' + IntToStr(selectedQt) + ' ';

  if selectedWeekp <> -1 then
     query := query + 'AND corders.weekp = ' + IntToStr(selectedWeekp) + ' ';

  //Adiconar a ORDER
  query := query + 'ORDER BY corders.weekp ASC, corders.id ASC';

  Form2.Debug_Memo.Lines.Add(query);

  // Atribuir a query à propriedade SQL do SQLCorders
  Form2.SQLCorders.SQL.Text := query;

end;

procedure clearFilterCorder();
var
  query       : string;

begin
  query       := 'SELECT corders.id AS corder_id, ' +
                 'customers.id AS customer_id, ' +
                 'customers.name AS customer_name, ' +
                 'products.id AS product_id, ' +
                 'products.name AS product_name, ' +
                 'corders.qt AS corder_qt, ' +
                 'corders.status AS corder_status, ' +
                 'corders.weekp AS corder_week_planned, ' +
                 'corders.weekd AS corder_week_delivered ' +
                 'FROM corders ' +
                 'JOIN customers ON corders.customer_id = customers.id ' +
                 'JOIN products ON corders.product_id = products.id ' +
                 'ORDER BY corders.weekp ASC, corders.id ASC';

  Form2.SQLCorders.SQL.Text := query;

end;

// Atualizar Corders Status
procedure updateCordersStatus(corderId:integer; corderStatus:string);
var
  strCorderId      : string;
  strCorderStatus  : string;

  query            : string;

begin

  strCorderId      := IntToStr(corderId);
  strCorderStatus  := corderStatus;

  query            := 'UPDATE corders'   +
                      ' SET status = ''' + strCorderStatus + '''' +
                      ' WHERE id = '     + strCorderId ;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;


//*********  Ordens Expedição (tabela eorders)

//Inserir Eorder
procedure insertEorder(corderId:integer; corderQt:integer; corderWeekPlanned:integer; corderStatus:string);
var
  strCorderId          : string;
  strCorderQt          : string;
  strCorderWeekPlanned : string;
  strCorderStatus      : string;

  query                : string;

begin

  strCorderId          := IntToStr(corderId);
  strCorderQt          := IntToStr(corderQt);
  strCorderWeekPlanned := IntToStr(corderWeekPlanned);
  strCorderStatus      := corderStatus;

  query                := 'INSERT INTO eorders (corder_id, qt, weekp, status)' +
                          ' VALUES(' + strCorderId + ', ' + strCorderQt + ', ' +  strCorderWeekPlanned + ', ''' + strCorderStatus + ''')';

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;

procedure deleteEorder(eorderId: integer);
var
   query       : string;

   strEorderId : string;

begin

   strEorderId := IntToStr(eorderId);

   query       := 'DELETE FROM eorders WHERE id = ' +  strEorderId;

   Form2.Debug_Memo.Lines.Add(query);

   execute(query);

end;


//*********  Produtos (tabela produtos)

//obter inventario atraves de productId
function getInventoryByProductId(productId:integer) : integer;
var
  recordNumber : integer;

begin

   for recordNumber :=1 to Form2.SQLProducts.RecordCount do
   begin

      Form2.SQLProducts.RecNo := recordNumber;

      if Form2.SQLProducts.FieldByName('product_id').AsInteger = productId then
         getInventoryByProductId := Form2.SQLProducts.FieldByName('product_inventory').AsInteger;

   end;
end;

//atualizar inventário de produto
procedure updateProductInventory(productId:integer; newProductInventory:integer);
var
  strProductId           : string;
  strNewProductInventory : string;

  query                  : string;

begin

  strProductId           := IntToStr(productId);
  strNewProductInventory := IntToStr(newProductInventory);

  query                  := 'UPDATE products'   +
                            ' SET inventory = ' + strNewProductInventory +
                            ' WHERE id = '      + strProductId ;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;


//********* Ordens de Produção (tabela porders)

//inserir Porder
procedure insertPorder(productId: integer; corderQtp:integer; corderWeekPlanned:integer; corderStatus:string);
var
  strProductId          : string;
  strCorderQtp          : string;
  strCorderWeekPlanned  : string;
  strCorderStatus       : string;

  query                 : string;

begin

  strProductId          :=IntToStr(productId);
  strCorderQtp          := IntToStr(corderQtp);
  strCorderWeekPlanned  := IntToStr(corderWeekPlanned);
  strCorderStatus       := corderStatus;

  query                 := 'INSERT INTO porders (product_id, qtp, weekp, status)' +
                           ' VALUES(' + strProductId + ', ' + strCorderQtp + ', '
                           + strCorderWeekPlanned + ', ''' + strCorderStatus + ''')';

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;


//*********  Materiais (tabela materiais)

//obter inventário atraves de material Id
function getInventoryByMaterialId(materialId:integer) : integer;
var
  recordNumber : integer;

begin

   for recordNumber :=1 to Form2.SQLMaterials.RecordCount do
   begin

      Form2.SQLMaterials.RecNo := recordNumber;

      if Form2.SQLMaterials.FieldByName('material_id').AsInteger = materialId then
         getInventoryByMaterialId := Form2.SQLMaterials.FieldByName('material_inventory').AsInteger;

   end;
end;

// atualizar inv de material
procedure updateMaterialInventory(materialId:integer; newMaterialInventory:integer);
var
  strMaterialId           : string;
  strNewMaterialInventory : string;

  query                   : string;

begin

  strMaterialId           := IntToStr(materialId);
  strNewMaterialInventory := IntToStr(newMaterialInventory);

  query                   := 'UPDATE materials'   +
                             ' SET inventory = ' + strNewMaterialInventory +
                             ' WHERE id = '      + strMaterialId ;

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;


//*********  Ordens Fornecimento(tabela sorders)

//inserir Sorders
procedure insertSorder(porderId: integer; materialId : integer; supplierId : integer; porderQt : integer; porderWeekPlanned : integer; porderStatus : string);
var
  strPorderId          : string;
  strMaterialId        : string;
  strSupplierId        : string;
  strPorderQt          : string;
  strPorderWeekPlanned : string;
  strPorderStatus      : string;

  query                : string;

begin

  strPorderId          := IntToStr(porderId);
  strMaterialId        := IntToStr(materialId);
  strSupplierId        := IntToStr(supplierId);
  strPorderQt          := IntToStr(porderQt);
  strPorderWeekPlanned := IntToStr(porderWeekPlanned);
  strPorderStatus      := porderStatus;

  query                := 'INSERT INTO sorders (id, material_id, supplier_id, qt, weekp, status)' +
                          ' VALUES(' + strPorderId + ', ' + strMaterialId + ', ' + strSupplierId +
                          ', ' + strPorderQt + ', ' +  strPorderWeekPlanned + ', ''' + strPorderStatus + ''')';

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;

//inserir Sorder Manual
procedure insertSorderManual(sorderId: integer; materialId : integer; supplierId : integer; sorderQt : integer; sorderWeekPlanned : integer);
var
  strSorderId          : string;
  strMaterialId        : string;
  strSupplierId        : string;
  strSorderQt          : string;
  strSorderWeekPlanned : string;
  strSorderWeekD       : string;
  strSorderStatus      : string;

  initialMaterialInventory : integer;
  newMaterialInventory     : integer;

  query                : string;

begin

  strSorderId          := IntToStr(sorderId);
  strMaterialId        := IntToStr(materialId);
  strSupplierId        := IntToStr(supplierId);
  strSorderQt          := IntToStr(sorderQt);
  strSorderWeekPlanned := IntToStr(sorderWeekPlanned);
  strSorderWeekD       := IntToStr(sorderWeekPlanned);
  strSorderStatus      := 'done';


  query                := 'INSERT INTO sorders (id, material_id, supplier_id, qt, weekp, weekd, status)' +
                          ' VALUES(' + strSorderId + ', ' + strMaterialId + ', ' + strSupplierId +
                          ', ' + strSorderQt + ', ' +  strSorderWeekPlanned + ', ' + strSorderWeekD + ', ''' + strSorderStatus + ''')';

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

  // Atualizar inventároo de material
  initialMaterialInventory := getInventoryByMaterialId(materialId);
  newMaterialInventory := initialMaterialInventory + sorderQt;
  updateMaterialInventory(materialId, newMaterialInventory);

end;

procedure insertSorder2( materialId : integer; supplierId : integer; porderQt : integer; porderWeekPlanned : integer; porderStatus : string);
var
  strPorderId          : string;
  strMaterialId        : string;
  strSupplierId        : string;
  strPorderQt          : string;
  strPorderWeekPlanned : string;
  strPorderStatus      : string;

  query                : string;

begin

  strMaterialId        := IntToStr(materialId);
  strSupplierId        := IntToStr(supplierId);
  strPorderQt          := IntToStr(porderQt);
  strPorderWeekPlanned := IntToStr(porderWeekPlanned);
  strPorderStatus      := porderStatus;

  query                := 'INSERT INTO sorders ( material_id, supplier_id, qt, weekp, status)' +
                          ' VALUES( ' + strMaterialId + ', ' + strSupplierId +
                          ', ' + strPorderQt + ', ' +  strPorderWeekPlanned + ', ''' + strPorderStatus + ''')';

  Form2.Debug_Memo.Lines.Add(query);

  execute(query);

end;

//*********  Executar Query

procedure execute(query: string);
begin

   Form2.PQConnection1.ExecuteDirect(query);

end;

end.

