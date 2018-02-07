//	setup file time 2018/2/6
//	author <ross1206vii@gmail.com>



module select_16
(
	input [15:0] in,
	input [3:0] addr,
	output reg out			//第一次写这个东西原来always块中要求被赋值的必须是reg类型 但是如果编写的确实是逻辑而不是时序的话不会被综合成触发器或锁存器
);





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
			out = 'bx;
	endcase
end



endmodule

