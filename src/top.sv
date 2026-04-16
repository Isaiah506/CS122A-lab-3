`include "src/button_toggle.sv"
`include "src/button_pwm.sv"

module top (
    /** Input Ports */
    /** Output Ports */
    
    input logic clk,
    input logic button1,
    input logic button2,
    input logic dip,

    output logic led1,
    output logic led2,

    output logic[7:0] seg7
);

/** Logic */
logic[7:0] seg7_1;
logic[7:0] seg7_2;
logic rst1;
logic rst2;

always @(posedge clk) begin
    if(dip) begin
        rst1 <= 0;
        rst2 <= 0;
        seg7 <= {seg7_2, 1'b0};
    end
    else begin
        rst1 <= 0;
        rst2 <= 0;
        seg7 <= {seg7_1, 1'b1};
    end
end

button_pwm red_button_pwm(
    .clk(clk),
    .button(button1),
    .rst(rst1),
    .led(led1),
    .seg7(seg7_1[6:0])
);

button_pwm blue_button_pwm(
    .clk(clk),
    .button(button2),
    .rst(rst2),
    .led(led2),
    .seg7(seg7_2[6:0])
);

endmodule
