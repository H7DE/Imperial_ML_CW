%choose best attribute to choose to split on
function [at_ind,best_at]= chooseBestAttribute(examples,attributes,binary_targets)
[p, n] = countTargets(binary_targets);
en = binary_entropy(p,n);
best_at = 0;
best_gain = 0;
for i = 1 : size(attributes,2)
    index = getIndex(attributes(i));
    [p0,p1,n0,n1] = getAttributeCounts(examples(:,index),binary_targets);
    cur_rem = remainder(p0,n0,p1,n1);
    cur_gain = en - cur_rem;
    if cur_gain > best_gain || i == 1
        at_ind = i;
        best_at = index;
        best_gain = cur_gain;
    end
end
end
