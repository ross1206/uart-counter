//	setup file time 2018/2/6
//	author <ross1206vii@gmail.com>



module timer025
(
	input reset,
	input clk_in,
	
	output reg out_025s
);

parameter FRQ = 2400;




reg[11:0] tmp;

// always start
always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		tmp <= 12'b0;
		out_025s <= 1'b0;
	end
	else begin
		if(tmp == FRQ) begin
			tmp <= 12'b0;
			out_025s <= 1'b1;
		end
		else begin
			tmp <= tmp + 12'b1;
			out_025s <= 1'b0;
		end
	end
end
// always end



endmodule


