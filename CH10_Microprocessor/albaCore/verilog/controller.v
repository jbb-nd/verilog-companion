module controller (
   input             clk,
   input             reset,
   output reg        s_addr,
   output reg        en_inst,
   output reg        en_a,
   output reg        en_b,
   output reg [2:0]  alu_op,
   output reg        en_f,
   output reg        en_mdr,
   output reg        s_regfile_din,
   output reg        we_regfile,
   output reg        s_next_pc,
   output reg        en_pc,
   input      [3:0]  opcode,
   input             zero,
   input             neg,
   output reg        we_mem
   );
   
   parameter IFETCH  = 5'd1;
   parameter IFETCH2 = 5'd2;
   parameter DECODE  = 5'd3;
   parameter EX_ADD  = 5'd4;
   parameter EX_SUB  = 5'd5;
   parameter EX_AND  = 5'd6;
   parameter EX_OR   = 5'd7;
   parameter EX_NOT  = 5'd8;
   parameter EX_SHL  = 5'd9;
   parameter EX_SHR  = 5'd10;
   parameter EX_LDI  = 5'd11;
   parameter EX_LD   = 5'd12;
   parameter EX_LD2  = 5'd13;
   parameter EX_ST   = 5'd14;
   parameter EX_BR   = 5'd15;
   parameter EX_BZ   = 5'd16;
   parameter EX_BN   = 5'd17;
   parameter EX_QUIT = 5'd18;
   parameter WB_ALU  = 5'd19;
   parameter WB_MEM  = 5'd20;
   parameter BR_TAKE = 5'd21;
   parameter BR_NOT  = 5'd22;
   
   reg [4:0] state, next_state;
   
   always @(posedge clk)
      if (reset)
         state <= IFETCH;
      else
         state <= next_state;
         
   always @(*) begin
      s_addr         = 0;
      en_inst        = 0;
      en_a           = 0;   
      en_b           = 0;   
      alu_op         = 0;   
      en_f           = 0;   
      en_mdr         = 0;   
      we_mem         = 0;   
      s_regfile_din  = 0;   
      we_regfile     = 0;
      s_next_pc      = 0;
      en_pc          = 0;
      next_state     = EX_QUIT;
      case (state)
         IFETCH  : begin
            s_addr = 0;
            next_state = IFETCH2;
         end
         IFETCH2 : begin
            en_inst = 1;
            next_state = DECODE;
         end
         DECODE  : begin
            en_a = 1;  en_b = 1;
            case (opcode)
                0: next_state = EX_ADD; 
                1: next_state = EX_SUB; 
                2: next_state = EX_AND; 
                3: next_state = EX_OR;  
                4: next_state = EX_NOT; 
                5: next_state = EX_SHL; 
                6: next_state = EX_SHR; 
                7: next_state = EX_LDI; 
                8: next_state = EX_LD;  
                9: next_state = EX_ST;  
               10: next_state = EX_BR;   
               11: next_state = EX_BZ;  
               12: next_state = EX_BN;  
               default: next_state = EX_QUIT;
            endcase
         end
         EX_ADD  : begin
            alu_op = 0;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_SUB  : begin      
            alu_op = 1;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_AND  : begin      
            alu_op = 2;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_OR   : begin      
            alu_op = 3;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_NOT  : begin      
            alu_op = 4;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_SHL  : begin      
            alu_op = 5;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_SHR  : begin      
            alu_op = 6;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_LDI  : begin      
            alu_op = 7;  en_f = 1;
            next_state = WB_ALU;
         end
         EX_LD   : begin
            s_addr = 1;
            next_state = EX_LD2;
         end
         EX_LD2  : begin  
            en_mdr = 1;
            next_state = WB_MEM;
         end
         EX_ST   : begin
            we_mem = 1;  s_addr = 1;
            s_next_pc = 0;  en_pc = 1;
            next_state = IFETCH;
         end
         EX_BR   : begin
            s_next_pc = 1;  en_pc = 1;
            next_state = IFETCH;
         end
         EX_BZ   : begin
            if (zero) next_state = BR_TAKE;
            else next_state = BR_NOT;
         end
         EX_BN   : begin      
            if (neg) next_state = BR_TAKE;
            else next_state = BR_NOT;
         end
         EX_QUIT : begin 
            next_state = EX_QUIT;
         end
         WB_ALU  : begin   
            s_regfile_din = 0;  we_regfile = 1;
            s_next_pc = 0;  en_pc = 1;
            next_state = IFETCH;
         end
         WB_MEM  : begin
            s_regfile_din = 1;  we_regfile = 1;
            s_next_pc = 0;  en_pc = 1;
            next_state = IFETCH;
         end
         BR_TAKE : begin 
            s_next_pc = 1;  en_pc = 1;
            next_state = IFETCH;
         end
         BR_NOT  : begin 
            s_next_pc = 0;  en_pc = 1;
            next_state = IFETCH;
         end
         default : begin
         end
      endcase
   end

   
endmodule