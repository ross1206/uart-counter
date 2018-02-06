//	setup file time 2018/2/6
//	author <ross1206vii@gmail.com>



module timer025
(
	clk_in,
	out_025s
);

parameter FRQ = 500000;

input clk_in;
output out_025s;


reg[19:0] temp;

// always start
always @(posedge clk_in)
begin
	temp <= temp + 1;
end
// always end



endmodule


