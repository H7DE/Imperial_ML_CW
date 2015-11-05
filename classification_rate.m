function avg_rate = classification_rate(conf_matrix)
%calculates the classification rate given the (Square) confusion matrix
% this is diagonals/(total matrix sum)
    total_sum = sum(conf_matrix(:));
    diagonals = 0;
    for i = 1 : length(conf_matrix)
        diagonals = diagonals + conf_matrix(i,i);
    end
    avg_rate = diagonals / (total_sum + eps);
end

