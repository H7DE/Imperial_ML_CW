function [p0 ,p1 ,n0 ,n1] = getAttributeCounts(attrCol,bin_target)
p0 = 0;
p1 = 0;
n0 = 0;
n1 = 0;
for i = 1:size(attrCol,1)
    if attrCol(i) == 1 && bin_target(i) == 1
        p1 = p1 + 1;
    elseif attrCol(i) == 0 && bin_target(i) == 1
        p0 = p0 + 1;
    elseif attrCol(i) == 1 && bin_target(i) == 0
        n1 = n1 + 1;
    elseif attrCol(i) == 0 && bin_target(i) == 0
        n0 = n0 + 1;
    end
end
end