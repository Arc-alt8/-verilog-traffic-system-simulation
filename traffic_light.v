module traffic_light (
    input clk,
    input reset,
    output reg red,
    output reg yellow,
    output reg green);
    // State encoding
    typedef enum reg [1:0] {
        RED = 2'b00,
        GREEN = 2'b01,
        YELLOW = 2'b10
    } state_t;
    state_t state, next_state;
    reg [3:0] counter;

    // Counter limit based on state
    function [3:0] counter_limit(state_t s);
        case (s)
            RED: return 4'd10;
            GREEN: return 4'd8;
            YELLOW: return 4'd2;
            default: return 4'd0;
        endcase
    endfunction

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RED;
            counter <= 0;
        end else begin
            if (counter < counter_limit(state))
                counter <= counter + 1;
            else begin
                counter <= 0;
                case (state)
                    RED: state <= GREEN;
                    GREEN: state <= YELLOW;
                    YELLOW: state <= RED;
                endcase
            end
        end
    end

    // Output logic
    always @(*) begin
        red = 0; green = 0; yellow = 0;
        case (state)
            RED: red = 1;
            GREEN: green = 1;
            YELLOW: yellow = 1;
        endcase
    end

endmodule
