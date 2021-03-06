//	setup file time 2018/2/14
//	author <ross1206vii@gmail.com>



`define US_IDLE_ST		3'b000
`define US_LOCK_ST		3'b001
`define US_SHIFT_ST		3'b010
`define US_CLEAR_ST		3'b011



module uart_sender
(
	input reset,
	input clk_in,
	input time025,
	input [7:0] data_in,
	
	output reg data_out
);


reg data_start;
reg data_end;
reg [7:0] data_reg;
reg [2:0] current_st, next_st;
reg [3:0] shift_count;



always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		shift_count <= 4'b0;
	end
	else begin
		case(current_st)
			`US_IDLE_ST:
			begin
				data_start <= 1'b0;
				data_end <= 1'b1;
				shift_count <= 4'b0;
			end
			`US_LOCK_ST:
			begin
				data_start <= 1'b0;
				data_end <= 1'b1;
				data_reg <= data_in;
			end
			`US_SHIFT_ST:
			begin
				data_out <= data_start;
				data_start <= data_reg[0];
				data_reg[0] <= data_reg[1];
				data_reg[1] <= data_reg[2];
				data_reg[2] <= data_reg[3];
				data_reg[3] <= data_reg[4];
				data_reg[4] <= data_reg[5];
				data_reg[5] <= data_reg[6];
				data_reg[6] <= data_reg[7];
				data_reg[7] <= data_end;
				shift_count <= shift_count + 4'b1;
			end
			`US_CLEAR_ST:
				;
			default:
				;
		endcase
	end
end



always @(*)
begin
	case(current_st)
		`US_IDLE_ST:
		begin
			if(time025 == 1'b1) begin	// means should lock data from pins
				next_st = `US_LOCK_ST;
			end
			else begin
				next_st = `US_IDLE_ST;
			end
		end
		`US_LOCK_ST:
		begin
			next_st = `US_SHIFT_ST;
		end
		`US_SHIFT_ST:
		begin
			if(shift_count == 4'd10) begin	// means has shifted 8 bits out
				next_st = `US_CLEAR_ST;
			end
			else begin
				next_st = `US_SHIFT_ST;		// or keep going on
			end		
		end
		`US_CLEAR_ST:
		begin
			next_st = `US_IDLE_ST;
		end
		default:
			;
	endcase
end



always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		current_st <= `US_IDLE_ST;
	end
	else begin
		current_st <= next_st;
	end
end



endmodule
