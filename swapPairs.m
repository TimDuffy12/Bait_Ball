function ints=swapPairs(pairs)

%swaps left and right endpoints so smaller is on left
ints = pairs;

for i=1:size(pairs, 1)
    if pairs(i, 1) > pairs(i, 2)
        ints(i, 1) = pairs(i, 2);
        ints(i, 2) = pairs(i, 1);
    end
end

end