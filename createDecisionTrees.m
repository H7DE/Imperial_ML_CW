function trees = createDecisionTrees(x,y)
%given data input x with 45 columns, and classification y (each of value 1-6) returns a
%tree for each emotion
att = createAttributeVector(45);
trees = repmat(struct('op',[],'kids',[],'class',[]), 1, 6);
for i = 1:6
    yi = getTargetForValue(y,i);
    trees(i) = decision_tree_learning(x,att,yi);
end
end

