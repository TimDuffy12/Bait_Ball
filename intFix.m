function new_ints = intFix(ints)

new_ints = ints;
n = size(ints,1);

for i=1:n
    if new_ints(i,2) > pi
        new_ints = [new_ints; [new_ints(i,1), pi]];
        new_ints(i,:) = [-pi, new_ints(i,2)-2*pi];
    end

    if new_ints(i,1) < -pi
        new_ints = [new_ints; [-pi, new_ints(i,2)]];
        new_ints(i,:) = [new_ints(i,1)+2*pi, pi];
    end
end
end