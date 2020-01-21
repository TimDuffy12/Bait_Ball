function newPredCoords = movePredators(coords, t, r0, k, deltatheta)
h = 0.1; %stepsize

theta = atan2(coords(:,2), coords(:,1));
% r0 = sqrt(coords(:,1).^2 + coords(:,2).^2);
r = (r0 - k).*exp(-t) + k;

newPredCoords = [r.*cos(theta+deltatheta) r.*sin(theta+deltatheta)];

%hold on, plot(newPredCoords(:,1), newPredCoords(:,2), 'or')
end