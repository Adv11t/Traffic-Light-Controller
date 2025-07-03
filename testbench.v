`timescale 1ns / 1ps

`timescale 1ns/1ps

module testbench;

  reg clk;
  reg reset;

  wire [1:0] N_forward, N_left;
  wire [1:0] S_forward, S_left;
  wire [1:0] E_forward, E_left;
  wire [1:0] W_forward, W_left;

  traffic_controller uut (
    .clk(clk),
    .reset(reset),
    .N_forward(N_forward), .N_left(N_left),
    .S_forward(S_forward), .S_left(S_left),
    .E_forward(E_forward), .E_left(E_left),
    .W_forward(W_forward), .W_left(W_left)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    reset = 1;
    #10;
    reset = 0;
    #300;
    $finish;
  end

endmodule
