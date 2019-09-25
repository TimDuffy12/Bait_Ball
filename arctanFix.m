function new_ints = arctanFix(ints)

new_ints = ints;

if ints(:,1) > pi/2 && ints(:,1) < pi
    if ints(1,:) > -pi && ints(1,:) < -pi/2
    %fix em
    end
end

if ints(1,:) > pi/2 && ints(1,:) < pi
    if ints(:,1) > -pi && ints(:,1) < -pi/2
    %fix em
    end
end
end