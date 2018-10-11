//	setup file time 2018/2/9
//	author <ross1206vii@gmail.com>

// I think I have to use the state-mechine 
// to detect the positive-edge of input signal


`define DETECT1_ST 	3'b000		//because I did not use the reset signal, so this state never exists
`define DETECT2_ST	3'b001
`define COMPARE_ST	3'b010
`define LOCK_ST		3'b011





module counter
(
	input clk_in,
	input sig_in,
	input tim025,
	
	output [7:0] data_out		//the max frequency of input signal is 1000HZ
);


reg [2:0] current_state;
reg [2:0] next_state;

reg first_result;
reg second_result;

reg [7:0] counter;


// this always will describe the function due to current state
always @(posedge clk_in)
begin

	case(current_state)
		`DETECT1_ST: begin
			first_result <= sig_in;
		end
		
		`DETECT2_ST: begin
			second_result <= sig_in;
		end
		
		`COMPARE_ST: begin
			if((first_result == 1'b0) && (second_result == 1'b1)) begin	//means posedge of sig_in
				if(counter == 250) begin	// protect [8:0] overflow
					counter <= 250;
				end
				else begin 
					counter <= counter + 1;
				end
			end
		end
		
		`LOCK_ST: begin
			first_result <= 1'b0;
			second_result <= 1'b0;
			counter <= 8'b0;
		end
		
		default:
			;
	endcase
end


assign data_out = counter; 


// this always determin the logic of next-state changing
always @(*)
begin
	case(current_state)
		`DETECT1_ST: begin	
			if(tim025 == 1'b1) begin
				next_state = `LOCK_ST;
			end
			else begin
				next_state = `DETECT2_ST;
			end
		end
		
		`DETECT2_ST: begin	
			if(tim025 == 1'b1) begin
				next_state = `LOCK_ST;
			end
			else begin
				next_state = `COMPARE_ST;
			end
		end
		
		`COMPARE_ST: begin	
			if(tim025 == 1'b1) begin
				next_state = `LOCK_ST;
			end
			else begin
				next_state = `DETECT1_ST;
			end
		end
		
		`LOCK_ST: begin	
			next_state = `DETECT1_ST;
		end
		
		default: begin	
			;
		end
	endcase
end



// this always update next-state to current state
always @(posedge clk_in)
begin 
	current_state <= next_state;
end



endmodule

