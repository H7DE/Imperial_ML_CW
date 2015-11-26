function result = calculate_r_p_rate_fa(confusion_matrix)
% calculate the recall and precision rates
% from a confusion matrix
% calculate fa measure with recall and precision rates evenly weighted
    num_class = size(confusion_matrix,1);
    for class=1:num_class
        true_positives = confusion_matrix(class,class);
        false_positives = sum(confusion_matrix(:, class)) - true_positives;
        false_negatives = sum(confusion_matrix(class, :)) - true_positives;  
        [recall_rate, precision_rate] = recall_and_precision_rates...
            (true_positives, false_positives, false_negatives);     
        
        fa = f_alpha_measure(1, precision_rate, recall_rate);
        
        result(class).class = class;
        result(class).recall_rate = recall_rate;
        result(class).precision_rate = precision_rate;
        result(class).fa_measure = fa;
    end
end