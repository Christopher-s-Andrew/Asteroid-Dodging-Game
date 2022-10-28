module Timer100ms(enable, timeoutPulse, clk, rst);
    input enable;
    output timeoutPulse;
    reg timeoutPulse;

    input clk, rst;

    wire inputPulse;

    reg[0:6] counter; // 7 bit counter, can count up to 127
    Timer1msLFSR internalTimer(enable, inputPulse, clk, rst);

    always @(posedge clk) begin
        if (rst == 1'b0) begin
            counter <= 0; // reset counter
            timeoutPulse <= 1'b0;
        end else begin
            if (timeoutPulse == 1'b1) begin
                timeoutPulse <= 1'b0;
            end
            if (enable == 1'b1 && inputPulse == 1'b1) begin
                if (counter >= 99) begin // reset at 100
                    counter <= 0;
                    timeoutPulse <= 1'b1;
                end else begin
                    counter <= counter + 1;
                end
            end
        end
    end
endmodule