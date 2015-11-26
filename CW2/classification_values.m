%
% Calculate the classification values for the given actual labellings,
% predicted labellings and class.
%
% That is to say - calculate the number of true_positives, true_negatives,
% false_positives and false_negatives.
%
function [true_positives, true_negatives, false_positives, ...
    false_negatives] = classification_values(class, actual, predicted)

    matrix = classification_matrix(class, actual, predicted);
   
    true_positives  = matrix(1, 1);
    true_negatives  = matrix(2, 2);
    false_positives = matrix(2, 1);
    false_negatives = matrix(1, 2);
end


%
% Construct a classification matrix for the given actual labellings,
% predicted labellings and class as described in the specification document
% in section 4.d
%
function classification_matrix = ...
    classification_matrix(class, actual, predicted)

    % Assert that the length of actual labellings is the same as the length
    % of the predicted labellings -> length(actual) = length(predicted).
    %
    % Every predicted labelling must map to an actual (know to be correct)
    % labelling. This allows us to check if a prediction was correct.
    if length(predicted) ~= length(actual)
        error('classification_matrix - input error. The length of ' + ...
            'the "predicted" labellings must be the same as the ' + ...
            'length of the "actual" labellings.');
    end
    number_of_labellings = length(actual);
    
    % Initialise classification matrix.
    classification_matrix = zeros(2, 2);
    
    for i = 1 : number_of_labellings,
        if actual(i) == class

            % True positive (1, 1)
            if actual(i) == predicted(i)
                classification_matrix(1, 1) = ...
                    classification_matrix(1, 1) + 1;

            % False negative (1, 2)
            else
                classification_matrix(1, 2) = ...
                    classification_matrix(1, 2) + 1;
            end
            
        else
            
            % False positive (2, 1)
            if predicted(i) == class
                classification_matrix(2,1) = ...
                    classification_matrix(2,1) + 1;
                
            % True negative (2, 2)
            else
                classification_matrix(2, 2) = ...
                    classification_matrix(2,2) + 1;
            end
        end
    end
end