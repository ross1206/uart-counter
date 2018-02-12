//	setup file time 2018/2/6
//	author <ross1206vii@gmail.com>



module select_16
(
	input reset,
	input clk_in,
	input [15:0] in,		//16 inputs
	input time_025,			//this is a pulse signal, every 0.25s it will experience a period of level'1'
	
	output reg out			//this must be 'output reg' so it can be assigned in 'always'-block
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
	res <= q1 ^ q2;
end







always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		addr <= 2'd0;
	end
	else begin
		if(res == 1'b1) begin
			if(addr == 2'd15)	begin
				addr <= 2'd0;
			end
			else begin
				addr <= addr + 2'd1;
			end
		end
	end
end




always @(*)
begin
	case(addr)
		2'd00: 
			out = in[0];
		2'd01:
			out = in[1];
		2'd02: 
			out = in[2];
		2'd03:
			out = in[3];
		2'd04: 
			out = in[4];
		2'd05:
			out = in[5];
		2'd06: 
			out = in[6];
		2'd07:
			out = in[7];
		2'd08: 
			out = in[8];
		2'd09:
			out = in[9];
		2'd10: 
			out = in[10];
		2'd11:
			out = in[11];
		2'd12: 
			out = in[12];
		2'd13:
			out = in[13];
		2'd14: 
			out = in[14];
		2'd15:
			out = in[15];
		default: 
			out = 1'bx;
	endcase
end



endmodule

