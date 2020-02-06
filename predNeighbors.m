function predNeighbors = predNeighbors(coords, newPredCoords, k)

predNeighbors = knnsearch(newPredCoords, coords, 'K', k);

end