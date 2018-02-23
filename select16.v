//	setup file time 2018/2/6
//	author <ross1206vii@gmail.com>



module select_16
(
	input reset,
	input clk_in,
	input [16:1] in,		//16 inputs
	input time_025,			//this is a pulse signal, every 0.25s it will experience a period of level'1'
	
	output reg start,
	output reg out			//this must be 'output reg' so it can be assigned in 'always'-block
);



reg [4:0] addr;
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
	res <= q1 ^ q2;
end







always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		addr <= 2'd0;
	end
	else begin
		if(res == 1'b1) begin
			if(addr == 5'd16)	begin
				addr <= 5'd0;
			end
			else begin
				addr <= addr + 5'd1;
			end
		end
	end
end



always @(*)
begin
	if(addr == 2'd00) begin
		start = 1'b1;
	end
	else begin
		start = 1'b0;
	end
end



always @(*)
begin
	case(addr)
		5'd00: 
			out = 1'bx;
		5'd01:
			out = in[1];
		5'd02: 
			out = in[2];
		5'd03:
			out = in[3];
		5'd04: 
			out = in[4];
		5'd05:
			out = in[5];
		5'd06: 
			out = in[6];
		5'd07:
			out = in[7];
		5'd08: 
			out = in[8];
		5'd09:
			out = in[9];
		5'd10: 
			out = in[10];
		5'd11:
			out = in[11];
		5'd12: 
			out = in[12];
		5'd13:
			out = in[13];
		5'd14: 
			out = in[14];
		5'd15:
			out = in[15];
		5'd16:
			out = in[16];
		default: 
			out = 1'bx;
	endcase
end



endmodule

