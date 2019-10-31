m = 10; %number of fish
rho = 0.1; %radius of each fish

coords = (10*rand(m,2) - 5);
newCoords = [];

for i=1:m
%K nearest
k = 6;
Idx = knearest(coords, k);
Idx = Idx(i,:);
%n = size(Idx(1,:));

%translate to origin 
A = coords(Idx(1,:),:); %neighbors
B = A - A(1,:);         %shifted to origin
B = B(2:6,:);

%Get intervals based on fish coordinates
intervals = fishInts(B,rho);

%Sort pairs from smallest to largest left endpoint
intervals = orderedPairs(intervals);

%Combine overlapping intervals
intervals = combineInts(intervals);

%Normalizes intervals to be between 0 and 2pi
intervals = intFix(intervals);

%Calculates the new direction to move in
direction = newDirection(intervals);

%Calculates the new coordinates for the fish
newCoords = [newCoords; direction + coords(i,:)];

end

%coords = newCoords;
scatter(coords(:,1), coords(:,2))
hold on
scatter(newCoords(:,1), newCoords(:,2))