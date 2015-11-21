function conf = perform_validation(trs,trc,tsts,tstc)
%creates a confusion matrix given training and test set and classifier
trees = createDecisionTrees(trs,trc);
conf = zeros(6,6);
classt = testTrees(trees,tsts);
for i = 1:size(tstc,1)
    ac_class = tstc(i);
    pred_class = classt(i);
    conf(ac_class,pred_class) = conf(ac_class,pred_class) + 1;
end
end

