%
% Construct a confusion matrix from the given 'actual' labellings array
% and 'predicted' lavellings array. This will show where the system is
% confusing classes and mislabelling examples as an incorrect class.
% 
% 'actual' is an array of classes stating what each example should actually
% be labelled as.
%
% 'predicted' is an array of classes stating the predicted labelling given
% to each example.
%
function [confusion_matrix, classes, number_of_labellings] = ...
    confusion_matrix(actual, predicted)

    % Assert that the length of actual labellings is the same as the length
    % of the predicted labellings -> length(actual) = length(predicted).
    %
    % Every predicted labelling must map to an actual (know to be correct)
    % labelling. This allows us to check if a prediction was correct.
    if length(predicted) ~= length(actual)
        error('confusion_matrix - input error.');
    end
    number_of_labellings = length(actual);
    
    % Identify all classes used.
    classes = unique(union(actual, predicted));
    number_of_classes = length(classes);

    % Construct the confusion matrix.
    % (number_of_labellings x number_of_labellings) in size.
    confusion_matrix = zeros(number_of_classes, number_of_classes);
    for i = 1 : number_of_labellings,
        % Increment mapping of predicted against actual in matrix.
        confusion_matrix( actual(i), predicted(i) ) = ...
            confusion_matrix( actual(i), predicted(i) ) + 1;
    end

end