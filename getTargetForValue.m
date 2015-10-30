function new_target = getTargetForValue(binary_target,value)
%sets each element in binary_target to 1 if elem is value, else to 0
    new_target = binary_target;
    for i = 1:length(new_target)
        new_target(i) = new_target(i) == value;
    end
end

