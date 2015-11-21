function values = calculatePerformance(conf_matrix)
    values = cell(1,length(conf_matrix));
    class_rate = classification_rate(conf_matrix);
    for i = 1 : length(conf_matrix)
        [TP,FP,TN,FN] = computeTFPN(conf_matrix,i);
        value = zeros(1,4);
        [value(1),value(2)] = recall_and_precision(TP,FP,TN,FN);
        value(3) = falpha(value(1),value(2),1);
        value(4) = class_rate;
        values{i} = value;
    end
end

