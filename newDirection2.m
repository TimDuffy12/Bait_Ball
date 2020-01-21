function dir = newDirection2(ints)

theta = ints(:);

n = size(ints, 1);

dir = sum([cos(theta) sin(theta)]);

dir = (dir./n)+pi;

end