function [int]=predInts(fishCoords, predCoords, rho2)
%Generates list of intervals based on coords of predators given
fishCoords = [fishCoords, zeros(size(fishCoords,1),2)];
n = size(fishCoords(:,1));

phi=atan2(predCoords(:,2), predCoords(:,1)); %phi
R=sqrt(predCoords(:,2).^2 + predCoords(:,1).^2); %R is distance between fish and preds
theta=asin(rho2./R); %theta

% for i=1:n
% if R(i) <= rho2
%     theta(i)= pi/2;
% end
int =[phi-theta, phi+theta];


end