function isSame = isAllValuesSame(binary_targets)
row = size(binary_targets,1);
if row > 0
    isSame = all(binary_targets == binary_targets(1));
else
    isSame = false;
end
end
