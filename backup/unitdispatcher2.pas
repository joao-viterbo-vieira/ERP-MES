unit unitdispatcher;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, PQConnection, SQLDB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Menus, ComCtrls, Grids, comUnit;

type
  //***************************************
  // Enumerated: defines the type of the TTask
  TTask_Type  = (Type_Expedition = 1, Type_Delivery, Type_Production, Type_Trash);

  TProduction_Order = record
    part_type           : Integer;    // Part type { 0, ... 9}
    part_numbers        : Integer;    // Number of parts to be performed
    order_type          : TTask_Type;
  end;

  TArray_Production_Order = array of TProduction_Order;
  //***************************************



  //***************************************
  // Dispatcher Execution
  // Enumerated: defines all stages of TTasks
  TStage      = (To_Be_Started = 1, GetPart, SetPosition, Unload, TO_AR_OUT, Clear_Pos_AR, TO_AR_IN , Load, Insert_Pos_AR, Finished);

  // Data structure for holding one Task (OE, OD, OP)
  TTask = record
   task_type           : TTask_Type; // type
   current_operation   : TStage;     // the stage that is currently activ.
   part_type           : Integer;    // Part type { 0, ... 9}
   part_position_AR    : Integer;    // Part Position in AR (if needed)
   part_destination    : Integer;    // Part destination
  end;

  TArray_Task = array of TTask;      // NOTE: this "type" will originate a variable to hold the output from the scheduling ("sequenciador").
  //***************************************



  //***************************************
  // Availability of the resources in the shopfloor:
  TResources = record
   AR_free      : Boolean;    // true (free) or false (busy)
   AR_In_Part   : integer;    // Com uma peça do tipo P={0..9} (0=sem peça)
   AR_Out_Part  : integer;    // Com uma peça do tipo P={0..9} (0=sem peça)
   Robot_1_Part : integer;    // Com uma peça do tipo P={0..9} (0=sem peça)
   Robot_2_Part : integer;    // Com uma peça do tipo P={0..9} (0=sem peça)
   Inbound_free : Boolean;    // true (free) or false (busy)
  end;
  //***************************************

  { TFormDispatcher }
  TFormDispatcher = class(TForm)
    BStart: TButton;
    BExecute: TButton;
    BInitiatilize: TButton;
    btBack: TButton;
    Button1: TButton;
    Ed_BA_EXP: TEdit;
    Ed_BA_PROD: TEdit;
    Ed_MPA_IN: TEdit;
    Ed_BV_EXP: TEdit;
    Ed_BV_PROD: TEdit;
    Ed_MPA_STO: TEdit;
    Ed_MPV_IN: TEdit;
    Ed_BA_STO: TEdit;
    Ed_TA_PROD: TEdit;
    Ed_TA_STO: TEdit;
    Ed_MPV_STO: TEdit;
    Ed_BV_STO: TEdit;
    Ed_TV_PROD: TEdit;
    Ed_TV_STO: TEdit;
    Ed_TA_EXP: TEdit;
    Ed_TV_EXP: TEdit;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label12: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label37: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Memo1: TMemo;
    Memo_BA_PROD: TMemo;
    Memo_BA_EXP: TMemo;
    Memo_BA_PROC: TMemo;
    Memo_BA_STO: TMemo;
    Memo_BV_PROC: TMemo;
    Memo_MPA_IN: TMemo;
    Memo_BV_PROD: TMemo;
    Memo_BV_EXP: TMemo;
    Memo_BV_STO: TMemo;
    Memo_MPA_STO: TMemo;
    Memo_R1: TMemo;
    Memo_MPV_IN: TMemo;
    Memo_MPV_STO: TMemo;
    Memo_R2: TMemo;
    Memo_TA_PROD: TMemo;
    Memo_TA_EXP: TMemo;
    Memo_TA_PROC: TMemo;
    Memo_TA_STO: TMemo;
    Memo_TV_PROD: TMemo;
    Memo_TV_EXP: TMemo;
    Memo_TV_PROC: TMemo;
    Memo_TV_STO: TMemo;
    PageControl1: TPageControl;
    PQConnection1: TPQConnection;
    Shape1: TShape;
    SQLEorders: TSQLQuery;
    SQLPorders: TSQLQuery;
    SQLProducts: TSQLQuery;
    SQLMaterials: TSQLQuery;
    SQLSorders: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure BExecuteClick(Sender: TObject);
    procedure BInitiatilizeClick(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure btBackClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private

  public
    procedure Dispatcher(var tasks:TArray_Task; var idx : integer; shopfloor: TResources );
    procedure Execute_Production_Order(var task:TTask; shopfloor: TResources );
    procedure Execute_Expedition_Order(var task:TTask; shopfloor: TResources );
    procedure Execute_Delivery_Order(var task:TTask; shopfloor: TResources );
    function GET_AR_Position (Part : integer; var Warehouse : array of integer): integer;
    procedure SET_AR_Position (idx : integer; Part : integer; var Warehouse : array of integer);

  end;



(* GLOBAL VARIABLES *)
var
  FormDispatcher: TFormDispatcher;

  // Production orders obtained by the ERP (using the SQL Query)
  Production_Orders_1 : TArray_Production_Order;
  Production_Orders_2 : TArray_Production_Order;
  Production_Orders_3 : TArray_Production_Order;
  Production_Orders_4 : TArray_Production_Order;
  Production_Orders_5 : TArray_Production_Order;

  // Availability of resources (needs to be updated over time)
  ShopResources : TResources;

  // Tasks that need to be concluded by the MES (expedition, delivery, production and trash).
  ShopTasks_1     : TArray_Task;
  ShopTasks_2     : TArray_Task;
  ShopTasks_3     : TArray_Task;
  ShopTasks_4     : TArray_Task;
  ShopTasks_5     : TArray_Task;

  // Index of the task (from the array "ShopTasks") that is being executed.
  idx_Task_Executing_1 : integer;
  idx_Task_Executing_2 : integer;
  idx_Task_Executing_3 : integer;
  idx_Task_Executing_4 : integer;
  idx_Task_Executing_5 : integer;

  // Status of each cell in the warehouse.
  AR_Parts           : array of integer;         //warehouse parts in each position

  quantExpBA : integer = 0;
  quantExpBV : integer = 0;
  quantExpTA : integer = 0;
  quantExpTV : integer = 0;

  quantProdBA : integer = 0;
  quantProdBV : integer = 0;
  quantProdTA : integer = 0;
  quantProdTV : integer = 0;


  quantInMPA : integer = 0;
  quantInMPV : integer = 0;

implementation

{$R *.lfm}





{ Procedure that checks the status of the resources available on the shop floor }
procedure UpdateResources(var shopfloor: TResources);
var
    resp : array[1..8] of integer;
begin
  {'FactoryIO state',
   'Inbound state',
   'Warehouse_state',
   'Warehouse input conveyor part',
   'Warehouse output conveyor part',
   'Cell 1 part',
   'Cell 2 part',
   'Pick & Place part'
   }
  resp:=M_Get_Factory_Status();

  with shopfloor do
  begin
    Inbound_free := Int(resp[2]) = 1;
    AR_free      := Int(resp[3]) = 1;
    AR_In_Part   := LongInt(resp[4]);
    AR_Out_Part  := LongInt(resp[5]);
    Robot_1_Part := LongInt(resp[6]);
    Robot_2_Part := LongInt(resp[7]);
  end;
end;


{ Procedure that received TArray_Production_Order and converts to TArray_Task
-> INPUT: TArray_Production_Order
-> OUTPUT: TArray_Task
}
procedure SimpleScheduler(var orders: TArray_Production_Order; var tasks:TArray_Task );
var
    current_task : TTask;
    idx_order : integer;
    numb_tasks_total : integer = 0;       // total number of tasks created in "tasks"
    numb_same_task   : integer = 0;

begin
  for idx_order:= 0 to Length(orders)-1 do
  begin
      with current_task do
      begin
        numb_same_task    := 0;

        task_type         := orders[idx_order].order_type;
        part_type         := orders[idx_order].part_type;
        current_operation := To_Be_Started;

        part_position_AR  := -1;  // to be defined later.

        if( part_type < 7 )then
        begin
             part_destination  := 1;     // if bases (Exit 1 or Cell 1)
        end else
        begin
            part_destination  := 2;     // if lids (Exit 2 or Cell 2)
        end;

        //Create  orders[idx_order].part_numbers of the same TTask for Dispatcher.
        numb_tasks_total :=  Length(tasks);
        SetLength(tasks,  numb_tasks_total + orders[idx_order].part_numbers);
        for numb_same_task := 0 to orders[idx_order].part_numbers-1 do
        begin
            tasks[numb_tasks_total+numb_same_task] := current_task;
        end;
      end;
  end;

end;


// Query DB -> Scheduling -> Connect PLC for Dispatching
procedure TFormDispatcher.BStartClick(Sender: TObject);
var
    result : integer;
    production_order : TProduction_Order;
    i1 : integer = 0;
    i2 : integer = 0;                //one i for each Production_Order
    i3 : integer = 0;
    i4 : integer = 0;
    i5 : integer = 0;
    num_orders_inbound_A : integer = 0;
    num_orders_inbound_V : integer = 0;
    num_orders_exp : integer;
    aux : integer;
begin

  //from DB

  //calculate number of inbound orders
  num_orders_inbound_A := strtointdef(Ed_MPA_IN.Text, 0);
  num_orders_inbound_V := strtointdef(Ed_MPV_IN.Text, 0);

  //calculate number of expedition orders
  num_orders_exp := strtointdef(Ed_BA_EXP.Text, 0) + strtointdef(Ed_BV_EXP.Text, 0) + strtointdef(Ed_TA_EXP.Text, 0) + strtointdef(Ed_TV_EXP.Text, 0);

  //calculate total number of orders except production orders, including restock of MP
  aux := num_orders_inbound_A + num_orders_inbound_V + num_orders_exp + strtointdef(Ed_MPA_STO.Text, 0) + strtointdef(Ed_MPV_STO.Text, 0);
  SetLength(Production_Orders_1, aux);

  //calculate number of blue base production orders
  SetLength(Production_Orders_2, strtointdef(Ed_BA_PROD.Text, 0));

  //calculate number of green base production orders
  SetLength(Production_Orders_3, strtointdef(Ed_BV_PROD.Text, 0));

  //calculate number of blue lid production orders
  SetLength(Production_Orders_4, strtointdef(Ed_TA_PROD.Text, 0));

  //calculate number of green lid production orders
  SetLength(Production_Orders_5, strtointdef(Ed_TV_PROD.Text, 0));

  if num_orders_inbound_A > 0 then
  begin
  production_order.order_type  := Type_Delivery ;   //Inbound
  production_order.part_numbers:= num_orders_inbound_A;
  production_order.part_type:= 1;                     //Blue Raw Material
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  if num_orders_inbound_V >  0 then
  begin
  production_order.order_type  := Type_Delivery ;   //Inbound
  production_order.part_numbers:= num_orders_inbound_V;
  production_order.part_type:= 2;                     //Green Raw Material
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;


  if strtointdef(Ed_BA_PROD.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Production ;   //Production
  production_order.part_numbers:= strtointdef(Ed_BA_PROD.Text, 0);
  production_order.part_type:= 4;                     //Blue Base
  Production_Orders_2[i2] := production_order;
  i2 := i2+1;
  end;

  if strtointdef(Ed_BV_PROD.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Production ;   //Production
  production_order.part_numbers:= strtointdef(Ed_BV_PROD.Text, 0);
  production_order.part_type:= 5;                     //Green Base
  Production_Orders_3[i3] := production_order;
  i3 := i3+1;
  end;

  if strtointdef(Ed_TA_PROD.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Production ;    //Production
  production_order.part_numbers:= strtointdef(Ed_TA_PROD.Text, 0);
  production_order.part_type:= 7;                      //Blue Lid
  Production_Orders_4[i4] := production_order;
  i4 := i4+1;
  end;

  if strtointdef(Ed_TV_PROD.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Production ;    //Production
  production_order.part_numbers:= strtointdef(Ed_TV_PROD.Text, 0);
  production_order.part_type:= 8;                      //Green Lid
  Production_Orders_5[i5] := production_order;
  i5 := i5+1;
  end;

  if strtointdef(Ed_BA_EXP.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Expedition  ;    //Expedition
  production_order.part_numbers:= strtointdef(Ed_BA_EXP.Text, 0);
  production_order.part_type:= 4;                      //Blue Base
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  if strtointdef(Ed_BV_EXP.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Expedition  ;    //Expedition
  production_order.part_numbers:= strtointdef(Ed_BV_EXP.Text, 0);
  production_order.part_type:= 5;                      //Green Base
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  if strtointdef(Ed_TA_EXP.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Expedition ;    //Expedition
  production_order.part_numbers:= strtointdef(Ed_TA_EXP.Text, 0);
  production_order.part_type:= 7;                      //Blue Lid
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  if strtointdef(Ed_TV_EXP.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Expedition ;    //Expedition
  production_order.part_numbers:= strtointdef(Ed_TV_EXP.Text, 0);
  production_order.part_type:= 8;                      //Green Lid
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  //Repor matérias-primas iniciais
  if  strtointdef(Ed_MPA_STO.Text, 0) > 0 then
  begin
  production_order.order_type  := Type_Delivery ;   //Inbound
  production_order.part_numbers:=  strtointdef(Ed_MPA_STO.Text, 0);
  production_order.part_type:= 1;                     //Blue Raw Material
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  if strtointdef(Ed_MPV_STO.Text, 0) >  0 then
  begin
  production_order.order_type := Type_Delivery ;   //Inbound
  production_order.part_numbers:= strtointdef(Ed_MPA_STO.Text, 0);
  production_order.part_type:= 2;                     //Green Raw Material
  Production_Orders_1[i1] := production_order;
  i1 := i1+1;
  end;

  // for Scheduling
  idx_Task_Executing_1 := 0;
  idx_Task_Executing_2 := 0;
  idx_Task_Executing_3 := 0;
  idx_Task_Executing_4 := 0;
  idx_Task_Executing_5 := 0;


  // Dispatcher:
  result:=M_connect();    //Connecting to PLC

  if (result = 1) then
    BStart.Caption:='Connected to PLC'
  else
  begin
    BStart.Caption:='Start';
    ShowMessage('PLC unavailable. Please try again!');
   end;
end;

procedure TFormDispatcher.btBackClick(Sender: TObject);
begin
  Close;
end;

procedure TFormDispatcher.FormCreate(Sender: TObject);
var
    recordNumber : integer = 0;

    expBA         : integer = 0;
    expBV         : integer = 0;
    expTA         : integer = 0;
    expTV         : integer = 0;

    prodBA         : integer = 0;
    prodBV         : integer = 0;
    prodTA         : integer = 0;
    prodTV         : integer = 0;

    supA           : integer = 0;
    supV           : integer = 0;

begin
  SetLength(ShopTasks_1, 0);
  idx_Task_Executing_1 := 0;
  SetLength(ShopTasks_2, 0);
  idx_Task_Executing_2 := 0;
  SetLength(ShopTasks_3, 0);
  idx_Task_Executing_3 := 0;
  SetLength(ShopTasks_4, 0);
  idx_Task_Executing_4 := 0;
  SetLength(ShopTasks_5, 0);
  idx_Task_Executing_5 := 0;

  PQConnection1.Connected := True;
  PQConnection1.ExecuteDirect('Begin Work;');
  PQConnection1.ExecuteDirect('set idle_in_transaction_session_timeout = 0');
  PQConnection1.ExecuteDirect('set schema ''minierp''');
  PQConnection1.ExecuteDirect('Commit Work;');

  SQLEorders.Active := True;
  SQLPorders.Active := True;
  SQLSorders.Active := True;
  SQLProducts.Active := True;
  SQLMaterials.Active := True;

  for recordNumber := 1 to SQLEorders.RecordCount do                         //Buscar base de dados ordens expedição
  begin
       SQLEorders.RecNo := recordNumber;

       if SQLEorders.FieldByName('product_id').AsInteger  = 4 then
       begin
            expBA := expBA + SQLEorders.FieldByName('eorder_qt').AsInteger;
       end;

       if SQLEorders.FieldByName('product_id').AsInteger = 5 then
       begin
            expBV := expBV + SQLEorders.FieldByName('eorder_qt').AsInteger;
       end;

       if SQLEorders.FieldByName('product_id').AsInteger = 7 then
       begin
            expTA := expTA + SQLEorders.FieldByName('eorder_qt').AsInteger;
       end;

       if SQLEorders.FieldByName('product_id').AsInteger = 8 then
       begin
            expTV := expTV + SQLEorders.FieldByName('eorder_qt').AsInteger;
       end;

  end;

  Ed_BA_EXP.Text := IntToStr(expBA);
  Ed_BV_EXP.Text := IntToStr(expBV);
  Ed_TA_EXP.Text := IntToStr(expTA);
  Ed_TV_EXP.Text := IntToStr(expTV);


  for recordNumber := 1 to SQLPorders.RecordCount do                            //Buscar base de dados ordens produção
  begin;
       SQLPorders.RecNo := recordNumber;

       if trim(SQLPorders.FieldByName('porder_status').AsString) = 'planned' then
       begin
           if SQLPorders.FieldByName('product_id').AsInteger  = 4 then
           begin
                prodBA := prodBA + SQLPorders.FieldByName('porder_qtp').AsInteger;
           end;

           if SQLPorders.FieldByName('product_id').AsInteger = 5 then
           begin
                prodBV := prodBV + SQLPorders.FieldByName('porder_qtp').AsInteger;
           end;

           if SQLPorders.FieldByName('product_id').AsInteger = 7 then
           begin
                prodTA := prodTA + SQLPorders.FieldByName('porder_qtp').AsInteger;
           end;

           if SQLPorders.FieldByName('product_id').AsInteger = 8 then
           begin
                prodTV := prodTV + SQLPorders.FieldByName('porder_qtp').AsInteger;
           end;

       end;

  end;

  Ed_BA_PROD.Text := IntToStr(prodBA);
  Ed_BV_PROD.Text := IntToStr(prodBV);
  Ed_TA_PROD.Text := IntToStr(prodTA);
  Ed_TV_PROD.Text := IntToStr(prodTV);


  for recordNumber := 1 to SQLSorders.RecordCount do                             //Buscar base de dados ordens inbound
  begin;
       SQLSorders.RecNo := recordNumber;

         if SQLSorders.FieldByName('material_id').AsInteger  = 1 then
         begin
              supA := supA + SQLSorders.FieldByName('sorder_qt').AsInteger;
         end;

         if SQLSorders.FieldByName('material_id').AsInteger = 2 then
         begin
              supV := supV + SQLSorders.FieldByName('sorder_qt').AsInteger;
         end;
  end;

  Ed_MPA_IN.Text := IntToStr(supA);
  Ed_MPV_IN.Text := IntToStr(supV);


  for recordNumber := 1 to SQLProducts.RecordCount do                               //Buscar base de dados inventário produtos
  begin;
       SQLProducts.RecNo := recordNumber;

         if SQLProducts.FieldByName('product_id').AsInteger  = 4 then
         begin
              Ed_BA_STO.Text := SQLProducts.FieldByName('product_inventory').AsString;
         end;

         if SQLProducts.FieldByName('product_id').AsInteger = 5 then
         begin
              Ed_BV_STO.Text := SQLProducts.FieldByName('product_inventory').AsString;
         end;

         if SQLProducts.FieldByName('product_id').AsInteger = 7 then
         begin
              Ed_TA_STO.Text := SQLProducts.FieldByName('product_inventory').AsString;
         end;

         if SQLProducts.FieldByName('product_id').AsInteger = 8 then
         begin
              Ed_TV_STO.Text := SQLProducts.FieldByName('product_inventory').AsString;
         end;

  end;


  for recordNumber := 1 to SQLMaterials.RecordCount do                             //Buscar base de dados inventário MP
  begin;
       SQLMaterials.RecNo := recordNumber;

         if SQLMaterials.FieldByName('material_id').AsInteger  = 1 then
         begin
              Ed_MPA_STO.Text := SQLMaterials.FieldByName('material_inventory').AsString;
         end;

         if SQLMaterials.FieldByName('material_id').AsInteger = 2 then
         begin
              Ed_MPV_STO.Text := SQLMaterials.FieldByName('material_inventory').AsString;
         end;

  end;


end;


procedure TFormDispatcher.Timer1Timer(Sender: TObject);
begin
  BExecuteClick(Self);
end;

procedure TFormDispatcher.Timer2Timer(Sender: TObject);
begin
  Button1Click(Self);
end;


//Initialization of the MES /week. This procedure run only once per week
procedure TFormDispatcher.BInitiatilizeClick(Sender: TObject);
var
    cel, r, aux, j: integer;
    i : integer = 1;
begin
  // Initialization of parts in the first column of the warehouse.

  aux:=strtointdef(Ed_MPA_STO.Text,0)+ strtointdef(Ed_MPV_STO.Text,0) + strtointdef(Ed_BA_STO.Text,0) + strtointdef(Ed_BV_STO.Text,0) + strtointdef(Ed_TA_STO.Text,0) + strtointdef(Ed_TV_STO.Text,0);
  r:=0;

  for j:=1 to strtointdef(Ed_MPA_STO.Text,0) do
  begin
    r:=r+M_Initialize(i, 1);
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(Ed_MPV_STO.Text,0) do
  begin
    r:=r+M_Initialize(i, 2);
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(Ed_BA_STO.Text,0) do
  begin
    r:=r+M_Initialize(i, 4);
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(Ed_BV_STO.Text,0) do
  begin
    r:=r+M_Initialize(i, 5);
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(Ed_TA_STO.Text,0) do
  begin
    r:=r+M_Initialize(i, 7);
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(Ed_TV_STO.Text,0) do
  begin
    r:=r+M_Initialize(i, 8);
    i := i+9;
    sleep(1500);
  end;

  if (r>aux) then
  begin
     Memo1.Append('Initialization with erros');
  end;

  SetLength(AR_Parts,54);

  for cel:=0 to Length(AR_Parts)-1 do
  begin
    AR_Parts[cel]:=0
  end;

  i:=0;

  for j:=1 to strtointdef(Ed_MPA_STO.Text,0) do
  begin
    AR_Parts[i]:=1;
    i:= i+9;
  end;

  for j:=1 to strtointdef(Ed_MPV_STO.Text,0) do
  begin
    AR_Parts[i]:=2;
    i:= i+9;
  end;

  for j:=1 to strtointdef(Ed_BA_STO.Text,0) do
  begin
    AR_Parts[i]:=4;
    i:= i+9;
  end;

  for j:=1 to strtointdef(Ed_BV_STO.Text,0) do
  begin
    AR_Parts[i]:=5;
    i:= i+9;
  end;

  for j:=1 to strtointdef(Ed_TA_STO.Text,0) do
  begin
    AR_Parts[i]:=7;
    i:= i+9;
  end;

  for j:=1 to strtointdef(Ed_TV_STO.Text,0) do
  begin
    AR_Parts[i]:=8;
    i:= i+9;
  end;

  SimpleScheduler(Production_Orders_1, ShopTasks_1);
  SimpleScheduler(Production_Orders_2, ShopTasks_2);
  SimpleScheduler(Production_Orders_3, ShopTasks_3);
  SimpleScheduler(Production_Orders_4, ShopTasks_4);
  SimpleScheduler(Production_Orders_5, ShopTasks_5);

  Timer1.Enabled:= true;
  Timer2.Enabled:= true;
end;



// get the first position (cell) in AR that contains the "Part"
function TFormDispatcher.GET_AR_Position (Part : integer; var Warehouse : array of integer): integer;
var
    i : integer;
begin
  for i := 0 to Length(Warehouse)-1 do
  begin
      if Warehouse[i] = Part then
      begin
          result := i + 1;
          Warehouse[i] := 0;
          Exit;
      end
      else
      begin
         result := -1;
      end;
  end;
end;

//Sets the Position of the AR with the "Part" provided
procedure TFormDispatcher.SET_AR_Position (idx : integer; Part : integer; var Warehouse : array of integer);
begin
  Warehouse [ idx-1 ] := Part;
end;


procedure TFormDispatcher.BExecuteClick(Sender: TObject);
begin

  // See the availability of resources
  UpdateResources(ShopResources);

  //Dispatcher executing per cycle.
  if(Length(ShopTasks_1)>0) then begin
    Dispatcher(ShopTasks_1, idx_Task_Executing_1, ShopResources);
  end;
  if(Length(ShopTasks_2)>0) then begin
    Dispatcher(ShopTasks_2, idx_Task_Executing_2, ShopResources);
  end;
  if(Length(ShopTasks_3)>0) then begin
    Dispatcher(ShopTasks_3, idx_Task_Executing_3, ShopResources);
  end;
  if(Length(ShopTasks_4)>0) then begin
    Dispatcher(ShopTasks_4, idx_Task_Executing_4, ShopResources);
  end;
  if(Length(ShopTasks_5)>0) then begin
    Dispatcher(ShopTasks_5, idx_Task_Executing_5, ShopResources);
  end;
end;


// Global Dispatcher - SIMPLEX
procedure TFormDispatcher.Dispatcher(var tasks:TArray_Task; var idx : integer; shopfloor: TResources );
begin
    case tasks[idx].task_type of

      // Expedition
      Type_Expedition :
      begin
        if(idx < Length(tasks)) then
        begin
          Memo1.Append('Task Expedition');
          Execute_Expedition_Order(tasks[idx], shopfloor);

          // Next Operation to be executed.
          if(tasks[idx].current_operation = Finished) then
            inc(idx);
        end;
      end;


      // Production
      Type_Production :
      begin
        if(idx < Length(tasks)) then
        begin
          Memo1.Append('Task Production');
          Execute_Production_Order(tasks[idx], shopfloor);

          // Next Operation to be executed.
          if(tasks[idx].current_operation = Finished) then
          begin
            inc(idx);
          end;
        end;
      end;


      // Inbound
      Type_Delivery :
      begin
        if(idx < Length(tasks)) then
        begin
          Memo1.Append('Task Delivery');
          Execute_Delivery_Order(tasks[idx], shopfloor);

          // Next Operation to be executed.
          if(tasks[idx].current_operation = Finished) then
          begin
            inc(idx);
          end;
        end;
      end;

      // Trash
      Type_Trash :
      begin
        //not used
      end;

    end;
end;


//Procedure that executes an expedition order
procedure TFormDispatcher.Execute_Expedition_Order(var task:TTask; shopfloor: TResources );
var
    r : integer;
begin

  with task do
  begin
     case current_operation of
        // To be Started
        To_Be_Started:
        begin
           current_operation :=  GetPart;
        end;

        // Getting a Position in the Warehouse
        GetPart :
        begin
          if(shopfloor.AR_free) then  //AR is free
          begin
            Part_Position_AR := GET_AR_Position(Part_Type, AR_Parts);
            Memo1.Append(IntToStr(Part_Position_AR));

            if( Part_Position_AR > 0 ) then
            begin
               current_operation :=  Unload;
            end
            else
            begin
               current_operation :=  GetPart;
            end;
          end;
        end;

        // Request the unload of part
        Unload :
        begin
          Memo1.Append('AR Unloading: ' + IntToStr(Part_Position_AR));
          r := M_Unload(Part_Position_AR);

          if ( r = 1 ) then                                 //sucess
             current_operation :=  TO_AR_OUT;
        end;

        // Part in the output conveyor
        TO_AR_OUT :
        begin
          if( ShopResources.AR_Out_Part  = Part_Type ) then
          begin
            r := M_Do_Expedition(Part_Destination);          // Expedition

            if( r = 1) then                                  // sucess
             current_operation :=  Clear_Pos_AR;
          end;
        end;

        //Updated AR (removing the part from the position)
        Clear_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, 0, AR_Parts);
          current_operation :=  Finished;
        end;

        //Done.
        Finished :
        begin
          current_operation :=  Finished;
        end;
      end;
  end;
end;


// Procedure that executes a production order
procedure TFormDispatcher.Execute_Production_Order(var task:TTask; shopfloor: TResources );
var
    r : integer = 0;
    mp : integer;
begin

  with task do
  begin

     if (Part_type < 7) then
     begin
       mp := Part_Type - 3;
     end
     else
     begin
       mp := Part_Type -6;
     end;

     case current_operation of
        // To be Started
        To_Be_Started:
        begin
           current_operation :=  GetPart;
        end;

        // Getting a Position in the Warehouse
        GetPart :
        begin
          if(shopfloor.AR_free) then  //AR is free
          begin
            Part_Position_AR := GET_AR_Position(mp, AR_Parts);
            Memo1.Append(IntToStr(Part_Position_AR));

            if( Part_Position_AR > 0 ) then
            begin
               current_operation :=  Unload;
            end
            else
            begin
               current_operation :=  GetPart;
            end;
          end;
        end;

        // Request the unload of part
        Unload :
        begin
          Memo1.Append('AR Unloading: ' + IntToStr(Part_Position_AR));
          r := M_Unload(Part_Position_AR);

          if ( r = 1 ) then                                 //success
             current_operation :=  TO_AR_OUT;
          end;

        // Part in the output conveyor
        TO_AR_OUT :
        begin
          if( ShopResources.AR_Out_Part  = mp ) then
          begin
            r := M_Do_Production(Part_Destination);          // Production

            if( r = 1) then                                  // success
             current_operation :=  Clear_Pos_AR;
          end;
        end;

        //Updated AR (removing the part from the position)
        Clear_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, 0, AR_Parts);
          memo1.append('fiz clear');
          current_operation :=  Load;
        end;

        // Request the load of part
        Load:
        begin
          sleep(200);
          if( ShopResources.AR_In_Part  = Part_Type ) then
          begin
               Memo1.Append('AR Loading: ' + IntToStr(Part_Position_AR));
               r := M_Load(Part_Position_AR);
          end;

          if ( r = 1 ) then              //success
          begin
             current_operation :=  Insert_Pos_AR;
          end
        end;

        //Updated AR (inserting the part in the position)
        Insert_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, Part_Type, AR_Parts);
          current_operation :=  Finished;
        end;

        //Done.
        Finished :
        begin
          current_operation :=  Finished;
        end;
      end;
  end;
end;


// Procedure that executes a delivery order
procedure TFormDispatcher.Execute_Delivery_Order(var task:TTask; shopfloor: TResources );
var
    r : integer = 0;
begin

  with task do
  begin

     case current_operation of
        // To be Started
        To_Be_Started:
        begin
           current_operation :=  SetPosition;
        end;

        // Setting a Position in the Warehouse
        SetPosition :
        begin
          if(shopfloor.AR_free) then  //AR is free
          begin
            Part_Position_AR := GET_AR_Position(0, AR_Parts);
            Memo1.Append(IntToStr(Part_Position_AR));

            if( Part_Position_AR > 0 ) then
            begin
               current_operation :=  TO_AR_IN;
            end
            else
            begin
               current_operation :=  SetPosition;
            end;
          end;
        end;

        // Part in the input conveyor
        TO_AR_IN :
        begin
            r := M_Do_Inbound(Part_Type);             // Inbound

            if( r = 1) then                        // success
            begin
             current_operation :=  Load;
            end;
        end;

        // Request the load of part
        Load:
        begin
          if( ShopResources.AR_In_Part  = Part_Type ) then
          begin
               Memo1.Append('AR Loading: ' + IntToStr(Part_Position_AR));
               r := M_Load(Part_Position_AR);
          end;

          if ( r = 1 ) then              //success
          begin
             current_operation :=  Insert_Pos_AR;
          end;
        end;

        //Updated AR (inserting the part in the position)
        Insert_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, Part_Type, AR_Parts);
          current_operation :=  Finished;
        end;

        //Done.
        Finished :
        begin
          current_operation :=  Finished;
        end;
      end;
  end;
end;


procedure TFormDispatcher.Button1Click(Sender: TObject);         //Atualização de Resultados
var
    BA_PROD : integer = 0;
    BV_PROD : integer = 0;
    TA_PROD : integer = 0;
    TV_PROD : integer = 0;
    BA_EXP : integer = 0;
    BV_EXP : integer = 0;
    TA_EXP : integer = 0;
    TV_EXP : integer = 0;
    MPA_IN :integer = 0;
    MPV_IN : integer = 0;
    MPA_STO : integer;
    MPV_STO : integer;
    BA_STO : integer;
    BV_STO : integer;
    TA_STO : integer;
    TV_STO : integer;
    BA_PROC : integer = 0;
    BV_PROC : integer = 0;
    TA_PROC : integer = 0;
    TV_PROC : integer = 0;
    i : integer;
    i1:integer;
    i2:integer;
    i3:integer;
    i4:integer;
    i5:integer;
    Tasks : TArray_Task;

    query : string;
    recordNumber : integer;

begin

  MPA_STO := strtointdef(Ed_MPA_STO.Text, 0);
  MPV_STO := strtointdef(Ed_MPV_STO.Text, 0);
  BA_STO := strtointdef(Ed_BA_STO.Text, 0);
  BV_STO := strtointdef(Ed_BV_STO.Text, 0);
  TA_STO := strtointdef(Ed_TA_STO.Text, 0);
  TV_STO := strtointdef(Ed_TV_STO.Text, 0);

  //agregar as várias shoptasks
  SetLength(Tasks, length(ShopTasks_1) + length(ShopTasks_2) + length(ShopTasks_3) + length(ShopTasks_4) + length(ShopTasks_5));

  for i1:=0 to length(ShopTasks_1)-1 do
  begin
    Tasks[i1] := ShopTasks_1[i1];
  end;
  for i2:=0 to length(ShopTasks_2)-1 do
  begin
    Tasks[i1+i2+2] := ShopTasks_2[i2];
  end;
  for i3:=0 to length(ShopTasks_3)-1 do
  begin
    Tasks[i1+i2 +i3+3] := ShopTasks_3[i3];
  end;
  for i4:=0 to length(ShopTasks_4)-1 do
  begin
    Tasks[i1+i2+i3+i4+4] := ShopTasks_4[i4];
  end;
  for i5:=0 to length(ShopTasks_5)-1 do
  begin
    Tasks[i1+i2+i3+i4+i5+5] := ShopTasks_5[i5];
  end;


  for i:=0 to length(Tasks)-1 do
  begin
    if (Tasks[i].task_type = Type_Production) and (Tasks[i].current_operation = Finished) then          //Uma produção acabou: incrementar produção e stock de produto final e decrementar peça em processamento
    begin
      if Tasks[i].Part_type = 4 then
      begin
           BA_PROD := BA_PROD +1;
           BA_STO := BA_STO +1;
           BA_PROC := BA_PROC -1;
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           BV_PROD := BV_PROD +1;
           BV_STO := BV_STO +1;
           BV_PROC := BV_PROC -1;
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           TA_PROD := TA_PROD +1;
           TA_STO := TA_STO +1;
           TA_PROC := TA_PROC -1;
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         TV_PROD := TV_PROD +1;
         TV_STO := TV_STO +1;
         TV_PROC := TV_PROC -1;
      end;
    end;
    if (Tasks[i].task_type = Type_Production) and (Tasks[i].current_operation > Unload) then          //Uma produção passou a etapa de Unload: decrementar stock de matéria-prima e incrementar peça em processamento
    begin
      if Tasks[i].Part_type = 4 then
      begin
           MPA_STO := MPA_STO -1;
           BA_PROC := BA_PROC +1;
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           MPV_STO := MPV_STO -1;
           BV_PROC := BV_PROC +1;
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           MPA_STO := MPA_STO -1;
           TA_PROC := TA_PROC +1;
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         MPV_STO := MPV_STO -1;
         TV_PROC := TV_PROC +1;
      end;
    end;
    if (Tasks[i].task_type = Type_Expedition) and (Tasks[i].current_operation = Finished) then          //Uma expedição acabou: incrementar expedição
    begin
      if Tasks[i].Part_type = 4 then
      begin
           BA_EXP := BA_EXP +1;
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           BV_EXP := BV_EXP +1;
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           TA_EXP := TA_EXP +1;
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         TV_EXP := TV_EXP +1;
      end;
    end;
    if (Tasks[i].task_type = Type_Expedition) and (Tasks[i].current_operation > Unload) then          //Uma expedição já passou a etapa de Unload: decrementar stock de matéria-prima
    begin
      if Tasks[i].Part_type = 4 then
      begin
           BA_STO := BA_STO -1;
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           BV_STO := BV_STO -1;
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           TA_STO := TA_STO -1;
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         TV_STO := TV_STO -1;
      end;
    end;
    if (Tasks[i].task_type = Type_Delivery) and (Tasks[i].current_operation = Finished) then           //Uma compra já acabou: incrementar compra e stock de matéria-prima
    begin
      if Tasks[i].Part_type = 1 then
      begin
           MPA_IN := MPA_IN +1;
           MPA_STO := MPA_STO +1;
      end;
      if Tasks[i].Part_Type = 2 then
      begin
           MPV_IN := MPV_IN +1;
           MPV_STO := MPV_STO +1;
      end;
      end;
    end;

  //Colocar resultados nas Memo
  Memo_BA_PROD.Append(inttostr(BA_PROD));
  Memo_BV_PROD.Append(inttostr(BV_PROD));
  Memo_TA_PROD.Append(inttostr(TA_PROD));
  Memo_TV_PROD.Append(inttostr(TV_PROD));

  Memo_BA_EXP.Append(inttostr(BA_EXP));
  Memo_BV_EXP.Append(inttostr(BV_EXP));
  Memo_TA_EXP.Append(inttostr(TA_EXP));
  Memo_TV_EXP.Append(inttostr(TV_EXP));

  Memo_MPA_IN.Append(inttostr(MPA_IN));
  Memo_MPV_IN.Append(inttostr(MPV_IN));

  Memo_MPA_STO.Append(inttostr(MPA_STO));
  Memo_MPV_STO.Append(inttostr(MPV_STO));
  Memo_BA_STO.Append(inttostr(BA_STO));
  Memo_BV_STO.Append(inttostr(BV_STO));
  Memo_TA_STO.Append(inttostr(TA_STO));
  Memo_TV_STO.Append(inttostr(TV_STO));

  Memo_BA_PROC.Append(inttostr(BA_PROC));
  Memo_BV_PROC.Append(inttostr(BV_PROC));
  Memo_TA_PROC.Append(inttostr(TA_PROC));
  Memo_TV_PROC.Append(inttostr(TV_PROC));


  //Atualizar base de dados expedição e corders
  for recordNumber := 1 to SQLEorders.RecordCount do
  begin

    SQLEorders.RecNo := recordNumber;

    if (SQLEorders.FieldByName('product_id').AsInteger = 4) And (trim(SQLEorders.FieldByName('eorder_status').AsString) = 'planned') then
    begin

       if (SQLEorders.FieldByName('eorder_qt').AsInteger = (StrToIntDef(trim(Memo_BA_EXP.Text), 0) - quantExpBA)) then
       begin

         query := 'UPDATE eorders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('eorder_id').AsString;

         quantExpBA := quantExpBA + SQLEorders.FieldByName('eorder_qt').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLEorders.Active := False;
         SQLEorders.Active := True;

         query := 'UPDATE corders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('corder_id').AsString;

         PQConnection1.ExecuteDirect(query);

       end;

    end;

    if (SQLEorders.FieldByName('product_id').AsInteger = 5) And (trim(SQLEorders.FieldByName('eorder_status').AsString) = 'planned') then
    begin

       if (SQLEorders.FieldByName('eorder_qt').AsInteger = (StrToIntDef(trim(Memo_BV_EXP.Text), 0) - quantExpBV)) then
       begin

         query := 'UPDATE eorders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('eorder_id').AsString;

         quantExpBV := quantExpBV + SQLEorders.FieldByName('eorder_qt').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLEorders.Active := False;
         SQLEorders.Active := True;

         query := 'UPDATE corders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('corder_id').AsString;

         PQConnection1.ExecuteDirect(query);

       end;

    end;

    if (SQLEorders.FieldByName('product_id').AsInteger = 7) And (trim(SQLEorders.FieldByName('eorder_status').AsString) = 'planned') then
    begin

       if (SQLEorders.FieldByName('eorder_qt').AsInteger = (StrToIntDef(trim(Memo_TA_EXP.Text), 0) - quantExpTA)) then
       begin

         query := 'UPDATE eorders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('eorder_id').AsString;

         quantExpTA := quantExpTA + SQLEorders.FieldByName('eorder_qt').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLEorders.Active := False;
         SQLEorders.Active := True;

         query := 'UPDATE corders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('corder_id').AsString;

         PQConnection1.ExecuteDirect(query);

       end;

    end;

    if (SQLEorders.FieldByName('product_id').AsInteger = 8) And (trim(SQLEorders.FieldByName('eorder_status').AsString) = 'planned') then
    begin

       if (SQLEorders.FieldByName('eorder_qt').AsInteger = (StrToIntDef(trim(Memo_TV_EXP.Text), 0) - quantExpTV)) then
       begin

         query := 'UPDATE eorders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('eorder_id').AsString;

         quantExpTV := quantExpTV + SQLEorders.FieldByName('eorder_qt').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLEorders.Active := False;
         SQLEorders.Active := True;

         query := 'UPDATE corders SET status = ''done'', weekd = 6 WHERE id = ' + SQLEorders.FieldByName('corder_id').AsString;

         PQConnection1.ExecuteDirect(query);

       end;

    end;

  end;


  //Atualizar base de dados produção
  for recordNumber := 1 to SQLPorders.RecordCount do
  begin

    SQLPorders.RecNo := recordNumber;

    if (SQLPorders.FieldByName('product_id').AsInteger = 4) And (trim(SQLPorders.FieldByName('porder_status').AsString) = 'planned') then
    begin

       if (SQLPorders.FieldByName('porder_qtp').AsInteger = (StrToIntDef(trim(Memo_BA_PROD.Text), 0) - quantProdBA)) then
       begin

         query := 'UPDATE porders SET status = ''done'', weekd = 6, qtok = ' + SQLPorders.FieldByName('porder_qtp').AsString + ' WHERE id = ' + SQLPorders.FieldByName('porder_id').AsString;

         quantProdBA := quantProdBA + SQLPorders.FieldByName('porder_qtp').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLPorders.Active := False;
         SQLPorders.Active := True;

       end;

    end;

    if (SQLPorders.FieldByName('product_id').AsInteger = 5) And (trim(SQLPorders.FieldByName('porder_status').AsString) = 'planned') then
    begin

       if (SQLPorders.FieldByName('porder_qtp').AsInteger = (StrToIntDef(trim(Memo_BV_PROD.Text), 0) - quantProdBV)) then
       begin

         query := 'UPDATE porders SET status = ''done'', weekd = 6, qtok = ' + SQLPorders.FieldByName('porder_qtp').AsString + ' WHERE id = ' + SQLPorders.FieldByName('porder_id').AsString;

         quantProdBV := quantProdBV + SQLPorders.FieldByName('porder_qtp').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLPorders.Active := False;
         SQLPorders.Active := True;

       end;

    end;

    if (SQLPorders.FieldByName('product_id').AsInteger = 7) And (trim(SQLPorders.FieldByName('porder_status').AsString) = 'planned') then
    begin

       if (SQLPorders.FieldByName('porder_qtp').AsInteger = (StrToIntDef(trim(Memo_TA_PROD.Text), 0) - quantProdTA)) then
       begin

         query := 'UPDATE porders SET status = ''done'', weekd = 6, qtok = ' + SQLPorders.FieldByName('porder_qtp').AsString + ' WHERE id = ' + SQLPorders.FieldByName('porder_id').AsString;

         quantProdTA := quantProdTA + SQLPorders.FieldByName('porder_qtp').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLPorders.Active := False;
         SQLPorders.Active := True;

       end;

    end;

    if (SQLPorders.FieldByName('product_id').AsInteger = 8) And (trim(SQLPorders.FieldByName('porder_status').AsString) = 'planned') then
    begin

       if (SQLPorders.FieldByName('porder_qtp').AsInteger = (StrToIntDef(trim(Memo_TV_PROD.Text), 0) - quantProdTV)) then
       begin

         query := 'UPDATE porders SET status = ''done'', weekd = 6, qtok = ' + SQLPorders.FieldByName('porder_qtp').AsString + ' WHERE id = ' + SQLPorders.FieldByName('porder_id').AsString;

         quantProdTV := quantProdTV + SQLPorders.FieldByName('porder_qtp').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLPorders.Active := False;
         SQLPorders.Active := True;

       end;

    end;

  end;


   //Atualizar base de dados compras
  for recordNumber := 1 to SQLSorders.RecordCount do
  begin

    SQLSorders.RecNo := recordNumber;

    if (SQLSorders.FieldByName('material_id').AsInteger = 1) Then
    begin

       if (SQLSorders.FieldByName('sorder_qt').AsInteger = (StrToIntDef(trim(Memo_MPA_IN.Text), 0) - quantInMPA)) then
       begin

         query := 'UPDATE sorders SET status = ''done'', weekd = 6 WHERE id = ' + SQLSorders.FieldByName('sorder_id').AsString;

         quantInMPA := quantInMPA + SQLSorders.FieldByName('sorder_qt').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLSorders.Active := False;
         SQLSorders.Active := True;

       end;

    end;

    if (SQLSorders.FieldByName('material_id').AsInteger = 2) Then
    begin

       if (SQLSorders.FieldByName('sorder_qt').AsInteger = (StrToIntDef(trim(Memo_MPV_IN.Text), 0) - quantInMPV)) then
       begin

         query := 'UPDATE sorders SET status = ''done'', weekd = 6 WHERE id = ' + SQLSorders.FieldByName('sorder_id').AsString;

         quantInMPV := quantInMPV + SQLSorders.FieldByName('sorder_qt').AsInteger;

         PQConnection1.ExecuteDirect(query);
         SQLSorders.Active := False;
         SQLSorders.Active := True;

       end;

    end;

  end;



  if ShopResources.Robot_1_Part > 0 then
  begin
     Memo_R1.clear();
     Memo_R1.color := clRed;
     Memo_R1.Append('BUSY');
     Memo_R1.Font.Color := clWhite ;
  end
  else
  begin
     Memo_R1.clear();
     Memo_R1.color := clGreen;
     Memo_R1.Append('FREE');
     Memo_R1.Font.Color := clWhite ;
  end;
  if ShopResources.Robot_2_Part > 0 then
  begin
     Memo_R2.clear();
     Memo_R2.color := clRed;
     Memo_R2.Append('BUSY');
     Memo_R2.Font.Color := clWhite ;
  end
  else
  begin
     Memo_R2.clear();
     Memo_R2.color := clGreen;
     Memo_R2.Append('FREE');
     Memo_R2.Font.Color := clWhite ;
  end;
end;

procedure TFormDispatcher.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.MainForm.Show;
end;

end.

