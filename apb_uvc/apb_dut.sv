module apb_dut #(parameter DATA_WIDTH = 32) (
    input logic pclk,
    input logic rst_n,
    input logic [31:0] paddr,
    input logic psel,
    input logic penable,
    input logic pwrite,
    output logic [DATA_WIDTH-1:0] pdata,  // כתיבה ישירה של ה-data, אין צורך ב-inout
    output logic pready
);

    logic [DATA_WIDTH-1:0] mem [0:255];  // זיכרון עם רוחב נתונים קונפיגורבילי
    logic [1:0] apb_st;
    const logic [1:0] SETUP = 0;
    const logic [1:0] W_ENABLE = 1;
    const logic [1:0] R_ENABLE = 2;

    // Register to hold the read data internally
    logic [DATA_WIDTH-1:0] pdata_internal;

    always @(posedge pclk or negedge rst_n) begin
        if (!rst_n) begin
            apb_st <= SETUP;
            pready <= 1;
            pdata_internal <= '0;  // אתחול ערוץ הקריאה
            for (int i = 0; i < 256; i++) mem[i] = i;  // אתחול הזיכרון
        end else begin
            case (apb_st)
                SETUP: begin
                    pready <= 1;  // Slave is ready for the next transaction

                    if (psel && !penable) begin
                        if (pwrite) begin
                            apb_st <= W_ENABLE;
                        end else begin
                            apb_st <= R_ENABLE;
                            pdata_internal <= mem[paddr[7:0]];  // קרא מהזיכרון והכנס ל-pdata_internal
                        end
                    end
                end
                W_ENABLE: begin
                    if (psel && penable && pwrite) begin
                        mem[paddr[7:0]] <= pdata;  // כתוב את הנתונים לכתובת המתאימה בזיכרון
                        pready <= 1;  // Slave ready after write
                    end
                    apb_st <= SETUP;
                end
                R_ENABLE: begin
                    pready <= 1;  // Slave ready after read
                    apb_st <= SETUP;
                end
            endcase
        end
    end

    // הקצאת הנתונים בערוץ הקריאה
    assign pdata = (apb_st == R_ENABLE) ? pdata_internal : 'Z;  // הצגת הנתונים רק בזמן קריאה
endmodule
