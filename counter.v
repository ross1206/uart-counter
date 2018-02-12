//	setup file time 2018/2/12
//	author <ross1206vii@gmail.com>




module counter
(
	input reset,
	input clk_in,
	input tim025,
	input sig_in,
	
	output reg [7:0] data_out
);


reg [7:0] counter;
reg q1, q2;
reg res;



always @(posedge clk_in or negedge reset)
begin
	if(reset == 1'b0) begin
		q1 <= 1'b0;
		q2 <= 1'b0;
	end
	else begin
		q1 <= sig_in;
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
		counter <= 8'b0;
		data_out <= 8'b0;
	end
	else begin
		if(tim025 == 1'b0) begin		// means it is now in period of 0.25s
			if(res == 1'b1) begin
				counter <= counter + 8'b1;
			end
		end
		else begin
			data_out <= counter;
			counter <= 8'b0;
		end
	end
end

endmodule

