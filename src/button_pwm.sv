`include "src/decoder.sv"

module button_pwm (
    /** Input Ports */
    /** Output Ports */
    
    input logic clk,
    input logic button,
    input logic rst,

    output logic led,
    output logic[7:0] seg7
);

/** Logic */

typedef enum logic [3:0] {init, pressed, not_pressed, wait1, wait2} state_t;
state_t state = init;
logic[4:0] cnt = 0;
logic[4:0] limit = 20;
logic[3:0] duty_cycle = 0;
logic[3:0] pwm_cnt = 0;

decoder top_decoder(
    .bcd(duty_cycle[3:0]),
    .seg7(seg7[6:0])
);

always @(posedge clk) begin
    if( (pwm_cnt < duty_cycle) && !rst) begin
        led <= 1; 
    end
    else begin
        led <= 0;
    end
    pwm_cnt <= (pwm_cnt + 1) % 11;
end

always @(posedge clk) begin
    case(state)
        init:state = not_pressed;
        
        not_pressed: begin
            if(button == 1) begin
                cnt <= 0;
                state = wait1;
            end
            else begin
                state = not_pressed;
            end
        end

        wait1: begin
            cnt <= cnt + 1;
            if(cnt >= limit) begin
                state = pressed;
            end
        end

        pressed: begin
            if(button == 1) begin
                state = pressed;
            end
            else begin
                cnt <= 0;
                state = wait2;
            end
        end

        wait2: begin
            cnt <= cnt + 1;
            if(cnt >= limit) begin
                duty_cycle <= (duty_cycle + 1) % 11;
                state =  not_pressed;
            end
        end 

        default: state = init;
    endcase
end



endmodule