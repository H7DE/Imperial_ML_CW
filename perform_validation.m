function conf = perform_validation(trs,trc,tsts,tstc,confusion)
%creates a confusion matrix given training and test set and classifier
trees = cell(1,6);
attributes = createAttributeVector(45);
conf = confusion;
for i = 1:6
    yi = getTargetForValue(trc,i);
    trees{i} = decision_tree_learning(trs,attributes,yi);
    for j = 1:size(tstc,1)
        if evaluate(trees{i},tsts(j,:))
            if tstc(j) == i
                conf(i,i) = conf(i,i) + 1;
            else 
                ind = tstc(j);
                conf(ind,i) = conf(ind,i) + 1;
            end
        end
    end
end
end

