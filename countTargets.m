function [pos, neg] = countTargets(binary_targets)
pos = sum(binary_targets == 1);
neg = length(binary_targets) - pos;
end
