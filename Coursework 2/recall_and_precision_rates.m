%
% Calculate the recall and precision rates given the number of true
% positives, false positives and false negatives from the confusion matrix.
%
function [ recall_rate, precision_rate ] = ...
    recall_and_precision_rates(true_positives, false_positives, ...
    false_negatives)

    recall_rate = calculate_recall_rate(true_positives, false_negatives);
    precision_rate = calculate_precision_rate(true_positives, ...
        false_positives);

end


%
% Implement recall rate calculation as described in the specification
% document in section 4.e
%
%                         true_positives
% recall_rate = -------------------------------- * 100%
%               true_positives + false_negatives
%
function recall_rate = calculate_recall_rate(true_positives, ...
    false_negatives)

    recall_rate = ( 100 * true_positives ) / ...
        ( true_positives + false_negatives );

end


%
% Implement precision rate calculation as described in the specification
% document in section 4.e
%
%                            true_positives
% precision_rate = -------------------------------- * 100%
%                  true_positives + false_positives
%
function precision_rate = calculate_precision_rate(true_positives, ...
    false_positives)

    precision_rate = ( 100 * true_positives ) / ...
        ( true_positives + false_positives );

end