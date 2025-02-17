// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

module mem_test (mem_interf.tb mif);
    // SYSTEMVERILOG: new data types - bit, logic
    bit         debug = 1;
    logic [7:0] rdata;      // stores data read from memory for checking
    int error_status = 0;
    
    // Variable to store random data
    logic [7:0] rand_data;    // Random data variable
    
    // Function to generate random printable ASCII
    function logic [7:0] get_random_ascii();
        logic [7:0] temp;
        temp = $urandom_range(8'h20, 8'h7F);  // Generate number between 32 and 127
        return temp;
    endfunction
    
    // Function to generate random alpha (A-Z, a-z)
    function logic [7:0] get_random_alpha();
        logic [7:0] temp;
        if ($urandom_range(0, 1))  // 50% chance for upper/lower
            temp = $urandom_range(8'h41, 8'h5A);  // A-Z
        else
            temp = $urandom_range(8'h61, 8'h7A);  // a-z
        return temp;
    endfunction
    
    // Function to generate weighted alpha (80% uppercase, 20% lowercase)
    function logic [7:0] get_weighted_alpha();
        logic [7:0] temp;
        int weight = $urandom_range(1, 100);  // Generate number between 1 and 100
        
        if (weight <= 80)  // 80% chance for uppercase
            temp = $urandom_range(8'h41, 8'h5A);  // A-Z
        else  // 20% chance for lowercase
            temp = $urandom_range(8'h61, 8'h7A);  // a-z
        return temp;
    endfunction

    // Monitor Results
    initial begin
        $timeformat(-9, 0, " ns", 9);
        #40000ns $display("MEMORY TEST TIMEOUT");
        $finish;
    end

    initial begin: memtest
        // Clear Memory Test remains the same...
        
        // Data = Address Test remains the same...
        
        // Random ASCII Test
        $display("===========================================================");
        $display("                    Data = Random ASCII Test");
        $display("===========================================================\n");   
        error_status = 0;
        
        // Write random printable ASCII characters
        for (int i = 0; i < 32; i++) begin
            rand_data = get_random_ascii();
            mif.write_mem(i, rand_data, debug);
            $display("Writing to addr %0d: ASCII '%c' (hex: %h)", i, rand_data, rand_data);
        end
        
        // Read and verify
        for (int i = 0; i < 32; i++) begin
            mif.read_mem(i, rdata, debug);
            $display("Reading from addr %0d: ASCII '%c' (hex: %h)", i, rdata, rdata);
        end
        
        // Alpha Only Test
        $display("\n===========================================================");
        $display("                    Data = Alpha Only Test");
        $display("===========================================================\n");   
        
        // Write random alpha characters
        for (int i = 0; i < 32; i++) begin
            rand_data = get_random_alpha();
            mif.write_mem(i, rand_data, debug);
            $display("Writing to addr %0d: ASCII '%c' (hex: %h)", i, rand_data, rand_data);
        end
        
        // Weighted Alpha Test
        $display("\n===========================================================");
        $display("                    Data = Weighted Alpha Test");
        $display("===========================================================\n");   
        
        // Write random weighted alpha characters
        for (int i = 0; i < 32; i++) begin
            rand_data = get_weighted_alpha();
            mif.write_mem(i, rand_data, debug);
            $display("Writing to addr %0d: ASCII '%c' (hex: %h)", i, rand_data, rand_data);
        end
    end

    // checkit and printstatus functions remain the same...

endmodule
