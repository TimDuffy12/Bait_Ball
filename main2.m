n = 50; %number of fish
rho = 0.1; %radius of each fish
rho2 = 0.2; %radius of each predator
h = 0.1; %stepsize
minr = 5; %radius of bait ball

coords = (10*rand(n,2) - 5);
centerOfMass = [mean(coords(:,1)), mean(coords(:,2))];
newCoords = [];
previousDirection = zeros(n,2);
predDirection = zeros(20,2);

predCoords = spawnPredators(20, 2.1);
newPredCoords = [];

r0 = sqrt(predCoords(:,1).^2 + predCoords(:,2).^2); %initial distance from origin to predators
theta = atan2(predCoords(:,2), predCoords(:,1));

for j=1:300
  
%newPredCoords = movePredators(predCoords, j, r0, minr, h./((r0-minr).*exp(-j+6)+minr));
r = (r0 - minr).*exp(-.05*j) + minr;
newPredCoords = [r.*cos(theta+j*h./((r0-minr).*exp(-j+6)+minr)) r.*sin(theta+j*h./((r0-minr).*exp(-j+6)+minr))];
predDirection = newPredCoords - predCoords;
predCoords = newPredCoords;

for i=1:n
    %k nearest neighbors, # of neighbors is k-1
    k = 50;
    Idx = knearest(coords, k);
    Idx = Idx(i,:);
    
    %l nearest neighbors for predators
    l = 1;
    predIdx = predNeighbors(coords, newPredCoords, l);
    preds = predIdx(i,:);
    C = newPredCoords(preds(1,:),:); %neighbors
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
    predIntervals = intFix(predIntervals);
    
    %Calculates the new direction to move in without regard to predators
    direction = newDirection(intervals);
    
    %New direction based on predators
    directionAwayFromPredators = newDirection2(predIntervals);
    directionWithPredators = mean(predDirection(predIdx(:)));
    
    distanceToCenter = sqrt((coords(i,1) - centerOfMass(:,1))^2 + (coords(i,2) - centerOfMass(:,2))^2);
    
    fw = 0.3*min(distanceToPred, 10)/10;
    pw = 0.25*(10 - min(distanceToPred, 10))/10;
    wwp = .3;
    mw = 0.15;
    rw = 0;
    
    if distanceToCenter <= 1
        %Weights for directions
        fw = 0.1*min(distanceToPred, 10)/10;
        pw = 0.35*(10 - min(distanceToPred, 10))/10;
        wwp = 0.1;
        mw = 0.25;
        rw = 0.1;
    end
    

%     if distanceToCenter >= 1
%         %Weights for directions
%         fw = 0.45*min(distanceToPred, 10)/10;
%         pw = 0.45*(10 - min(distanceToPrwred, 10))/10;
%         mw = 0.1;
%         rw = 0;
%     end
        
    %Resistance to forming a tight ball
    resVector = 1./sqrt((coords(i,1) - centerOfMass(:,1))^2 + (coords(i,2) - centerOfMass(:,2))^2);
    
    %wDriection = weighted direction
    wDirection = fw*direction + pw*directionAwayFromPredators + mw.*previousDirection(i,:) + rw.*resVector + wwp.*directionWithPredators;
    %Calculates the new coordinates for the fish
    newCoords(i,:) = h*wDirection + coords(i,:);
    %newCoords(i,:) = .25*(dirTest) + coords(i,:);
    previousDirection(i,:) = wDirection;
    
    
end


%plot(coords(:,1), coords(:,2),'bo')
%hold on
plot(newCoords(:,1), newCoords(:,2),'go', newPredCoords(:,1), newPredCoords(:,2), 'ro',newCoords(n,1), newCoords(n,2),'bo');
%plot(newPredCoords(:,1), newPredCoords(:,2), 'ro');
xlim([-5 5])
ylim([-5 5])

f(j) = getframe;

coords = newCoords;
centerOfMass = [mean(coords(:,1)), mean(coords(:,2))];
end