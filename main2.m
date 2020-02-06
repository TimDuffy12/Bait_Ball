n = 50; %number of fish
rho = 0.1; %radius of each fish
rho2 = 0.2; %radius of each predator
h = 0.2; %stepsize
minr = 5; %radius of bait ball

coords = (10*rand(n,2) - 5);
newCoords = [];

predCoords = spawnPredators(20, 2.1);
newPredCoords = [];

r0 = sqrt(predCoords(:,1).^2 + predCoords(:,2).^2); %initial distance from origin to predators
theta = atan2(predCoords(:,2), predCoords(:,1));

for j=1:500
  
%newPredCoords = movePredators(predCoords, j, r0, minr, h./((r0-minr).*exp(-j+6)+minr));
r = (r0 - minr).*exp(-.05*j) + minr;
newPredCoords = [r.*cos(theta+j*h./((r0-minr).*exp(-j+6)+minr)) r.*sin(theta+j*h./((r0-minr).*exp(-j+6)+minr))];

for i=1:n
%k nearest neighbors, # of neighbors is k-1
k = 50;
Idx = knearest(coords, k);
Idx = Idx(i,:);

%l nearest neighbors for predators
l = 3;
predIdx = predNeighbors(coords, newPredCoords, l);
predIdx = predIdx(i,:);
C = newPredCoords(predIdx(1,:),:); %neighbors
D = C - coords(i,:);         %shifted to origin
distanceToPred = sqrt(D(1,1)^2 + D(1,2)^2); %distance to nearest pred
                                            %used later for weighting
%translate to origin
A = coords(Idx(1,:),:); %neighbors
B = A - A(1,:);         %shifted to origin
B = B(2:k,:);

%Get intervals based on fish coordinates
intervals = fishInts(B,rho);
predIntervals = predInts(B, D, rho2);

%Sort pairs from smallest to largest left endpoint
intervals = orderedPairs(intervals);
predIntervals = orderedPairs(predIntervals);

%Combine overlapping intervals
intervals = combineInts(intervals);
predIntervals = combineInts(predIntervals);

%Normalizes intervals to be between 0 and 2pi
intervals = intFix(intervals);
predeIntervals = intFix(predIntervals);

%Calculates the new direction to move in without regard to predators
direction = newDirection(intervals);

%New direction based on predators
directionAwayFromPredators = newDirection2(predIntervals);

%Weights for directions
fw = min(distanceToPred, 10)/10;
pw = (10 - min(distanceToPred, 10))/10;

%Calculates the new coordinates for the fish
newCoords(i,:) = h*(fw*direction + pw*(directionAwayFromPredators)) + coords(i,:);
%newCoords(i,:) = .25*(dirTest) + coords(i,:);



end

%plot(coords(:,1), coords(:,2),'bo')
%hold on
plot(newCoords(:,1), newCoords(:,2),'go', newPredCoords(:,1), newPredCoords(:,2), 'ro',newCoords(n,1), newCoords(n,2),'bo');
%plot(newPredCoords(:,1), newPredCoords(:,2), 'ro');
xlim([-10 10])
ylim([-10 10])

f(j) = getframe;

coords = newCoords;
end