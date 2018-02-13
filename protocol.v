//	setup file time 2018/2/13
//	author <ross1206vii@gmail.com>



module protocol
(
	input reset,
	input start,
	input [7:0] data_in,
	input sig_in,
	
	output reg [7:0] data_out
);



always @(*)
begin
	if(reset == 1'b0) begin
		data_out = 8'b0;
	end
	else begin
		if(start == 1'b1) begin 		// means it is a start of frame
			data_out = 2'hff;
		end
		else begin
			if(data_in < 2'd20) begin	// means data is switcher
				if(sig_in == 1'b1) begin
					data_out = 2'd1;	// means siwtcher ON
				end
				else begin
					data_out = 2'd2;	// means siwtcher OFF
				end
			end
			else begin
				data_out = data_in;		// means frequency data
			end
		end
	end
end



endmodule

