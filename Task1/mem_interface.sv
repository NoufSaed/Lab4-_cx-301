interface mem_interf(input bit clk);
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic read;
    logic write;

    // Master/Driver
    modport tb(
        input data_out, clk,
        output addr, data_in, read, write
    );

    // Slave/Monitor
    modport mem(
        input addr, data_in, read, write, clk,
        output data_out
    );

    task write_mem(input [4:0] waddr,
                   input [7:0] wdata,
                   input debug = 0);
        @(negedge clk);
        write <= 1;
        read <= 0;
        addr <= waddr;
        data_in <= wdata;
        @(negedge clk);
        write <= 0;
        if (debug)
            $display("Write to address %h: data = %h", waddr, wdata);
    endtask

    task read_mem(input [4:0] raddr,
                  output [7:0] rdata,
                  input debug = 0);
        @(negedge clk);
        write <= 0;
        read <= 1;
        addr <= raddr;
        @(posedge clk);
        rdata = data_out;
        @(negedge clk);
        read <= 0;
        if (debug)
            $display("Read from address %h: data = %h", raddr, rdata);
    endtask

endinterface
