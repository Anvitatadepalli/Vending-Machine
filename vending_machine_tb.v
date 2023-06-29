module tb;

reg clk,rst;
reg [2:0]snack,
         coffee,
         drink,
         candy;
reg [1:0]sel;
reg rs_10,rs_20,no_product;
wire product_snack,
     product_coffee,
     product_drink,
     product_candy;
wire [3:0]change;
wire [3:0]state;



vending_machine dut (product_snack,
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

initial
 clk<=0;
always #10 clk=~clk;

initial
 begin
 rst<=1;
 @(posedge clk) rst<=0;
 @(posedge clk) rst<=1;
 end

initial
 begin
 #20000;
 $finish;
 end

initial
 begin
  selection(2'b00);
  selection(2'b01);
  selection(2'b10);
  selection(2'b11); //change case
  
//---- no product case---// 
begin
 @(posedge clk)
 sel<=2'b00;
 repeat(2)@(posedge clk)
 rs_10<=1;
 repeat(2)@(posedge clk)
 rs_10<=0;
 rs_20<=1;
 @(posedge clk)
 no_product<=1;
 @(posedge clk)
 rs_20<=0;
 
end
  

 end
 
 //------task selection-----------//
 task selection(input [1:0]selection);
 begin
 @(posedge clk)
 sel<=selection;
 repeat(3)@(posedge clk)
 rs_10<=1;
 repeat(1)@(posedge clk)
 rs_10<=0;
 rs_20<=1;
 @(posedge clk)
 rs_20<=0;

 //------task selection----------//
 end
 endtask
endmodule