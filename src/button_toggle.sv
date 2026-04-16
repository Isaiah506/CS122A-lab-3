module button_toggle (
    /** Input Ports */
    /** Output Ports */
    
    input logic clk,
    input logic button,
    output logic led
);

/** Logic */

typedef enum logic [3:0] {init, off, press_on, on, press_off, wait1, wait2, wait3, wait4} state_t;
state_t state = init;
logic[4:0] cnt = 0;
logic[4:0] limit = 10;

always @(posedge clk) begin
    case(state)
        init:state = off;
        
        off: begin
            if(button == 1) begin
                cnt = 0;
                state = wait1;
            end
            else begin
                state = off;
            end
        end

        wait1: begin
            cnt = cnt + 1;
            if(cnt >= limit) begin
                state =  press_on;
            end
        end

        press_on: begin
            if(button == 1) begin
                state = press_on;
            end
            else begin
                cnt = 0;
                state = wait2;
            end
        end

        wait2: begin
            cnt = cnt + 1;
            if(cnt >= limit) begin
                state =  on;
            end
        end 

        on: begin
            if(button == 1) begin
                cnt = 0;
                state = wait3;
            end
            else begin
                state = on;
            end
        end

        wait3: begin
            cnt = cnt + 1;
            if(cnt >= limit) begin
                state =  press_off;
            end
        end

        press_off: begin
            if(button == 0) begin
                state = press_off;
            end
            else begin
                cnt = 0;
                state = wait4;
            end
        end

        wait4: begin
            cnt = cnt + 1;
            if(cnt >= limit) begin
                state =  off;
            end
        end

        default: state = init;
    endcase
end

always_comb begin
    case(state)
        on: led = 1;
        off: led = 0;
        default: led = led;
    endcase
end

endmodule