//top level file in this project


module top
(
	input reset,
	input clk_in,
	input [15:0] sig_in,
	input uart_data_in,
	
	output uart_out,
	output [7:0] sw_out
);

wire fre9600_wire;
wire time025_wire;
wire sig_selected_wire;
wire start_frame_wire;
wire [7:0] counter_data_wire;
wire [7:0] counter_data_protocal_wire;



freq9600		f9600(.reset(reset), .clk_in(clk_in), .clk_9600(fre9600_wire));
timer025 		t25(.reset(reset), .clk_in(fre9600_wire), .out_025s(time025_wire));
select_16 		s16(.reset(reset), .clk_in(fre9600_wire), .in(sig_in), .time_025(time025_wire), .out(sig_selected_wire), .start(start_frame_wire));
counter			ct1(.reset(reset), .clk_in(clk_in), .tim025(time025_wire), .sig_in(sig_selected_wire), .data_out(counter_data_wire));
protocol_out	p1(.reset(reset), .start(start_frame_wire), .data_in(counter_data_wire), .sig_in(sig_selected_wire), .data_out(counter_data_protocal_wire));
uart_sender 	u_s1(.reset(reset), .clk_in(fre9600_wire), .time025(time025_wire), .data_in(counter_data_protocal_wire), .data_out(uart_out));
uart_receiver	u_r1(.reset(reset), .clk_in(fre9600_wire), .data_in(uart_data_in), .out(sw_out));


endmodule



