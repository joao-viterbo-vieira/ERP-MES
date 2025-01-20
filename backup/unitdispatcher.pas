unit unitdispatcher;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, comUnit, DateUtils, PQConnection, SQLDB;

type

  //***************************************
  //Production plan obtained by ERP and available in the DB
  // Enumerated: defines the type of the TTask
  TTask_Type  = (Type_Expedition = 1, Type_Delivery, Type_Production, Type_Trash);

  TProduction_Order = record
    part_type           : Integer;    // Part type { 0, ... 9}
    part_numbers        : Integer;    // Number of parts to be performed
    order_type          : TTask_Type;
  end;

  TArray_Production_Order = array of TProduction_Order;
  //***************************************



  //***************************************
  // Enumerated: defines all stages of TTasks
  // Dispatcher Execution
  TStage      = (EXP_To_Be_Started = 1, EXP_GetPart, EXP_Unload, Load, EXP_TO_AR_OUT, EXP_Clear_Pos_AR, TO_AR_IN , Set_Position, Insert_Pos_AR, EXP_Finished); //TbC

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
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    doneparaBD: TButton;
    atualizarBDparalive: TButton;
    ImportarBD: TButton;
    LimparTudo: TButton;
    EXP_BMET: TEdit;
    EXP_TMET: TEdit;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image2: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image3: TImage;
    Image30: TImage;
    Image31: TImage;
    Image321: TImage;
    Image331: TImage;
    Image341: TImage;
    Image351: TImage;
    Image361: TImage;
    Image371: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Inbound_text1: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label28: TLabel;
    Label3: TLabel;
    Label34: TLabel;
    Label4: TLabel;
    Label41: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo56: TMemo;
    Memo57: TMemo;
    Memo58: TMemo;
    Memo59: TMemo;
    Memo60: TMemo;
    Memo61: TMemo;
    Memo62: TMemo;
    Memo_Totalprod: TMemo;
    MemoContagemAR: TMemo;
    MemoAR: TMemo;
    Memo_Totalexp: TMemo;
    PQConnection1: TPQConnection;
    SINA_ENT_A: TMemo;
    SINA_ENT_M: TMemo;
    SINA_ENT_V: TMemo;
    Percentagem_acabado: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label38: TLabel;
    Inbound_text: TLabel;
    Memo10: TMemo;
    Memo11: TMemo;
    Memo12: TMemo;
    Memo13: TMemo;
    Memo14: TMemo;
    Memo15: TMemo;
    Memo16: TMemo;
    Memo17: TMemo;
    Memo18: TMemo;
    Memo19: TMemo;
    Memo2: TMemo;
    Memo20: TMemo;
    Memo21: TMemo;
    Memo22: TMemo;
    Memo23: TMemo;
    Memo24: TMemo;
    Memo25: TMemo;
    Memo26: TMemo;
    Memo27: TMemo;
    Memo28: TMemo;
    Memo29: TMemo;
    Memo3: TMemo;
    Memo30: TMemo;
    Memo31: TMemo;
    Memo32: TMemo;
    Memo33: TMemo;
    Memo34: TMemo;
    Memo35: TMemo;
    Memo36: TMemo;
    Memo37: TMemo;
    Memo38: TMemo;
    Memo39: TMemo;
    Memo4: TMemo;
    Memo40: TMemo;
    Memo41: TMemo;
    Memo42: TMemo;
    Memo43: TMemo;
    Memo44: TMemo;
    Memo45: TMemo;
    Memo46: TMemo;
    Memo47: TMemo;
    Memo48: TMemo;
    Memo49: TMemo;
    Memo5: TMemo;
    Memo50: TMemo;
    Memo51: TMemo;
    Memo52: TMemo;
    Memo53: TMemo;
    Memo54: TMemo;
    Memo55: TMemo;
    Memo_perc_conc: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Memo9: TMemo;
    Memo_BA_EXPR: TMemo;
    SINA_EXP_BA: TMemo;
    Memo_BA_PRODR: TMemo;
    Memo_BM_EXPR: TMemo;
    SINA_EXP_BM: TMemo;
    Memo_BM_PRODR: TMemo;
    Memo_BV_EXPR: TMemo;
    SINA_EXP_BV: TMemo;
    Memo_BV_PRODR: TMemo;
    Memo_Inb: TMemo;
    Memo_TA_EXPR: TMemo;
    SINA_EXP_TA: TMemo;
    Memo_TA_PRODR: TMemo;
    Memo_TM_EXPR: TMemo;
    SINA_PROD_TM: TMemo;
    SINA_PROD_BM: TMemo;
    Memo_TM_EXP: TMemo;
    Memo_BM_EXP: TMemo;
    SINA_EXP_TM: TMemo;
    Memo_TM_PROD: TMemo;
    Memo_BM_PROD: TMemo;
    Memo_MPM_INB: TMemo;
    Memo_TM_PRODR: TMemo;
    Memo_TM_STOI_C: TMemo;
    Memo_BM_STOI_C: TMemo;
    Memo_MPM_STOI_C: TMemo;
    Memo_TV_EXPR: TMemo;
    SINA_EXP_TV: TMemo;
    Memo_TV_PRODR: TMemo;
    Percentagem_acabado1: TLabel;
    PROD_TMET: TEdit;
    PROD_BMET: TEdit;
    INB_MET: TEdit;
    SQLEorders: TSQLQuery;
    SQLMaterials: TSQLQuery;
    SQLPorders: TSQLQuery;
    SQLProducts: TSQLQuery;
    SQLSorders: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    STOI_BMET: TEdit;
    STOI_TMET: TEdit;
    STOI_MET: TEdit;
    EXP_BA: TEdit;
    PROD_BA: TEdit;
    INB_MPA: TEdit;
    EXP_BV: TEdit;
    PROD_BV: TEdit;
    STOI_MPA: TEdit;
    INB_MPV: TEdit;
    STOI_BA: TEdit;
    PROD_TA: TEdit;
    STOI_TA: TEdit;
    STOI_MPV: TEdit;
    STOI_BV: TEdit;
    PROD_TV: TEdit;
    STOI_TV: TEdit;
    EXP_TA: TEdit;
    EXP_TV: TEdit;
    Label12: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    Label29: TLabel;
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
    SINA_PROD_BA: TMemo;
    Memo_BA_STOI_C: TMemo;
    SINA_PROD_BV: TMemo;
    Memo_MPA_INB: TMemo;
    Memo_BV_PROD: TMemo;
    Memo_BV_EXP: TMemo;
    Memo_BV_STOI_C: TMemo;
    Memo_MPA_STOI_C: TMemo;
    Memo_MAQB: TMemo;
    Memo_MPV_INB: TMemo;
    Memo_MPV_STOI_C: TMemo;
    Memo_MAQT: TMemo;
    Memo_TA_PROD: TMemo;
    Memo_TA_EXP: TMemo;
    SINA_PROD_TA: TMemo;
    Memo_TA_STOI_C: TMemo;
    Memo_TV_PROD: TMemo;
    Memo_TV_EXP: TMemo;
    SINA_PROD_TV: TMemo;
    Memo_TV_STOI_C: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Timer1: TTimer;
    UPD_INFO: TTimer;
    procedure BExecuteClick(Sender: TObject);
    procedure BInitiatilizeClick(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure doneparaBDClick(Sender: TObject);
    procedure atualizarBDparaliveClick(Sender: TObject);
    procedure ImportarBDClick(Sender: TObject);
    procedure LimparTudoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UPD_INFOTimer(Sender: TObject);
    procedure  temporizadores;
  private

  public
    procedure Dispatcher(var tasks:TArray_Task; var idx : integer; shopfloor: TResources );
    procedure Execute_Production_Order(var task:TTask; shopfloor: TResources );
    procedure Execute_Expedition_Order(var task:TTask; shopfloor: TResources );
    procedure Execute_Delivery_Order(var task:TTask; shopfloor: TResources );
    function GET_AR_Position (Part : integer; Warehouse : array of integer): integer;
    procedure SET_AR_Position (idx : integer; Part : integer; var Warehouse : array of integer);

  end;



(* GLOBAL VARIABLES *)
var
  FormDispatcher: TFormDispatcher;

  // Production orders obtained by the ERP (using the SQL Query)
  Production_Orders : TArray_Production_Order;

  Production_Orders_SIMUL : TArray_Production_Order;

  Expedition_Orders_SIMUL : TArray_Production_Order;

  // Availability of resources (needs to be updated over time)
  ShopResources : TResources;

  // Tasks that need to be concluded by the MES (expedition, delivery, production and trash).
  ShopTasks     : TArray_Task;
  ShopTasks_SIMUL: TArray_Task;
  ShopTasks_SIMUL1: TArray_Task;

  // Index of the task (from the array "ShopTasks") that is being executed.
  idx_Task_Executing : integer;
  idx_Task_Executing_SIMUL : integer;
  idx_Task_Executing_SIMUL1 : integer;

  // Status of each cell in the warehouse.
  AR_Parts           : array of integer;         //warehouse parts in each position

  total_time_production : integer = 0;
  time_AR : integer = 0;
  time_arm1 : integer= 0;
  time_arm2 : integer = 0;
  tmp_med: real ;
  p_tmp_med: real ;
  Mins1, Secs1, Mins2, Secs2: Integer;
  TimeString1, TimeString2: string;

  prevRobot1Part, prevRobot2Part, prevARInPart: Boolean;
  countRobot1PartChanges, countRobot2PartChanges, countARInPartChanges: Integer;

  sina_exp: integer;

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

  ActionExecuted: Boolean = False;
  contador : integer;


implementation

{$R *.lfm}

uses DataLayer;



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
        current_operation := EXP_To_Be_Started;

        part_position_AR  := -1;  // to be defined later. STUDENTS MUST CHANGE

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
    i : integer = 0;
    j : integer = 0;
    k : integer = 0;
    inbound_A : integer = 0;        //Inbound_text ORDERS
    inbound_V : integer = 0;
    inbound_Met : integer = 0;
    num_orders_prod : integer;      // prod orders
    num_orders_exp : integer;       //exp orders
    aux : integer;
begin
  // Initialize indices
  i := 0;
  j := 0;
  k := 0;

  // Parse inbound orders from text inputs
  inbound_A := strtointdef(INB_MPA.Text, 0);
  inbound_V := strtointdef(INB_MPV.Text, 0);
  inbound_Met := strtointdef(INB_MET.Text, 0);

  // Calculate the number of production orders
  num_orders_prod := strtointdef(PROD_BMET.Text, 0) + strtointdef(PROD_TMET.Text, 0) +
                     strtointdef(PROD_BA.Text, 0) + strtointdef(PROD_BV.Text, 0) +
                     strtointdef(PROD_TA.Text, 0) + strtointdef(PROD_TV.Text, 0);

  // Calculate the number of expedition orders
  num_orders_exp := strtointdef(EXP_BA.Text, 0) + strtointdef(EXP_BV.Text, 0) +
                    strtointdef(EXP_TA.Text, 0) + strtointdef(EXP_TV.Text, 0) +
                    strtointdef(EXP_BMET.Text, 0) + strtointdef(EXP_TMET.Text, 0);

  // Calculate total order numbers and allocate arrays accordingly
  aux := (num_orders_prod - strtointdef(PROD_TA.Text, 0) - strtointdef(PROD_TV.Text, 0)- strtointdef(PROD_TMET.Text, 0));   // inbounds e Num_exp
  SetLength(Production_Orders, aux);  //aux
  SetLength(Production_Orders_SIMUL, strtointdef(PROD_TA.Text, 0) + strtointdef(PROD_TV.Text, 0)+strtointdef(PROD_TMET.Text, 0)) ;  //  strtointdef(PROD_TA.Text, 0) + strtointdef(PROD_TV.Text, 0)
  SetLength(Expedition_Orders_SIMUL, num_orders_exp + inbound_A + inbound_V + inbound_Met ); // +3 Initialize for expedition orders        num_orders_exp

  // Lista bases
if strtointdef(PROD_BA.Text, 0) > 0 then
begin
  production_order.order_type := Type_Production;
  production_order.part_numbers := strtointdef(PROD_BA.Text, 0);
  production_order.part_type := 4; // Blue Base
  Production_Orders[i] := production_order;
  i := i + 1;
end;
if strtointdef(PROD_BV.Text, 0) > 0 then
begin
  production_order.order_type := Type_Production;
  production_order.part_numbers := strtointdef(PROD_BV.Text, 0);
  production_order.part_type := 5; // Green Base
  Production_Orders[i] := production_order;
  i := i + 1;

  if strtointdef(PROD_BMET.Text, 0) > 0 then
begin
  production_order.order_type := Type_Production;
  production_order.part_numbers := strtointdef(PROD_BMET.Text, 0);
  production_order.part_type := 6; // Metal Base
  Production_Orders[i] := production_order;
  i := i + 1;
end;
end;


  // Lista Simul  tampas verdes e azul
  if strtointdef(PROD_TA.Text, 0) > 0 then
  begin
    production_order.order_type := Type_Production;
    production_order.part_numbers := strtointdef(PROD_TA.Text, 0);
    production_order.part_type := 7; // Blue Lid
    Production_Orders_SIMUL[j] := production_order;
    j := j + 1;
  end;
  if strtointdef(PROD_TV.Text, 0) > 0 then
  begin
    production_order.order_type := Type_Production;
    production_order.part_numbers := strtointdef(PROD_TV.Text, 0);
    production_order.part_type := 8; // Green Lid
    Production_Orders_SIMUL[j] := production_order;
    j := j + 1;
  end;

  if strtointdef(PROD_TMET.Text, 0) > 0 then
begin
     production_order.order_type := Type_Production;
     production_order.part_numbers := strtointdef(PROD_TMET.Text, 0);
     production_order.part_type := 9; // Lid Base
     Production_Orders_SIMUL[j] := production_order;
     j := j + 1;
end;



  // Lista 3
    if inbound_A > 0 then
  begin
    production_order.order_type := Type_Delivery;
    production_order.part_numbers := inbound_A;
    production_order.part_type := 1; // Blue Raw Material
    Expedition_Orders_SIMUL[k] := production_order;
    k := k + 1;
  end;
  if inbound_V > 0 then
  begin
    production_order.order_type := Type_Delivery;
    production_order.part_numbers := inbound_V;
    production_order.part_type := 2; // Green Raw Material
    Expedition_Orders_SIMUL[k] := production_order;
    k := k + 1;
  end;
  if inbound_Met > 0 then
  begin
    production_order.order_type := Type_Delivery;
    production_order.part_numbers := inbound_Met;
    production_order.part_type := 3; // Metal Raw Material
    Expedition_Orders_SIMUL[k] := production_order;
    k := k + 1;
  end;

  if strtointdef(EXP_TV.Text, 0) > 0 then
begin
  production_order.order_type := Type_Expedition;
  production_order.part_numbers := strtointdef(EXP_TV.Text, 0);
  production_order.part_type := 8; // Green Base
 Expedition_Orders_SIMUL[k] := production_order;
 k := k + 1;
end;


  if strtointdef(EXP_BA.Text, 0) > 0 then
begin
  production_order.order_type := Type_Expedition;
  production_order.part_numbers := strtointdef(EXP_BA.Text, 0);
  production_order.part_type := 4; // Blue Base
  Expedition_Orders_SIMUL[k] := production_order;
    k := k + 1;
end;
if strtointdef(EXP_BV.Text, 0) > 0 then
begin
  production_order.order_type := Type_Expedition;
  production_order.part_numbers := strtointdef(EXP_BV.Text, 0);
  production_order.part_type := 5; // Green Base
  Expedition_Orders_SIMUL[k] := production_order;
    k := k + 1;
end;

if strtointdef(EXP_TA.Text, 0) > 0 then
begin
  production_order.order_type := Type_Expedition;
  production_order.part_numbers := strtointdef(EXP_TA.Text, 0);
  production_order.part_type := 7; // Blue Base
  Expedition_Orders_SIMUL[k] := production_order;
  k := k + 1;
end;


// restock final da produção 1 mpv 1 mpa 1 metal   requisito entrega passada
(*if  (inbound_A + strtointdef(STOI_MPA.Text, 0)- strtointdef(PROD_TA.Text, 0)- strtointdef(PROD_bA.Text, 0)) = 0  then    //se houver 0 materias primas adicionar 1 peça
begin
production_order.order_type  := Type_Delivery ;   //Inbound_text
production_order.part_numbers:=  1;
production_order.part_type:= 1;                     //Blue Raw Material
Expedition_Orders_SIMUL[k] := production_order;
k := k + 1;
end;

if (inbound_Met + strtointdef(STOI_Met.Text, 0)- strtointdef(PROD_TMET.Text, 0)- strtointdef(PROD_BMET.Text, 0)) = 0 then
begin
     production_order.order_type := Type_Delivery ;   //Inbound_text
     production_order.part_numbers:= 1;
     production_order.part_type:= 3;                     //Metal Raw Material
     Expedition_Orders_SIMUL[k] := production_order;
     k := k + 1;
end;

if (inbound_V + strtointdef(STOI_MPV.Text, 0)- strtointdef(PROD_TV.Text, 0)- strtointdef(PROD_BV.Text, 0)) = 0  then
begin
production_order.order_type := Type_Delivery ;   //Inbound_text
production_order.part_numbers:= 1;
production_order.part_type:= 2;                     //Green Raw Material
Expedition_Orders_SIMUL[k] := production_order;
k := k + 1;
end; *)

if strtointdef(EXP_BMET.Text, 0) > 0 then
begin
  production_order.order_type := Type_Expedition;
  production_order.part_numbers := strtointdef(EXP_BMET.Text, 0);
  production_order.part_type := 6; // Metal Base
  Expedition_Orders_SIMUL[k] := production_order;
  k := k + 1;
end;

if strtointdef(EXP_TMET.Text, 0) > 0 then
begin
  production_order.order_type := Type_Expedition;
  production_order.part_numbers := strtointdef(EXP_TMET.Text, 0);
  production_order.part_type := 9; // Metal Lid
  Expedition_Orders_SIMUL[k] := production_order;
  k := k + 1;
end;


    atualizarBDparaliveClick(self);


  // for Scheduling
  idx_Task_Executing := 0;
  idx_Task_Executing_SIMUL := 0;
  idx_Task_Executing_SIMUL1 := 0;



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

procedure TFormDispatcher.FormCreate(Sender: TObject);
begin
     SetLength(ShopTasks, 0);
    idx_Task_Executing := 0;
    SetLength(ShopTasks_SIMUL, 0);
    idx_Task_Executing_SIMUL := 0;
    SetLength(ShopTasks_SIMUL1, 0);
    idx_Task_Executing_SIMUL1 := 0;
    ActionExecuted := False;
    Contador := 1;
end;



procedure TFormDispatcher.Timer1Timer(Sender: TObject);
begin
  BExecuteClick(Self);
end;

procedure TFormDispatcher.UPD_INFOTimer(Sender: TObject);
begin
  Button1Click(Self);
  temporizadores
end;


//Initialization of the MES /week. This procedure run only once per week
procedure TFormDispatcher.BInitiatilizeClick(Sender: TObject);
var
    cel, r, aux, j: integer;
    i : integer = 1;
begin
  // *********************************************************
  // WAREHOUSE
  // Initialization of parts in the first column of the warehouse.

  aux:=strtointdef(STOI_MPA.Text,0)+ strtointdef(STOI_MPV.Text,0) + strtointdef(STOI_MET.Text,0)+ strtointdef(STOI_BA.Text,0) + strtointdef(STOI_BV.Text,0) + strtointdef(STOI_TA.Text,0) + strtointdef(STOI_TV.Text,0)+ strtointdef(STOI_BMET.Text,0) + strtointdef(STOI_TMET.Text,0) ;

  if aux > 6 then begin  // às vezes buga
     // Display an error dialog with an error icon
     MessageDlg('Número de Stock existente excedido.(Max:6) Por favor reinicie o programa! E planeie a base de dados para um stock inicial de (6)!)', mtError, [mbOK], 0);
   end else begin
     // Se aux <= 6, então o código abaixo é executado

  r:=0;
  SetLength(AR_Parts,54);
  for cel:=0 to Length(AR_Parts)-1 do
  begin
    AR_Parts[cel]:=0
  end;

  for j:=1 to strtointdef(STOI_MPA.Text,0) do
  begin
    r:=r+M_Initialize(i, 1);
    AR_Parts[i-1]:=1;
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(STOI_MPV.Text,0) do
  begin
    r:=r+M_Initialize(i, 2);
    AR_Parts[i-1]:=2;
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(STOI_BA.Text,0) do
  begin
    r:=r+M_Initialize(i, 4);
    AR_Parts[i-1]:=4;
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(STOI_BV.Text,0) do
  begin
    r:=r+M_Initialize(i, 5);
    AR_Parts[i-1]:=5;
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(STOI_TA.Text,0) do
  begin
    r:=r+M_Initialize(i, 7);
    AR_Parts[i-1]:=7;
    i := i+9;
    sleep(1500);
  end;

  for j:=1 to strtointdef(STOI_TV.Text,0) do
  begin
    r:=r+M_Initialize(i, 8);
    AR_Parts[i-1]:=8;
    i := i+9;
    sleep(1500);
  end;


for j:=1 to strtointdef(STOI_MET.Text,0) do
begin
  r:=r+M_Initialize(i, 3);
  AR_Parts[i-1]:=3;
  i := i+9;
  sleep(1500);
end;


for j:=1 to strtointdef(STOI_BMET.Text,0) do
begin
  r:=r+M_Initialize(i, 6);
  AR_Parts[i-1]:=6;
  i := i+9;
  sleep(1500);
end;


for j:=1 to strtointdef(STOI_TMET.Text,0) do
begin
  r:=r+M_Initialize(i, 9);
  AR_Parts[i-1]:=9;
  i := i+9;
  sleep(1500);
end;


  if (r>aux) then
  begin
     Memo1.Append('Initialization with erros');
  end;


  SimpleScheduler(Production_Orders, ShopTasks);
  SimpleScheduler(Production_Orders_SIMUL, ShopTasks_SIMUL);
  SimpleScheduler(Expedition_Orders_SIMUL, ShopTasks_SIMUL1);

  Timer1.Enabled:= true;
  UPD_INFO.Enabled:= true;
end;

end;


// get the first position (cell) in AR that contains the "Part"
function TFormDispatcher.GET_AR_Position (Part : integer; Warehouse : array of integer): integer;
var
    i : integer;
begin
  for i := 0 to Length(Warehouse)-1 do
  begin
      if Warehouse[i] = Part then
      begin
          result := i + 1;
          Exit;
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
  if(Length(ShopTasks)>0) then begin
    Dispatcher(ShopTasks, idx_Task_Executing, ShopResources);

  end;
  if(Length(ShopTasks_SIMUL)>0) then begin
    Dispatcher(ShopTasks_SIMUL, idx_Task_Executing_SIMUL, ShopResources);
    end;

  if(Length(ShopTasks_SIMUL1)>0) then begin
    Dispatcher(ShopTasks_SIMUL1, idx_Task_Executing_SIMUL1, ShopResources);
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
          if(tasks[idx].current_operation = EXP_Finished) then
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
          if(tasks[idx].current_operation = EXP_Finished) then
          begin
            inc(idx);
          end;
        end;
      end;


      //Delivery
      Type_Delivery :
      begin
        if(idx < Length(tasks)) then
        begin
          Memo1.Append('Task Delivery');
          Execute_Delivery_Order(tasks[idx], shopfloor);

          // Next Operation to be executed.
          if(tasks[idx].current_operation = EXP_Finished) then
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


// Procedure that executes an expedition order according to SLIDE 19 of T classes.
procedure TFormDispatcher.Execute_Expedition_Order(var task:TTask; shopfloor: TResources );
var
    r : integer;
begin
//  TStage      = (EXP_To_Be_Started = 1, EXP_GetPart, EXP_Unload, EXP_TO_AR_OUT, EXP_Clear_Pos_AR, EXP_Finished);   //TbC
  with task do
  begin
     case current_operation of
        // To be Started
        EXP_To_Be_Started:
        begin
           current_operation :=  EXP_GetPart;
        end;

        // Getting a Position in the Warehouse
        EXP_GetPart :
        begin
          if(shopfloor.AR_free) then  //AR is free
          begin
            Part_Position_AR := GET_AR_Position(Part_Type, AR_Parts);
            Memo1.Append(IntToStr(Part_Position_AR));

            if( Part_Position_AR > 0 ) then
            begin
               current_operation :=  EXP_Unload;
            end
            else
            begin
               current_operation :=  EXP_GetPart;
            end;
          end;
        end;

        // Request the EXP_Unload of part
        EXP_Unload :
        begin
        sina_exp :=0;
        if Part_type = 4 then begin
    // Assume que o caso 4 é específico para BA
    SINA_EXP_BA.Color := clYellow;
    sina_exp :=1;
  end else if Part_type = 5 then begin
    // Caso 5 para BV
    SINA_EXP_BV.Color := clYellow;
    sina_exp :=1;
  end else if Part_type = 6 then begin
    // Caso 6 para BM
    SINA_EXP_BM.Color := clYellow;
    sina_exp :=1;
  end else if Part_type = 7 then begin
    // Caso 7 para TA
    SINA_EXP_TA.Color := clYellow;
    sina_exp :=1;
  end else if Part_type = 8 then begin
    // Caso 8 para TV
    SINA_EXP_TV.Color := clYellow;
    sina_exp :=1;
  end else if Part_type = 9 then begin
    // Caso 9 para TM
    SINA_EXP_TM.Color := clYellow;
    sina_exp :=1;
  end;
          Memo1.Append('AR EXP_Unloading: ' + IntToStr(Part_Position_AR));
          r := M_Unload(Part_Position_AR);

          if ( r = 1 ) then                                 //sucess
             current_operation :=  EXP_TO_AR_OUT;
        end;

        // Part in the output conveyor
        EXP_TO_AR_OUT :
        begin
          if( ShopResources.AR_Out_Part  = Part_Type ) then
          begin
            r := M_Do_Expedition(Part_Destination);          // Expedition

            if( r = 1) then                                  // sucess
             current_operation :=  EXP_Clear_Pos_AR;
          end;

        end;

        //Updated AR (removing the part from the position)
        EXP_Clear_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, 0, AR_Parts);
          current_operation :=  EXP_Finished;

          if Part_type = 4 then begin
    // Assume que o caso 4 é específico para BA
    SINA_EXP_BA.Color := clWhite;
    sina_exp :=0;
  end else if Part_type = 5 then begin
    // Caso 5 para BV
    SINA_EXP_BV.Color := clWhite;
    sina_exp :=0;
  end else if Part_type = 6 then begin
    // Caso 6 para BM
    SINA_EXP_BM.Color := clWhite;
    sina_exp :=0;
  end else if Part_type = 7 then begin
    // Caso 7 para TA
    SINA_EXP_TA.Color := clWhite;
    sina_exp :=0;
  end else if Part_type = 8 then begin
    // Caso 8 para TV
    SINA_EXP_TV.Color := clWhite;
    sina_exp :=0;
  end else if Part_type = 9 then begin
    // Caso 9 para TM
    SINA_EXP_TM.Color := clWhite;
    sina_exp :=0;
  end;

        end;

        //Done.
        EXP_Finished :
        begin
          current_operation :=  EXP_Finished;
        end;
      end;
  end;
end;


// Procedure that executes a production order
procedure TFormDispatcher.Execute_Production_Order(var task:TTask; shopfloor: TResources );
var
    r : integer = 0;
    rm : integer; // materia prima
begin

  with task do
  begin
     // obter a materia prima certa
     if (Part_type < 7) then
     begin

       rm := Part_Type - 3;
     end
     else
     begin

       rm := Part_Type -6;
     end;

     case current_operation of
        // To be Started
        EXP_To_Be_Started:
        begin
           current_operation :=  EXP_GetPart;
        end;

        // Getting a Position in the Warehouse
        EXP_GetPart :
        begin
          if(shopfloor.AR_free) then  //AR is free
          begin
            Part_Position_AR := GET_AR_Position(rm, AR_Parts);
            Memo1.Append(IntToStr(Part_Position_AR));

            if( Part_Position_AR > 0 ) then
            begin
               current_operation :=  EXP_Unload;
            end
            else
            begin
               current_operation :=  EXP_GetPart;
            end;
          end;
        end;

        // Request the Unload of part
        EXP_Unload :
        begin
          Memo1.Append('AR Prod_Unloading: ' + IntToStr(Part_Position_AR));
          r := M_Unload(Part_Position_AR);           //load

          if ( r = 1 ) then                                 //success
             current_operation :=  EXP_TO_AR_OUT;
          end;

        // Part in the output conveyor
        EXP_TO_AR_OUT :
        begin
          if( ShopResources.AR_Out_Part  = rm ) then
          begin
            r := M_Do_Production(Part_Destination);          // Production

            if( r = 1) then                                  // success
             current_operation :=  EXP_Clear_Pos_AR;
          end;
        end;

        //Updated AR (removing the part from the position)
        EXP_Clear_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, 0, AR_Parts);   //update array
          current_operation :=  Load;
        end;

        // request the load of part
        Load:
        begin
          sleep(200);
          Part_Position_AR := GET_AR_Position(0, AR_Parts);
          if( ShopResources.AR_In_Part  = Part_Type ) then
          begin
               Memo1.Append('AR Loading: ' + IntToStr(Part_Position_AR));
               r := M_Load(Part_Position_AR);            // fazer load
          end;

          if ( r = 1 ) then              //success
          begin
             current_operation :=  Insert_Pos_AR;
          end
        end;

        //Updated AR (inserting the part in the position)
        Insert_Pos_AR :
        begin
          SET_AR_Position(Part_Position_AR, Part_Type, AR_Parts);   // atulaizar o armazem
          current_operation :=  EXP_Finished;
        end;

        //Done.
        EXP_Finished :
        begin
          current_operation :=  EXP_Finished;
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
        EXP_To_Be_Started:
        begin
           current_operation :=  Set_Position;
        end;

        // Setting a Position in the Warehouse
        Set_Position :
        begin
          if(shopfloor.AR_free) then  //AR is free
          begin
            if Part_type = 1 then begin

    SINA_ENT_A.Color := clYellow;
    //sina_exp :=1;
  end else if Part_type = 2 then begin

    SINA_ENT_V.Color := clYellow;
    //sina_exp :=1;
  end else if Part_type = 3 then begin

    SINA_ENT_M.Color := clYellow;
    //sina_exp :=1;
    end;
            Part_Position_AR := GET_AR_Position(0, AR_Parts);
            Memo1.Append(IntToStr(Part_Position_AR));

            if( Part_Position_AR > 0 ) then
            begin
               current_operation :=  TO_AR_IN;
            end
            else
            begin
               current_operation :=  Set_Position;
            end;
          end;
        end;

        // Part in the input conveyor
        TO_AR_IN :
        begin
            r := M_Do_Inbound(Part_Type);             // do Inbound

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
          if Part_type = 1 then begin
    SINA_ENT_A.Color := clWhite;
  end else if Part_type = 2 then begin
    SINA_ENT_V.Color := clWhite;
  end else if Part_type = 3 then begin
    SINA_ENT_M.Color := clWhite;
    end;

          current_operation :=  EXP_Finished;

     end;
        //Done.
        EXP_Finished :
        begin
          current_operation :=  EXP_Finished;
        end;
      end;
  end;
end;


procedure TFormDispatcher.Button1Click(Sender: TObject);         //Update Memos
var
    MPA_STOI : integer;
    MPV_STOI : integer;
    MPM_STOI : integer;
    BA_STOI : integer;
    BV_STOI : integer;
    BM_STOI : integer; //6
    TA_STOI : integer;
    TV_STOI : integer;
    TM_STOI : integer; //9
    BA_PROD : integer = 0;
    BV_PROD : integer = 0;
    BM_PROD : integer = 0; //6
    TA_PROD : integer = 0;
    TV_PROD : integer = 0;
    TM_PROD : integer = 0; // 9
    BA_EXP : integer = 0;
    BV_EXP : integer = 0;
    BM_EXP : integer = 0; //6
    TA_EXP : integer = 0;
    TV_EXP : integer = 0;
    TM_EXP : integer = 0; //9
    MPA_IN :integer = 0;
    MPV_IN : integer = 0;
    MPM_IN : integer = 0; //3
    BA_SINA : integer = 0;
    BV_SINA : integer = 0;
    BM_SINA : integer = 0; //6
    TA_SINA : integer = 0;
    TV_SINA : integer = 0;
    TM_SINA : integer = 0; //9
    Total_PROD : integer = 0;
    Total_EXP : integer = 0;
    PERC_CONC : DOUBLE = 0;
    E_BA :  integer;
    E_BV : integer;
    E_BM : integer;
    E_TA : integer;
    E_TV : integer;
    E_TM : integer;
    P_BA : integer;
    P_BV : integer;
    P_BM : integer;
    P_TA : integer;
    P_TV : integer;
    P_TM : integer;
    i:integer;
    j:integer;
    k: integer;
    Tasks : TArray_Task;
begin
  MPA_STOI := strtointdef(STOI_MPA.Text, 0);
  MPV_STOI := strtointdef(STOI_MPV.Text, 0);
  MPM_STOI := strtointdef(STOI_MET.Text, 0); //3
  BA_STOI := strtointdef(STOI_BA.Text, 0);
  BV_STOI := strtointdef(STOI_BV.Text, 0);
  BM_STOI := strtointdef(STOI_BMET.Text, 0); //6
  TA_STOI := strtointdef(STOI_TA.Text, 0);
  TV_STOI := strtointdef(STOI_TV.Text, 0);
  TM_STOI := strtointdef(STOI_TMET.Text, 0); //9

  P_BA := strtointdef(PROD_BA.Text, 0);
  P_BV := strtointdef(PROD_BV.Text, 0);
  P_BM := strtointdef(PROD_BMET.Text, 0);
  P_TA := strtointdef(PROD_TA.Text, 0);
  P_TV := strtointdef(PROD_TV.Text, 0);
  P_TM := strtointdef(PROD_TMET.Text, 0);

  E_BA := strtointdef(EXP_BA.Text, 0);
  E_BV := strtointdef(EXP_BV.Text, 0);
  E_BM := strtointdef(EXP_BMET.Text, 0);
  E_TA := strtointdef(EXP_TA.Text, 0);
  E_TV := strtointdef(EXP_TV.Text, 0);
  E_TM := strtointdef(EXP_TMET.Text, 0);

  TOTAL_PROD := P_BA + P_BV + P_BM + P_TA + P_TV + P_TM;
  TOTAL_EXP :=  E_BA + E_BV + E_BM + E_TA + E_TV + E_TM;


  //juntar as duas shoptasks
  SetLength(Tasks, length(ShopTasks) + length(ShopTasks_SIMUL));

  for i:=0 to length(ShopTasks)-1 do
  begin
    Tasks[i] := ShopTasks[i];
  end;
  for j:=0 to length(ShopTasks_SIMUL)-1 do
  begin
    Tasks[i+j+1] := ShopTasks_SIMUL[j];
  end;

SetLength(Tasks, Length(Tasks) + Length(ShopTasks_SIMUL1));


for k:=0 to Length(ShopTasks_SIMUL1)-1 do
begin
  Tasks[Length(ShopTasks) + Length(ShopTasks_SIMUL) + k] := ShopTasks_SIMUL1[k];
end;

  for i:=0 to length(Tasks)-1 do
  begin
    //production Finished aumentar produção e Stock de produto final e diminuir sinalizador
    if (Tasks[i].task_type = Type_Production) and (Tasks[i].current_operation = EXP_Finished) then
    begin
      if Tasks[i].Part_type = 4 then                //inserir aqui as querys de update
      begin
           BA_PROD := BA_PROD +1;
           BA_STOI := BA_STOI +1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(BA_STOI) + ' WHERE id = 4');
           BA_SINA := BA_SINA -1;
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           BV_PROD := BV_PROD +1;
           BV_STOI := BV_STOI +1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(BV_STOI) + ' WHERE id = 5');
           BV_SINA := BV_SINA -1;
      end;
      if Tasks[i].Part_Type = 6 then
      begin
           BM_PROD := BM_PROD +1;
           BM_STOI := BM_STOI +1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(BM_STOI) + ' WHERE id = 6');
           BM_SINA := BM_SINA -1;
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           TA_PROD := TA_PROD +1;
           TA_STOI := TA_STOI +1;
           TA_SINA := TA_SINA -1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(TA_STOI) + ' WHERE id = 7');
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         TV_PROD := TV_PROD +1;
         TV_STOI := TV_STOI +1;
         TV_SINA := TV_SINA -1;
         PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(TV_STOI) + ' WHERE id = 8');
      end;
      if Tasks[i].Part_Type = 9 then
      begin
         TM_PROD := TM_PROD +1;
         TM_STOI := TM_STOI +1;
         TM_SINA := TM_SINA -1;
         PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(TM_STOI) + ' WHERE id = 9');
      end;
    end;
    // production Unload: diminuir Stock de mp e aumentar sinalizador
    if (Tasks[i].task_type = Type_Production) and (Tasks[i].current_operation > EXP_Unload) then
    begin

      if Tasks[i].Part_type = 4 then
      begin
           MPA_STOI := MPA_STOI -1;
           BA_SINA := BA_SINA +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPA_STOI) + ' WHERE id = 1');

      end;
      if Tasks[i].Part_Type = 5 then
      begin
           MPV_STOI := MPV_STOI -1;
           BV_SINA := BV_SINA +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPV_STOI) + ' WHERE id = 2');
      end;
      if Tasks[i].Part_Type = 6 then
      begin
           MPM_STOI := MPM_STOI -1;
           BM_SINA := BM_SINA +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPM_STOI) + ' WHERE id = 3');
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           MPA_STOI := MPA_STOI -1;
           TA_SINA := TA_SINA +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPA_STOI) + ' WHERE id = 1');
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         MPV_STOI := MPV_STOI -1;
         TV_SINA := TV_SINA +1;
         PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPV_STOI) + ' WHERE id = 2');
      end;
      if Tasks[i].Part_Type = 9 then
      begin
         MPM_STOI := MPM_STOI -1;
         TM_SINA := TM_SINA +1;
         PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPM_STOI) + ' WHERE id = 3');
      end;
    end;
    //Expedition finished aumentar No de expedição
    if (Tasks[i].task_type = Type_Expedition) and (Tasks[i].current_operation = EXP_Finished) then
    begin
      if Tasks[i].Part_type = 4 then
      begin
           BA_EXP := BA_EXP +1;
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           BV_EXP := BV_EXP +1;
      end;
      if Tasks[i].Part_Type = 6 then
      begin
           BM_EXP := BM_EXP +1;
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           TA_EXP := TA_EXP +1;
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         TV_EXP := TV_EXP +1;
      end;
      if Tasks[i].Part_Type = 9 then
      begin
         TM_EXP := TM_EXP +1;
      end;
    end;
    //Unload da expedition  menos STOck de produto final
    if (Tasks[i].task_type = Type_Expedition) and (Tasks[i].current_operation > EXP_Unload) then
    begin
      if Tasks[i].Part_type = 4 then
      begin
           BA_STOI := BA_STOI -1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(BA_STOI) + ' WHERE id = 4');
      end;
      if Tasks[i].Part_Type = 5 then
      begin
           BV_STOI := BV_STOI -1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(BV_STOI) + ' WHERE id = 5');
      end;
      if Tasks[i].Part_Type = 6 then
      begin
           BM_STOI := BM_STOI -1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(BM_STOI) + ' WHERE id = 6');
      end;
      if Tasks[i].Part_Type = 7 then
      begin
           TA_STOI := TA_STOI -1;
           PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(TA_STOI) + ' WHERE id = 7');
      end;
      if Tasks[i].Part_Type = 8 then
      begin
         TV_STOI := TV_STOI -1;
         PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(TV_STOI) + ' WHERE id = 8');
      end;
      if Tasks[i].Part_Type = 9 then
      begin
         TM_STOI := TM_STOI -1;
         PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + inttostr(TM_STOI) + ' WHERE id = 9');
      end;
    end;
    //Delivery finished  + stock de matéria-prima.
    if (Tasks[i].task_type = Type_Delivery) and (Tasks[i].current_operation = EXP_Finished) then

    begin
      if Tasks[i].Part_type = 1 then
      begin
           MPA_IN := MPA_IN +1;
           MPA_STOI := MPA_STOI +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPA_STOI) + ' WHERE id = 1');
               // Atualizar weeks
               PQConnection1.ExecuteDirect('UPDATE sorders SET weekd = weekp + 1 WHERE status = ''planned'' and material_id = 1');

               // Atualizar o status na tabela sorders
               PQConnection1.ExecuteDirect('UPDATE sorders SET status = ''done'' WHERE status = ''planned'' and material_id = 1');
      end;
      if Tasks[i].Part_Type = 2 then
      begin
           MPV_IN := MPV_IN +1;
           MPV_STOI := MPV_STOI +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPV_STOI) + ' WHERE id = 2');

           // Atualizar weeks
           PQConnection1.ExecuteDirect('UPDATE sorders SET weekd = weekp + 1 WHERE status = ''planned'' and material_id = 2');

           // Atualizar o status na tabela sorders
           PQConnection1.ExecuteDirect('UPDATE sorders SET status = ''done'' WHERE status = ''planned'' and material_id = 2');
      end;
      if Tasks[i].Part_Type = 3 then
      begin
           MPM_IN := MPM_IN +1;
           MPM_STOI := MPM_STOI +1;
           PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + inttostr(MPM_STOI) + ' WHERE id = 3');

           // Atualizar weeks
               PQConnection1.ExecuteDirect('UPDATE sorders SET weekd = weekp + 1 WHERE status = ''planned'' and material_id = 3');

               // Atualizar o status na tabela sorders
               PQConnection1.ExecuteDirect('UPDATE sorders SET status = ''done'' WHERE status = ''planned'' and material_id = 3');
      end;
    end;
  end;



  // append das Memo
  Memo_BA_PROD.Append(inttostr(BA_PROD));
  Memo_BV_PROD.Append(inttostr(BV_PROD));
  Memo_BM_PROD.Append(inttostr(BM_PROD));
  Memo_TA_PROD.Append(inttostr(TA_PROD));
  Memo_TV_PROD.Append(inttostr(TV_PROD));
  Memo_TM_PROD.Append(inttostr(TM_PROD));
  Memo60.append(inttostr(BA_PROD + BV_PROD + BM_PROD + TA_PROD + TV_PROD + TM_PROD));

  Memo_BA_EXP.Append(inttostr(BA_EXP));
  Memo_BV_EXP.Append(inttostr(BV_EXP));
  Memo_BM_EXP.Append(inttostr(BM_EXP));
  Memo_TA_EXP.Append(inttostr(TA_EXP));
  Memo_TV_EXP.Append(inttostr(TV_EXP));
  Memo_TM_EXP.Append(inttostr(TM_EXP));
  Memo61.append(inttostr(BA_EXP + BV_EXP + BM_EXP + TA_EXP + TV_EXP + TM_EXP));


  // inbound
  Memo_MPA_INB.Append(inttostr(MPA_IN));
  Memo_MPV_INB.Append(inttostr(MPV_IN));
  Memo_MPM_INB.Append(inttostr(MPM_IN));


  // stock corrente
  Memo_MPA_STOI_C.Append(inttostr(MPA_STOI));
  Memo_MPV_STOI_C.Append(inttostr(MPV_STOI));
  Memo_MPM_STOI_C.Append(inttostr(MPM_STOI));
  Memo_BA_STOI_C.Append(inttostr(BA_STOI));
  Memo_BV_STOI_C.Append(inttostr(BV_STOI));
  Memo_BM_STOI_C.Append(inttostr(BM_STOI));
  Memo_TA_STOI_C.Append(inttostr(TA_STOI));
  Memo_TV_STOI_C.Append(inttostr(TV_STOI));
  Memo_TM_STOI_C.Append(inttostr(TM_STOI));

  // Pedidos de produção
  Memo_BA_PRODR.Append(inttostr(P_BA));
  Memo_BV_PRODR.Append(inttostr(P_BV));
  Memo_BM_PRODR.Append(inttostr(P_BM));
  Memo_TA_PRODR.Append(inttostr(P_TA));
  Memo_TV_PRODR.Append(inttostr(P_TV));
  Memo_TM_PRODR.Append(inttostr(P_TM));
  Memo_totalprod.append(inttostr(Total_prod));

  // Pedidos de expedição
  Memo_BA_EXPR.Append(inttostr(E_BA));
  Memo_BV_EXPR.Append(inttostr(E_BV));
  Memo_BM_EXPR.Append(inttostr(E_BM));
  Memo_TA_EXPR.Append(inttostr(E_TA));
  Memo_TV_EXPR.Append(inttostr(E_TV));
  Memo_TM_EXPR.Append(inttostr(E_TM));
  Memo_totalexp.append(inttostr(Total_exp));

  PERC_CONC :=((BA_PROD + BV_PROD + BM_PROD + TA_PROD + TV_PROD + TM_PROD + BA_EXP + BV_EXP + BM_EXP + TA_EXP + TV_EXP + TM_EXP + MPA_IN+ MPV_IN + MPM_IN  )/ (length(ShopTasks) + length(ShopTasks_SIMUL) + length(ShopTasks_SIMUL1)) *100);

  Memo_perc_conc.append(FormatFloat('0.0', PERC_CONC));

  // Verifica se PERC_CONC é 100 e se a ação ainda não foi executada
   if (PERC_CONC = 100) and (not ActionExecuted) then
   begin
     // Executar o evento OnClick do doneparaBD
     doneparaBDClick(Self);

     // Marcar a ação como executada
     ActionExecuted := True;
     Application.MessageBox('Percentagem de conclusão 100%. Feche o programa e bom fim de semana','Alert');
   end;

  if BA_SINA > 0 then
  begin
     SINA_PROD_BA.Color := clYellow;
     SINA_PROD_BA.Font.Color := clWhite;
  end
  else
  begin
     SINA_PROD_BA.Color := clWhite;
     SINA_PROD_BA.Font.Color := clBlack; // Ajustado para clBlack para melhor contraste
  end;

  if BV_SINA > 0 then
  begin
     SINA_PROD_BV.Color := clYellow;
     SINA_PROD_BV.Font.Color := clWhite;
  end
  else
  begin
     SINA_PROD_BV.Color := clWhite;
     SINA_PROD_BV.Font.Color := clBlack;
  end;

  if BM_SINA > 0 then
  begin

     SINA_PROD_BM.color := clYellow;
     SINA_PROD_BM.Font.Color := clWhite ;
  end
  else
  begin

     SINA_PROD_BM.color := clWhite;
     SINA_PROD_BM.Font.Color := clBlack ;
  end;

  if TA_SINA > 0 then
  begin
     SINA_PROD_TA.Color := clYellow;
     SINA_PROD_TA.Font.Color := clWhite;
  end
  else
  begin
     SINA_PROD_TA.Color := clWhite;
     SINA_PROD_TA.Font.Color := clBlack;
  end;

  if TV_SINA > 0 then
  begin
     SINA_PROD_TV.Color := clYellow;
     SINA_PROD_TV.Font.Color := clWhite;
  end
  else
  begin
     SINA_PROD_TV.Color := clWhite;
     SINA_PROD_TV.Font.Color := clBlack;
  end;

  if TM_SINA > 0 then
  begin
     SINA_PROD_TM.Color := clYellow;
     SINA_PROD_TM.Font.Color := clWhite;
  end
  else
  begin
     SINA_PROD_TM.Color := clWhite;
     SINA_PROD_TM.Font.Color := clBlack;
  end;

  if BA_SINA > 0 then
  begin
     SINA_PROD_BA.Color := clYellow;
     SINA_PROD_BA.Font.Color := clWhite;
  end
  else
  begin
     SINA_PROD_BA.Color := clWhite;
     SINA_PROD_BA.Font.Color := clBlack; // Ajustado para clBlack para melhor contraste
  end;

  if P_BA = BA_PROD then
  begin
     Memo_BA_PRODR.Color := clGreen;
     Memo_BA_PRODR.Font.Color := clWhite;
     if (BA_PROD >= 1) and (not ActionExecuted) then
     begin
       PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 4');
     end;
  end
  else
  begin
     Memo_BA_PRODR.Color := clWhite;
     Memo_BA_PRODR.Font.Color := clBlack; // Ajustado para clBlack para melhor contraste
  end;

  if P_BV = BV_PROD then
  begin
     Memo_BV_PRODR.Color := clGreen;
     Memo_BV_PRODR.Font.Color := clWhite;
     if (BV_PROD >= 1) and (not ActionExecuted) then
     begin
       PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 5');
     end;
  end
  else
  begin
     Memo_BV_PRODR.Color := clWhite;
     Memo_BV_PRODR.Font.Color := clBlack;
  end;

  if P_BM = BM_PROD then
  begin
     Memo_BM_PRODR.Color := clGreen;
     Memo_BM_PRODR.Font.Color := clWhite;
     if (BM_PROD >= 1) and (not ActionExecuted)  then
     begin
       PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 6');
     end;
  end
  else
  begin
     Memo_BM_PRODR.Color := clWhite;
     Memo_BM_PRODR.Font.Color := clBlack;
  end;

  if P_TA = TA_PROD then
  begin
     Memo_TA_PRODR.Color := clGreen;
     Memo_TA_PRODR.Font.Color := clWhite;
     if (TA_PROD >= 1) and (not ActionExecuted) then
     begin
       PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 7');
     end;
  end
  else
  begin
     Memo_TA_PRODR.Color := clWhite;
     Memo_TA_PRODR.Font.Color := clBlack;
  end;

  if P_TV = TV_PROD then
  begin
     Memo_TV_PRODR.Color := clGreen;
     Memo_TV_PRODR.Font.Color := clWhite;
     if (TV_PROD >= 1) and (not ActionExecuted)  then
     begin
       PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 8');
     end;
  end
  else
  begin
     Memo_TV_PRODR.Color := clWhite;
     Memo_TV_PRODR.Font.Color := clBlack;
  end;

  if P_TM = TM_PROD then
  begin
     Memo_TM_PRODR.Color := clGreen;
     Memo_TM_PRODR.Font.Color := clWhite;
     if (TM_PROD >= 1) and (not ActionExecuted)  then
     begin
       PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 9');
     end;
  end
  else
  begin
     Memo_TM_PRODR.Color := clWhite;
     Memo_TM_PRODR.Font.Color := clBlack;
  end;


  if E_BA = BA_EXP then
  begin
     Memo_BA_EXPR.Color := clGreen;
     Memo_BA_EXPR.Font.Color := clWhite;
     // atualiza para done e a weekd
     if (BA_EXP >= 1) and (not ActionExecuted) then
     begin
       PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 4');
       //PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'', weekd = weekp + 1 WHERE corder_id IN (SELECT corder_id FROM corders WHERE product_id = 4 AND status = ''done'')');
     end;
  end
  else
  begin
     Memo_BA_EXPR.Color := clWhite;
     Memo_BA_EXPR.Font.Color := clBlack; // Ajustado para clBlack para melhor contraste
  end;

  if E_BV = BV_EXP then
  begin
     Memo_BV_EXPR.Color := clGreen;
     Memo_BV_EXPR.Font.Color := clWhite;
     // atualiza para done e a weekd
     if (BV_EXP >= 1) and (not ActionExecuted) then
     begin
       PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 5');
       //PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'', weekd = weekp + 1 WHERE corder_id IN (SELECT corder_id FROM corders WHERE id = 5 AND status = ''done'')');
     end;
  end
  else
  begin
     Memo_BV_EXPR.Color := clWhite;
     Memo_BV_EXPR.Font.Color := clBlack;
  end;

  if E_BM = BM_EXP then
  begin
     Memo_BM_EXPR.Color := clGreen;
     Memo_BM_EXPR.Font.Color := clWhite;
     // atualiza para done e a weekd
     if (BM_EXP >= 1) and (not ActionExecuted)  then
     begin
       PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 6');
       //PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'', weekd = weekp + 1 WHERE corder_id IN (SELECT corder_id FROM corders WHERE id = 6 AND status = ''done'')');
     end;
  end
  else
  begin
     Memo_BM_EXPR.Color := clWhite;
     Memo_BM_EXPR.Font.Color := clBlack;
  end;

  if E_TA = TA_EXP then
  begin
     Memo_TA_EXPR.Color := clGreen;
     Memo_TA_EXPR.Font.Color := clWhite;
     // atualiza para done e a weekd
     if (TA_EXP >= 1) and (not ActionExecuted)  then
     begin
       PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 7');
       //PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'', weekd = weekp + 1 WHERE corder_id IN (SELECT corder_id FROM corders WHERE id = 7 AND status = ''done'')');
     end;
  end
  else
  begin
     Memo_TA_EXPR.Color := clWhite;
     Memo_TA_EXPR.Font.Color := clBlack;
  end;

  if E_TV = TV_EXP then
  begin
     Memo_TV_EXPR.Color := clGreen;
     Memo_TV_EXPR.Font.Color := clWhite;
     // atualiza para done e a weekd
     if (TV_EXP >= 1) and (not ActionExecuted)  then
     begin
       PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 8');
       //PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'', weekd = weekp + 1 WHERE corder_id IN (SELECT corder_id FROM corders WHERE id = 8 AND status = ''done'')');
     end;
  end
  else
  begin
     Memo_TV_EXPR.Color := clWhite;
     Memo_TV_EXPR.Font.Color := clBlack;
  end;

  if E_TM = TM_EXP then
  begin
     Memo_TM_EXPR.Color := clGreen;
     Memo_TM_EXPR.Font.Color := clWhite;
     // atualiza para done e a weekd
     if (TM_EXP >= 1) and (not ActionExecuted) then
     begin
       PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1, status = ''done'' WHERE status = ''planned'' AND product_id = 9');
       //PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'', weekd = weekp + 1 WHERE corder_id IN (SELECT corder_id FROM corders WHERE id = 9 AND status = ''done'')');
     end;
  end
  else
  begin
     Memo_TM_EXPR.Color := clWhite;
     Memo_TM_EXPR.Font.Color := clBlack;
  end;


  if ShopResources.Robot_1_Part > 0 then
  begin
     Memo_MAQB.clear();
     Memo_MAQB.color := clRed;
     Memo_MAQB.Append('Ocupado');
     Memo_MAQB.Font.Color := clWhite ;
  end
  else
  begin
     Memo_MAQB.clear();
     Memo_MAQB.color := clGreen;
     Memo_MAQB.Append('Livre');
     Memo_MAQB.Font.Color := clWhite ;
  end;
  if ShopResources.Robot_2_Part > 0 then
  begin
     Memo_MAQT.clear();
     Memo_MAQT.color := clRed;
     Memo_MAQT.Append('A Trabalhar');
     Memo_MAQT.Font.Color := clWhite ;
  end
  else
  begin
     Memo_MAQT.clear();
     Memo_MAQT.color := clGreen;
     Memo_MAQT.Append('Livre');
     Memo_MAQT.Font.Color := clWhite ;
  end;


  if ShopResources.Inbound_free then
  begin
     Memo_Inb.Clear(); // Limpa o Memo relacionado ao Inbound_text
     Memo_Inb.Color := clGreen; // Define a cor de fundo para verde
     Memo_Inb.Append('Livre'); // Adiciona texto indicando que o Inbound_text está livre
     Memo_Inb.Font.Color := clWhite; // Define a cor da fonte para branco
  end
  else
  begin
     Memo_Inb.Clear(); // Limpa o Memo novamente para o caso de estar ocupado
     Memo_Inb.Color := clRed; // Define a cor de fundo para vermelho, indicando ocupação
     Memo_Inb.Append('Ocupado'); // Adiciona texto indicando que o Inbound_text está ocupado
     Memo_Inb.Font.Color := clWhite; // Mantém a cor da fonte como branco para contraste
  end;
    case ShopResources.Robot_1_Part of
  1: Image321.Visible:=True;
  2: Image331.Visible:=True;
  3: Image341.Visible:=True;
  0: begin
  Image321.Visible:=False;
  Image331.Visible:=False;
  Image341.Visible:=False;
  end;
end;

  case ShopResources.Robot_2_Part of
  1: Image351.Visible:=True;
  2: Image361.Visible:=True;
  3: Image371.Visible:=True;
  0: begin
  Image351.Visible:=False;
  Image361.Visible:=False;
  Image371.Visible:=False;
  end;
end;

end;

Procedure TFormDispatcher.Button2Click(Sender: TObject);
begin
  Memo2.Append(IntToStr(AR_Parts[0]));
  Memo3.Append(IntToStr(AR_Parts[1]));
  Memo4.Append(IntToStr(AR_Parts[2]));
  Memo5.Append(IntToStr(AR_Parts[3]));
  Memo6.Append(IntToStr(AR_Parts[4]));
  Memo7.Append(IntToStr(AR_Parts[5]));
  Memo8.Append(IntToStr(AR_Parts[6]));
  Memo9.Append(IntToStr(AR_Parts[7]));
  Memo10.Append(IntToStr(AR_Parts[8]));
  Memo11.Append(IntToStr(AR_Parts[9]));
  Memo12.Append(IntToStr(AR_Parts[10]));
  Memo13.Append(IntToStr(AR_Parts[11]));
  Memo14.Append(IntToStr(AR_Parts[12]));
  Memo15.Append(IntToStr(AR_Parts[13]));
  Memo16.Append(IntToStr(AR_Parts[14]));
  Memo17.Append(IntToStr(AR_Parts[15]));
  Memo18.Append(IntToStr(AR_Parts[16]));
  Memo19.Append(IntToStr(AR_Parts[17]));
  Memo20.Append(IntToStr(AR_Parts[18]));
  Memo21.Append(IntToStr(AR_Parts[19]));
  Memo22.Append(IntToStr(AR_Parts[20]));
  Memo23.Append(IntToStr(AR_Parts[21]));
  Memo24.Append(IntToStr(AR_Parts[22]));
  Memo25.Append(IntToStr(AR_Parts[23]));
  Memo26.Append(IntToStr(AR_Parts[24]));
  Memo27.Append(IntToStr(AR_Parts[25]));
  Memo28.Append(IntToStr(AR_Parts[26]));
  Memo29.Append(IntToStr(AR_Parts[27]));
  Memo30.Append(IntToStr(AR_Parts[28]));
  Memo31.Append(IntToStr(AR_Parts[29]));
  Memo32.Append(IntToStr(AR_Parts[30]));
  Memo33.Append(IntToStr(AR_Parts[31]));
  Memo34.Append(IntToStr(AR_Parts[32]));
  Memo35.Append(IntToStr(AR_Parts[33]));
  Memo36.Append(IntToStr(AR_Parts[34]));
  Memo37.Append(IntToStr(AR_Parts[35]));
  Memo38.Append(IntToStr(AR_Parts[36]));
  Memo39.Append(IntToStr(AR_Parts[37]));
  Memo40.Append(IntToStr(AR_Parts[38]));
  Memo41.Append(IntToStr(AR_Parts[39]));
  Memo42.Append(IntToStr(AR_Parts[40]));
  Memo43.Append(IntToStr(AR_Parts[41]));
  Memo44.Append(IntToStr(AR_Parts[42]));
  Memo45.Append(IntToStr(AR_Parts[43]));
  Memo46.Append(IntToStr(AR_Parts[44]));
  Memo47.Append(IntToStr(AR_Parts[45]));
  Memo48.Append(IntToStr(AR_Parts[46]));
  Memo49.Append(IntToStr(AR_Parts[47]));
  Memo50.Append(IntToStr(AR_Parts[48]));
  Memo51.Append(IntToStr(AR_Parts[49]));
  Memo52.Append(IntToStr(AR_Parts[50]));
  Memo53.Append(IntToStr(AR_Parts[51]));
  Memo54.Append(IntToStr(AR_Parts[52]));
  Memo55.Append(IntToStr(AR_Parts[53]));
end;



//atualizar valores da base de dados
procedure TFormDispatcher.doneparaBDClick(Sender: TObject);
begin
  // Reabrir a consulta para garantir que está atualizada
  SQLEorders.Active := False;
  SQLEorders.Active := True;

  //eorder
  // Atualizar weeks
  PQConnection1.ExecuteDirect('UPDATE eorders SET weekd = weekp + 1 WHERE status = ''planned''');

  // Atualizar o status na tabela eorders
  PQConnection1.ExecuteDirect('UPDATE eorders SET status = ''done'' WHERE status = ''planned''');


  //corders
  // Atualizar weeks na tabela corders
  PQConnection1.ExecuteDirect('UPDATE corders SET weekd = 1 WHERE status = ''accepted''');

  // Atualizar weeks
  PQConnection1.ExecuteDirect('UPDATE corders SET weekd = weekp + 1 WHERE status = ''planned'''); //somar null da null solução é por a 0

  // Atualizar o status na tabela corders
  PQConnection1.ExecuteDirect('UPDATE corders SET status = ''done'' WHERE status = ''planned''');


  //sorders
    // Atualizar weeks
  PQConnection1.ExecuteDirect('UPDATE sorders SET weekd = weekp + 1 WHERE status = ''planned''');

  // Atualizar o status na tabela sorders
  PQConnection1.ExecuteDirect('UPDATE sorders SET status = ''done'' WHERE status = ''planned''');


  //porders
  // Atualizar weeks
  PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp+1 WHERE status = ''accepted''');

  // Atualizar weeks
  PQConnection1.ExecuteDirect('UPDATE porders SET weekd = weekp + 1 WHERE status = ''planned''');

  // Atualizar o status na tabela porders
  PQConnection1.ExecuteDirect('UPDATE porders SET status = ''done'' WHERE status = ''planned''');

  // Atualizar o status na tabela porders
  PQConnection1.ExecuteDirect('UPDATE porders SET status = ''indicator'' WHERE status = ''accepted''');

  // Reabrir a consulta para garantir que está atualizada
  SQLEorders.Active := False;
  SQLEorders.Active := True;

  // Apresentar uma MessageBox
  //ShowMessage('Tarefa semanal finalizada. Planeie para segunda-feira e feche o programa. Bom fim de semana! (Datas de entrega atualizadas e tarefas atualizadas para done)');

end;

//atualizar a base de dados para a integração com a base de dados
procedure TFormDispatcher.atualizarBDparaliveClick(Sender: TObject);
begin
  PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + STOI_MPA.Text + ' WHERE id = 1');
  PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + STOI_MPV.Text + ' WHERE id = 2');
  PQConnection1.ExecuteDirect('UPDATE materials SET inventory = ' + STOI_MET.Text + ' WHERE id = 3');

  PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + STOI_BA.Text + ' WHERE id = 4');
  PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + STOI_BV.Text + ' WHERE id = 5');
  PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + STOI_BMET.Text + ' WHERE id = 6');
  PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + STOI_TA.Text + ' WHERE id = 7');
  PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + STOI_TV.Text + ' WHERE id = 8');
  PQConnection1.ExecuteDirect('UPDATE products SET inventory = ' + STOI_TMET.Text + ' WHERE id = 9');

end;

//importar os valores da base de dados
procedure TFormDispatcher.ImportarBDClick(Sender: TObject);
  var
      recordNumber : integer = 0;

      expBA         : integer = 0;
      expBV         : integer = 0;
      expBM         : integer = 0;
      expTA         : integer = 0;
      expTV         : integer = 0;
      expTM         : integer = 0;

      prodBA         : integer = 0;
      prodBV         : integer = 0;
      prodBM         : integer = 0;
      prodTA         : integer = 0;
      prodTV         : integer = 0;
      prodTM         : integer = 0;

      supA           : integer = 0;
      supV           : integer = 0;
      supM           : integer = 0;
  begin

    PQConnection1.Connected := True;
    PQConnection1.ExecuteDirect('Begin Work;');
    PQConnection1.ExecuteDirect('set idle_in_transaction_session_timeout = 0');
    PQConnection1.ExecuteDirect('set schema ''minierp''');
    PQConnection1.ExecuteDirect('Commit Work;');

    SQLEorders.Active := False;
    SQLPorders.Active := False;
    SQLSorders.Active := False;
    SQLProducts.Active := False;
    SQLMaterials.Active := False;

    SQLEorders.Active := True;
    SQLPorders.Active := True;
    SQLSorders.Active := True;
    SQLProducts.Active := True;
    SQLMaterials.Active := True;

    // Loop para percorrer todos os registros
    for recordNumber := 1 to SQLEorders.RecordCount do
    begin
      SQLEorders.RecNo := recordNumber;

      // Verificar se o status é 'planned' antes de processar
      if trim(SQLEorders.FieldByName('eorder_status').AsString) = 'planned' then
      begin
        if SQLEorders.FieldByName('product_id').AsInteger = 4 then
        begin
          expBA := expBA + SQLEorders.FieldByName('eorder_qt').AsInteger;
        end;

        if SQLEorders.FieldByName('product_id').AsInteger = 5 then
        begin
          expBV := expBV + SQLEorders.FieldByName('eorder_qt').AsInteger;
        end;

        if SQLEorders.FieldByName('product_id').AsInteger = 6 then
        begin
          expBM := expBM + SQLEorders.FieldByName('eorder_qt').AsInteger;
        end;

        if SQLEorders.FieldByName('product_id').AsInteger = 7 then
        begin
          expTA := expTA + SQLEorders.FieldByName('eorder_qt').AsInteger;
        end;

        if SQLEorders.FieldByName('product_id').AsInteger = 8 then
        begin
          expTV := expTV + SQLEorders.FieldByName('eorder_qt').AsInteger;
        end;

        if SQLEorders.FieldByName('product_id').AsInteger = 9 then
        begin
          expTM := expTM + SQLEorders.FieldByName('eorder_qt').AsInteger;
        end;
      end;
    end;

    EXP_BA.Text := IntToStr(expBA);
    EXP_BV.Text := IntToStr(expBV);
    EXP_BMET.Text := IntToStr(expBM);
    EXP_TA.Text := IntToStr(expTA);
    EXP_TV.Text := IntToStr(expTV);
    EXP_TMET.Text :=  IntToStr(expTM);


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

             if SQLPorders.FieldByName('product_id').AsInteger = 6 then
             begin
                  prodBM := prodBM + SQLPorders.FieldByName('porder_qtp').AsInteger;
             end;

             if SQLPorders.FieldByName('product_id').AsInteger = 7 then
             begin
                  prodTA := prodTA + SQLPorders.FieldByName('porder_qtp').AsInteger;
             end;

             if SQLPorders.FieldByName('product_id').AsInteger = 8 then
             begin
                  prodTV := prodTV + SQLPorders.FieldByName('porder_qtp').AsInteger;
             end;

             if SQLPorders.FieldByName('product_id').AsInteger = 9 then
             begin
                  prodTM := prodTM + SQLPorders.FieldByName('porder_qtp').AsInteger;
             end;

         end;

    end;

    PROD_BA.Text := IntToStr(prodBA);
    PROD_BV.Text := IntToStr(prodBV);
    PROD_BMET.Text := IntToStr(prodBM);
    PROD_TA.Text := IntToStr(prodTA);
    PROD_TV.Text := IntToStr(prodTV);
    PROD_TMET.Text := IntToStr(prodTM);


    // Loop para percorrer todos os registros
     for recordNumber := 1 to SQLSorders.RecordCount do
     begin
       SQLSorders.RecNo := recordNumber;

       // Verificar se o status é 'planned' antes de processar
       if trim(SQLSorders.FieldByName('Sorder_status').AsString) = 'planned' then
       begin
         if SQLSorders.FieldByName('material_id').AsInteger = 1 then
         begin
           supA := supA + SQLSorders.FieldByName('sorder_qt').AsInteger;
         end;

         if SQLSorders.FieldByName('material_id').AsInteger = 2 then
         begin
           supV := supV + SQLSorders.FieldByName('sorder_qt').AsInteger;
         end;

         if SQLSorders.FieldByName('material_id').AsInteger = 3 then
         begin
           supM := supM + SQLSorders.FieldByName('sorder_qt').AsInteger;
         end;
       end;
     end;

    INB_MPA.Text := IntToStr(supA);
    INB_MPV.Text := IntToStr(supV);
    INB_MET.Text := IntToStr(supM);


    for recordNumber := 1 to SQLProducts.RecordCount do                               //Buscar base de dados inventário produtos
    begin;
         SQLProducts.RecNo := recordNumber;

           if SQLProducts.FieldByName('product_id').AsInteger  = 4 then
           begin
                STOI_BA.Text := IntToStr( SQLProducts.FieldByName('product_inventory').AsInteger+ ExpBA - prodBA );
           end;

           if SQLProducts.FieldByName('product_id').AsInteger = 5 then
           begin
                STOI_BV.Text := IntToStr(SQLProducts.FieldByName('product_inventory').AsInteger+ ExpBV- prodBV);
           end;

           if SQLProducts.FieldByName('product_id').AsInteger = 6 then
           begin
                STOI_BMET.Text := Inttostr(SQLProducts.FieldByName('product_inventory').AsInteger + ExpBM - prodBM);
           end;

           if SQLProducts.FieldByName('product_id').AsInteger = 7 then
           begin
                STOI_TA.Text := Inttostr(SQLProducts.FieldByName('product_inventory').AsInteger + ExpTA - prodTA);
           end;

           if SQLProducts.FieldByName('product_id').AsInteger = 8 then
           begin
                STOI_TV.Text := Inttostr(SQLProducts.FieldByName('product_inventory').AsInteger + ExpTV - prodTV);
           end;

           if SQLProducts.FieldByName('product_id').AsInteger = 9 then
           begin
                STOI_TMET.Text := Inttostr(SQLProducts.FieldByName('product_inventory').AsInteger + ExpTM - prodTM);
           end;
  end;

    for recordNumber := 1 to SQLMaterials.RecordCount do                               //Buscar base de stock inicial das materias primas
    begin;
         SQLMaterials.RecNo := recordNumber;

           if SQLMaterials.FieldByName('material_id').AsInteger  = 1 then
           begin
                STOI_MPA.text := IntToStr( SQLMaterials.FieldByName('material_inventory').AsInteger+ prodBA + prodTA - supA );//+ prodBA + prodTA - supA
           end;

           if SQLMaterials.FieldByName('material_id').AsInteger = 2 then
           begin
                STOI_MPV.text := IntToStr(SQLMaterials.FieldByName('material_inventory').AsInteger+ prodBV + prodTV - supV );  //+ prodBV + prodTV - supV
           end;

           if SQLMaterials.FieldByName('material_id').AsInteger = 3 then
           begin
                STOI_MET.Text := Inttostr(SQLMaterials.FieldByName('material_inventory').AsInteger + prodBM + prodTM - supM ); //+ prodBM + prodTM - supM
           end;
  end;
end;

procedure TFormDispatcher.LimparTudoClick(Sender: TObject);
begin
    EXP_BA.Text := '';
    EXP_BV.Text := '';
    EXP_BMET.Text := '';
    EXP_TA.Text := '';
    EXP_TV.Text := '';
    EXP_TMET.Text := '';

    PROD_BA.Text := '';
    PROD_BV.Text := '';
    PROD_BMET.Text := '';
    PROD_TA.Text := '';
    PROD_TV.Text := '';
    PROD_TMET.Text := '';

    INB_MPA.Text := '';
    INB_MPV.Text := '';
    INB_MET.Text := '';

    STOI_MPA.text:='' ;
    STOI_MPV.text:='';
    STOI_MET.Text := '';
    STOI_BA.Text := '';
    STOI_BV.Text := '';
    STOI_BMET.Text := '';
    STOI_TA.Text := '';
    STOI_TV.Text := '';
    STOI_TMET.Text := '';
end;

procedure TFormDispatcher.temporizadores;
begin
  total_time_production := total_time_production + 1;
  if ShopResources.Robot_1_Part > 0 then
  begin
     time_arm1 := time_arm1 + 1;
  end;
  if ShopResources.Robot_2_Part > 0 then
  begin
     time_arm2 := time_arm2 + 1;
  end;
  if (ShopResources.AR_In_Part > 0) and (ShopResources.AR_free = False) then
  begin
     time_AR := time_AR + 1;
  end;

    // Nova lógica para contar mudanças de estado
  if (ShopResources.Robot_1_Part > 0) and (not prevRobot1Part) then
  begin
     countRobot1PartChanges := countRobot1PartChanges + 1;
  end;
  prevRobot1Part := ShopResources.Robot_1_Part > 0;

  if (ShopResources.Robot_2_Part > 0) and (not prevRobot2Part) then
  begin
     countRobot2PartChanges := countRobot2PartChanges + 1;
  end;
  prevRobot2Part := ShopResources.Robot_2_Part > 0;

  if (ShopResources.AR_In_Part > 0) and (ShopResources.AR_free = False) and (not prevARInPart) then
  begin
     countARInPartChanges := countARInPartChanges + 1;
  end;
  prevARInPart := (ShopResources.AR_In_Part > 0) and (ShopResources.AR_free = False);

  p_tmp_med := time_AR/total_time_production * 100;


  Memo56.Clear;
  Mins1 := time_arm1 div 60;
  Secs1 := time_arm1 mod 60;
  TimeString1 := Format('%d:%.2d', [Mins1, Secs1]);
  Memo56.append(TimeString1);
  Memo58.append(IntToStr(countRobot1PartChanges));


  Memo57.Clear;
  Mins2 := time_arm2 div 60;
  Secs2 := time_arm2 mod 60;
  TimeString2 := Format('%d:%.2d', [Mins2, Secs2]);
  Memo57.append(TimeString2);
  Memo59.append(IntToStr(countRobot2PartChanges));

  MemoAR.Clear;

  MemoContagemAR.append(IntToStr(countARInPartChanges));
  Memo62.append(FormatFloat('0.0', p_tmp_med));

  if countARInPartChanges>0 then
  begin
     tmp_med := time_AR/countARInPartChanges;
     MemoAR.append(FormatFloat('0.0', tmp_med));
  end;

end;


Procedure TFormDispatcher.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Application.MainForm.Show;
end;

end.

