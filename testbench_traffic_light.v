module tb_traffic_light;

    reg clk = 0;
    reg reset;
    wire red, yellow, green;

    // Instantiate the traffic light module
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation: 10Hz (100MHz clock / 10)
    always #5 clk = ~clk; // Clock with period 10ns (for 10Hz simulation)

    initial begin
        // Initialize signals
        reset = 1;
        #10 reset = 0;  // Release reset after 10ns
        
        // Set up waveform dumping
        $dumpfile("traffic_light.vcd"); // Create waveform file
        $dumpvars(0, tb_traffic_light);  // Record all variables in the testbench

        // Run simulation for 300ns (or any appropriate time)
        #300 $finish;  // End simulation after 300ns
    end

    // Display the output during simulation (optional)
    initial begin
        $monitor("Time: %0t | Reset: %b | Red: %b | Yellow: %b | Green: %b", 
                  $time, reset, red, yellow, green);
    end

endmodule
