function [int]=fishInts(coords,rho)
%Generates list of intervals based on coords of fish given
coords = [ coords, zeros(size(coords,1),2) ];
n = size(coords(:,1));

coords(:,3)=atan2(coords(:,2), coords(:,1)); %phi
R=sqrt(coords(:,2).^2 + coords(:,1).^2); %R is distance between fish
coords(:,4)=asin(rho./R); %theta
for i=1:n
if R(i) <= rho
    coords(i,4) = pi/2;
end
int =[coords(:,3)-coords(:,4), coords(:,3)+coords(:,4)];


end