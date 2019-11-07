m = 50; %number of fish
rho = 0.1; %radius of each fish
h = 0.1; %stepsize

coords = (10*rand(m,2) - 5);
newCoords = [];

for j=1:300
for i=1:m
%k nearest neighbors, # of neighbors is k-1
k = 10;
Idx = knearest(coords, k);
Idx = Idx(i,:);
%n = size(Idx(1,:));

%translate to origin 
A = coords(Idx(1,:),:); %neighbors
B = A - A(1,:);         %shifted to origin
B = B(2:k,:);

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
newCoords(i,:) = h*direction + coords(i,:);

end

%plot(coords(:,1), coords(:,2),'bo')
%hold on
plot(newCoords(:,1), newCoords(:,2),'bo');
xlim([-5 5])
ylim([-5 5])

f(j) = getframe;

coords = newCoords;
end