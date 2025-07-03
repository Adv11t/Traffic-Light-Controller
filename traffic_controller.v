`timescale 1ns / 1ps

module traffic_controller (
  input clk,
  input reset,
  output reg [1:0] N_forward, N_left,
  output reg [1:0] S_forward, S_left,
  output reg [1:0] E_forward, E_left,
  output reg [1:0] W_forward, W_left
);

// Traffic Light Signal states
localparam RED    = 2'b00;
localparam YELLOW = 2'b01;
localparam GREEN  = 2'b10;

// FSM States
localparam S0  = 3'd0, // N/S Forward Green
           S0Y = 3'd1, // N/S Forward Yellow
           S1  = 3'd2, // E/W Forward Green
           S1Y = 3'd3, // E/W Forward Yellow
           S2  = 3'd4, // N?W & S?E Protected Lefts
           S3  = 3'd5, // E?N & W?S Protected Lefts
           S4  = 3'd6; // All RED Buffer

reg [2:0] state;
reg [3:0] timer;  

// FSM State Transition + Timer
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= S0;
    timer <= 0;
  end 
  else begin
    if (timer == 4'd2) begin
      timer <= 0;
      if (state == S4)
        state <= S0;
      else
        state <= state + 1;
    end 
    else begin
      timer <= timer + 1;
    end
  end
end

// Output Logic
always @(*) begin
  // Reset all outputs to RED every time (safe default)
  N_forward = RED; N_left = RED;
  S_forward = RED; S_left = RED;
  E_forward = RED; E_left = RED;
  W_forward = RED; W_left = RED;

  // Now activate only the lights required in current state
  case (state)
    S0: begin
      N_forward = GREEN;
      S_forward = GREEN;
    end
    S0Y: begin
      N_forward = YELLOW;
      S_forward = YELLOW;
    end
    S1: begin
      E_forward = GREEN;
      W_forward = GREEN;
    end
    S1Y: begin
      E_forward = YELLOW;
      W_forward = YELLOW;
    end
    S2: begin
      N_left = GREEN;  // North ? West
      S_left = GREEN;  // South ? East
    end
    S3: begin
      E_left = GREEN;  // East ? North
      W_left = GREEN;  // West ? South
    end
    S4: begin
      // All RED — already default
    end
  endcase
end

endmodule
