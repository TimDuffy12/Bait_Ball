function neighbors = knearest(coords, k)

n = size(coords(:,1));

neighbors = knnsearch(coords, coords, 'K', k);

end