m = 10; %number of fish
rho = 0.1;

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

%fishInts
intervals = fishInts(B,rho);

%orderedPairs
intervals = orderedPairs(intervals);

%combineInts
intervals = combineInts(intervals);

%intFix
intervals = intFix(intervals);

%newDirection
direction = newDirection(intervals);

%New Coords
newCoords = [newCoords; direction + coords(i,:)];

end

%coords = newCoords;
scatter(coords(:,1), coords(:,2))
hold on
scatter(newCoords(:,1), newCoords(:,2))