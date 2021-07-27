module dirdect_drf(
	input i_A,
	input i_B,
	output o_Forw,
	output o_Back,
	output UD
);

reg A_past;
reg B_past;

wire virtualClk;
reg r_Forw;
reg r_Back;
reg r_UD;
assign virtualClk = i_A | i_B;

always @(posedge virtualClk)
begin
	A_past <= i_A;
	B_past <= i_B;
	r_Forw <= ((i_A ^ A_past) && ((i_A == 1'b1) && (i_B == 1'b0 ))) ? i_A : 1'b0;
	r_Back <= ((i_B ^ B_past) && ((i_B == 1'b1)&&(i_A == 1'b0))) ? i_B : 1'b0;
	if (r_Forw == 1'b1)
		r_UD <= 1'b1;
	else
		if (r_Back == 1'b1)
			r_UD <= 1'b0;
		else
			r_UD <= r_UD;
end
	
assign UD = r_UD;
assign o_Forw = ((i_A ^ A_past) && ((i_A == 1'b1) && (i_B == 1'b0 ))) ? i_A : 1'b0; 
assign o_Back = ((i_B ^ B_past) && ((i_B == 1'b1)&&(i_A == 1'b0))) ? i_B : 1'b0; 



endmodule
	
		


