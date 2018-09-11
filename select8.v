//	setup file time 2018/2/6
//	author <ross1206vii@gmail.com>



module select8
(
	input reset,
	input clk_in,
	input [8:1] in,			//8 inputs
	input time_025,			//this is a pulse signal, every 0.25s it will experience a period of level'1'
	
	output reg start,
	output reg out				//this must be 'output reg' so it can be assigned in 'always'-block
);



reg [3:0] addr;
reg q1, q2;
reg res;





always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		q1 <= 1'b0;
		q2 <= 1'b0;
	end
	else begin
		q1 <= time_025;
		q2 <= q1;
	end
end



always @(*)
begin
	res <= q1 & (~q2);
end







always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		addr <= 4'd0;
	end
	else begin
		if(res == 1'b1) begin
			if(addr == 4'd8)	begin
				addr <= 4'd0;
			end
			else begin
				addr <= addr + 4'd1;
			end
		end
	end
end



always @(*)
begin
	if(addr == 4'd00) begin
		start = 1'b1;
	end
	else begin
		start = 1'b0;
	end
end



always @(*)
begin
	case(addr)
		4'd00: 
			out = 1'bx;
		4'd01:
			out = in[1];
		4'd02: 
			out = in[2];
		4'd03:
			out = in[3];
		4'd04: 
			out = in[4];
		4'd05:
			out = in[5];
		4'd06: 
			out = in[6];
		4'd07:
			out = in[7];
		4'd08: 
			out = in[8];

		default: 
			out = 1'bx;
	endcase
end



endmodule

