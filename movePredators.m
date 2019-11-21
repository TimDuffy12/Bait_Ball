function newPredCoords = movePredators(coords, r)
h = 0.1; %stepsize

theta = atan2(coords(:,2), coords(:,1));

direction = [r*cos(1) r*sin(1)];

newPredCoords = h*direction + coords;

hold on, plot(newPredCoords(:,1), newPredCoords(:,2), 'or')
end