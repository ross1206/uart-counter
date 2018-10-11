//	setup file time 2018/2/13
//	author <ross1206vii@gmail.com>






module protocol_in 
(
	input reset,
	input [7:0] in,
	
	output reg [7:0] out
);





always @ (*)
begin
	if(reset == 1'b0) begin
		out = 8'b0;
	end
	else begin
		case (in[7:4])
			4'b0001:
			begin
				out[3:0] = in[3:0];
				out[7:4] = out[7:4];
			end
			
			4'b0010:
			begin
				out[7:4] = in[3:0];
				out[3:0] = out[3:0];
			end
			
			default:
				out[7:0] = out[7:0];
		endcase
	end
end




endmodule



