coords = (10*rand(10,2) - 5);

%K nearest
k = 6;
Idx = knearest(coords, k);
n = size(Idx(1,:));

%translate to origin
for i=1:6
   C = [];
   A = coords(Idx(i,:),:); %neighbors
   B = A - A(1,:);         %shifted to origin
   C = [C;B]
end

%fishInts


%orderedPairs


%combineInts


%intFix


%newDirection


%New Coords