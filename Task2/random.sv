class randtrans;
    randc bit [4:0] rand_add;
    rand bit [7:0] rand_data;
       
    constraint const1 {
        rand_data dist { [8'h41:8'h5A] := 80, [8'h61:8'h7A] := 20 };
    }
endclass
