function comb_ints=combineInts(pairs)
%Combines overlapping intervals
comb_ints = pairs;
n = size(comb_ints, 1);
del_rows = zeros(n, 1);

for i=1:n-1
    if comb_ints(i,2) > comb_ints(i+1,1)
        del_rows(i) = 1;
        comb_ints(i+1,1) = comb_ints(i,1);
        
        if comb_ints(i,2) > comb_ints(i+1,2)
            comb_ints(i+1,2) = comb_ints(i,2);
        end
        
    end
end
del_rows;
comb_ints(logical(del_rows), :) = [];

end