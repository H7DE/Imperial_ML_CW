function conf = perform_validation(trs,trc,tsts,tstc)
%creates a confusion matrix given training and test set and classifier
trees = cell(1,6);
attributes = createAttributeVector(45);
conf = zeros(6,6);
for i = 1:6
    yi = getTargetForValue(trc,i);
    trees{i} = decision_tree_learning(trs,attributes,yi);
end
classt = testTrees(trees,tsts);
for i = 1:size(tstc,1)
    conf(tsts(i),classt(i)) = conf(tsts(i),classt(i)) + 1;
end
end

