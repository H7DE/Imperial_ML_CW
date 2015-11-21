function [TP,FP,TN,FN] = computeTFPN(confusion,class)
%computes TP,FP,TN and FN for the given class and confusion matrix
TP = 0;
FP = 0;
TN = 0;
FN = 0;
for i = 1:size(confusion,1)
    for j = 1:size(confusion,2)
        if i == class && j == class
            TP = TP + confusion(i,j);
        end
        if i == class && j ~= class
            FN = FN + confusion(i,j);
        end
        if i ~= class && j == class
            FP = FP + confusion(i,j);
        end
        if i ~= class && j ~= class
            TN = TN + confusion(i,j);
        end
    end
end
end

