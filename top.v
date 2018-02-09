//top level file in this project



module top
(
	input clk_in,
	input [15:0] sig_in,
	output out1
);

wire fre9600_wire;
wire time025_wire;
wire sig_selected_wire;



freq9600	f9600(.clk_in(clk_in), .clk_9600(fre9600_wire));
timer025 	t25(.clk_in(fre9600_wire), .out_025s(time025_wire));
select_16 	s16(.in(sig_in), .time_025(time025_wire), .out(sig_selected_wire));

endmodule



