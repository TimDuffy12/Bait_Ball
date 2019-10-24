function dir = newDirection(ints)

n = size(ints, 1)

dir = sum([cos(ints(:,1)) sin(ints(:,2))])

dir = dir./n

end