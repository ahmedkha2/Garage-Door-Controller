module Controller (
  input         Activate,
  input reg     UP_Max, DN_Max,
  input         CLK,RST,
  output reg    UP_M,DN_M
  );



localparam  [1:0]    IDLE = 2'b00,
                     Mv_Dn = 2'b01,
                     Mv_Up = 2'b11;
                 
reg [1:0]        C_S, N_S;

//state transition
always@(posedge CLK or negedge RST)
  begin
    if(!RST)
      C_S <= IDLE;
    else
      C_S <= N_S;
  end
  
//next state logic
always@(*)
  begin
    case(C_S)
      IDLE:begin
            if(Activate && UP_Max)
              N_S = Mv_Dn;
            else if (Activate && DN_Max)
              N_S = Mv_Up;
            else
              N_S = IDLE;
           end
           
      Mv_Dn:begin
            if (DN_Max)
              N_S = IDLE;
            else
              N_S = Mv_Dn;
            end
            
      Mv_Up:begin
            if (UP_Max)
              N_S = IDLE;
            else
              N_S = Mv_Up;
            end
    endcase
  end
  
//output logic
always@(*)
  begin
    case(C_S)
      IDLE:begin
             UP_M = 1'b0;
             DN_M = 1'b0; 
           end
           
      Mv_Dn:begin
              UP_M = 1'b0;
              DN_M = 1'b1;
            end
            
      Mv_Up:begin
              UP_M = 1'b1;
              DN_M = 1'b0;
            end
    endcase
  end

endmodule