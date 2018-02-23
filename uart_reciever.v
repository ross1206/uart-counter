//	setup file time 2018/2/22
//	author <ross1206vii@gmail.com>



`define UR_IDLE_ST		3'b000
`define UR_SHIFT_ST		3'b001
`define UR_LOCK_ST		3'b010




module uart_receiver
(
	input reset,
	input clk_in,
	input data_in,
	
	output reg [7:0] out
);



reg [2:0] current_st, next_st;
reg [3:0] shift_count;
reg [7:0] shift_data; 



always @ (posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		shift_count <= 3'b0;
		shift_data <= 8'b0;
	end
	else begin
		case (current_st)
			`UR_IDLE_ST:
			begin
				shift_count <= 3'b0;
				shift_data <= 8'b0;
			end	
			
			`UR_SHIFT_ST:
			begin
				shift_data <= {data_in, shift_data[7:1]};
				shift_count <= shift_count + 4'b1;
			end
			
			`UR_LOCK_ST:
			begin
				out <= shift_data;
			end
			
			default:
				;
		endcase
	end
end



always @ (*)
begin
	case (current_st)
		`UR_IDLE_ST:
		begin
			if(data_in == 1'b0) begin
				next_st = `UR_SHIFT_ST;
			end
			else begin
				next_st = `UR_IDLE_ST;
			end
		end
		
		`UR_SHIFT_ST:
		begin
			if(shift_count == 4'd8) begin
				next_st = `UR_LOCK_ST;
			end
			else begin
				next_st = `UR_SHIFT_ST;
			end
		end	
		
		`UR_LOCK_ST:
		begin
			next_st = `UR_IDLE_ST;
		end
		
		default:
			;
	endcase
end



always @ (posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		current_st <= `UR_IDLE_ST;
	end
	else begin
		current_st <= next_st;
	end
end

endmodule

