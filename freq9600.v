//	setup file time 2018/2/7
//	author <ross1206vii@gmail.com>



`define FRE_9600_TOGGLE	2604




module freq9600
(
	input clk_in,
	output clk_9600
);


parameter FREQUENCY = `FRE_9600_TOGGLE;

reg [11:0] tim_tmp;
reg fre9600_tmp;


always @(posedge clk_in)
begin
	tim_tmp <= tim_tmp + 1;
	
	if(tim_tmp ==  FREQUENCY) begin
		tim_tmp <= 0;
		fre9600_tmp <= ~fre9600_tmp;
	end
end

assign clk_9600 = fre9600_tmp;


endmodule

