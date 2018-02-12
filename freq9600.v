//	setup file time 2018/2/7
//	author <ross1206vii@gmail.com>



`define FRE_9600_TOGGLE	2604




module freq9600
(
	input reset,
	input clk_in,
	
	output reg clk_9600
);




reg [11:0] tim_tmp;



always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin		// means to reset
		tim_tmp <= 12'b0;
		clk_9600 <= 1'b0;
	end
	else begin
		if(tim_tmp ==  `FRE_9600_TOGGLE) begin
			tim_tmp <= 0;
			clk_9600 <= ~clk_9600;
		end
		else begin
			tim_tmp <= tim_tmp + 12'b1;
		end
	end
end



endmodule

