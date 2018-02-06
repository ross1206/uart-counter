//`include "timer025.v"



module top
(
	input in1,
	output out1
);




timer025 t25(.clk_in(in1), .out_025s(out1));

endmodule



