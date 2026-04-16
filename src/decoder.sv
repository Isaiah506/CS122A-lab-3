module decoder (
    input reg [3:0] bcd,
    output logic [6:0] seg7
);


/** Logic */ //4,5,b,d
always @(*) begin
    if(bcd == 4'b0000) begin
        seg7 = 7'b1111110;
    end
    else if(bcd == 4'b0001) begin
        seg7 = 7'b0110000;
    end
    else if(bcd == 4'b0010) begin
        seg7 = 7'b1101101;
    end
    else if(bcd == 4'b0011) begin
        seg7 = 7'b1111001;
    end
    else if(bcd == 4'b0100) begin
        seg7 = 7'b0110011;
    end
    else if(bcd == 4'b0101) begin
        seg7 = 7'b1011011;
    end
    else if(bcd == 4'b0110)begin
        seg7 = 7'b1011111;
    end
    else if(bcd == 4'b0111) begin
        seg7 = 7'b1110000;
    end
    else if(bcd == 4'b1000) begin
        seg7 = 7'b1111111;
    end
    else if(bcd == 4'b1001) begin
        seg7 = 7'b1111011;
    end
    else if(bcd == 4'b1010) begin
        seg7 = 7'b1110111;
    end
    else if(bcd == 4'b1011) begin
        seg7 = 7'b0011111;
    end
    else if(bcd == 4'b1100) begin
        seg7 = 7'b1001110;
    end 
    else if(bcd == 4'b1101) begin
        seg7 = 7'b0111101;
    end
    else if(bcd == 4'b1110) begin
        seg7 = 7'b1001111;
    end
    else if(bcd == 4'b1111) begin
        seg7 = 7'b1000111;
    end
end

endmodule
