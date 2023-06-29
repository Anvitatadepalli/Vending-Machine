module vending_machine(product_snack,
                       product_coffee,
                       product_drink,
                       product_candy,
                       change,
                       state,
                       clk,
                       rst,
                       sel,
                       snack,
                       coffee,
                       drink,
                       candy,
                       rs_10,
                       rs_20,
                       no_product);

input clk,rst;
input [2:0]snack, //machine can hold 7 products of each type;
           coffee,
           drink,
           candy;
input [1:0]sel;
input rs_10,rs_20,no_product;

output reg product_snack,
           product_coffee,
           product_drink,
           product_candy;
output reg [3:0]change;
output reg [3:0]state;

//states in the state machine

parameter user_selection= 4'd0;

parameter selection_1= 4'd1;
parameter selection_2= 4'd2;
parameter selection_3= 4'd3;
parameter selection_4= 4'd4;

parameter money_1= 4'd5;
parameter money_2= 4'd6;
parameter money_3= 4'd7;
parameter money_4= 4'd8;

parameter money_1_10= 4'd9;
parameter money_1_20= 4'd10;

parameter money_2_10= 4'd11;
parameter money_2_20= 4'd12;
parameter money_2_30= 4'd13;

parameter product_delivery= 4'd14;

parameter service_state= 4'd15;


//-------state generation--------//

always @(posedge clk or negedge rst)
begin
if(!rst) state<=user_selection;
else
 begin
 case(state)

 user_selection: case(sel)
                 2'b00: state<=selection_1;
                 2'b01: state<=selection_2;
                 2'b10: state<=selection_3;
                 2'b11: state<=selection_4;
                 default: state<=user_selection;
                 endcase

 selection_1: if(snack==0) state<=user_selection;
              else state<=money_1;

 selection_2: if(coffee==0) state<=user_selection;
              else state<=money_2;

 selection_3: if(drink==0) state<=user_selection;
              else state<=money_3;

 selection_4: if(candy==0) state<=user_selection;
              else state<=money_4;

//-------------------------------------------------------------

 money_1: if(rs_10) state<=money_1_10;
          else if(rs_20) state<=money_1_20;
          else state<=money_1;

 money_1_10: if(rs_10) state<=money_1_20;
             else if(rs_20) state<=product_delivery;
             else state<=money_1_10;

 money_1_20: if(rs_10||rs_20) state<=product_delivery;
             else state<=money_1_20;

//--------------------------------------------------------------

 money_2: if(rs_10) state<=money_2_10;
          else if(rs_20) state<=money_2_20;
          else state<=money_2;

 money_2_10: if(rs_10) state<=money_2_20;
             else if(rs_20) state<=money_2_30;
             else state<=money_2_10;

 money_2_20: if(rs_10) state<=money_2_30;
             else if(rs_20) state<=product_delivery;
             else state<=money_2_20;

 money_2_30: if(rs_10||rs_20) state<=product_delivery;
             else state<=money_2_30;

//--------------------------------------------------------------

 money_3: if(rs_10) state<=money_2_10;
          else if(rs_20) state<=money_2_20;
          else state<=money_3;

//-------------------------------------------------------------

 money_4: if(rs_10) state<=money_1_10;
          else if(rs_20) state<=money_1_20;
          else state<=money_4;

 //------------------------------------------------------------

 product_delivery: if(no_product) state<=service_state;
                   else state<=user_selection;

 service_state: state<=service_state;

 default: state<=user_selection;

 endcase

 end
end


//-----mux for product delivery-----//
always @(posedge clk or negedge rst)
begin
 if(!rst) begin
          product_snack<=0;
          product_coffee<=0;
          product_drink<=0;
          product_candy<=0;
          end
 else
   begin
   if(state==product_delivery)
   case(sel)
   2'b00: begin
          product_snack<=1;
          product_coffee<=0;
          product_drink<=0;
          product_candy<=0;
          end

   2'b01: begin
          product_snack<=0;
          product_coffee<=1;
          product_drink<=0;
          product_candy<=0;
          end

   2'b10: begin
          product_snack<=0;
          product_coffee<=0;
          product_drink<=1;
          product_candy<=0;
          end

   2'b11: begin
          product_snack<=0;
          product_coffee<=0;
          product_drink<=0;
          product_candy<=1;
          end
   endcase
   else begin
        product_snack<=0;
        product_coffee<=0;
        product_drink<=0;
        product_candy<=0;
        end
   end
end

//--------change generation-------//
always @(posedge clk or negedge rst)
begin
 if(!rst) change<=0;
 else
  begin
  if(state==money_1_20 && rs_20)
    change<=4'd10;
  else if(state==money_2_30 && rs_20)
    change<=4'd10;
  else
    change<=0;
  end
end

endmodule

