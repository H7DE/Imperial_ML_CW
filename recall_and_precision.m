function [ recall,precision ] = recall_and_precision(tp,fp,tn,fn)
%calculates recall and precision rates
    recall = (tp/(tp + fn))*100;
    precision = (tp/(tp+fp))*100;
end

