function predNeighbors = predNeighbors(coords, newPredCoords, k)

n = size(coords(:,1));

predNeighbors = knnsearch(newPredCoords, coords, 'K', k);

end