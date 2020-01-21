function coords = spawnPredators(n, b)
%n is num of preds, b is size of buffer

r = 5*rand(n,1)+(5*sqrt(2)*b);
theta = 2*pi*rand(n,1);
coords = [r.*cos(theta), r.*sin(theta)];
%plot(coords(:,1), coords(:,2), 'or')

end