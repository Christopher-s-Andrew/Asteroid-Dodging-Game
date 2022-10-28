module OneSecondTimer(enable, timeoutPulse, clk, rst);

//HEAVILY MODIFIED FOR TESTBENCH DO NOT USE EXCEPT FOR TESTBENCH
    input enable;
    output timeoutPulse;
    reg timeoutPulse;

    input clk, rst;

    reg[0:3] counter; // 4 bit counter, can count up to 15

    always @(posedge clk) begin
        if (rst == 1'b0) begin
            counter <= 0; // reset counter
            timeoutPulse <= 1'b0;
        end else begin
            if (timeoutPulse == 1'b1) begin
                timeoutPulse <= 1'b0;
            end
            if (enable == 1'b1) begin
                if (counter >= 1) begin // reset at 2
                    counter <= 0;
                    timeoutPulse <= 1'b1;
                end else begin
                    counter <= counter + 1;
                end
            end
        end
    end
endmodule
