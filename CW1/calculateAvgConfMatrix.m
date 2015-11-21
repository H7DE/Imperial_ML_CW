function avg_conf = calculateAvgConfMatrix(conf_matrices)
%takes n (Square) confusion matrix and computes average confusion matrix
len = length(conf_matrices{1});
avg_conf = zeros(len,len);
for i = 1 : length(conf_matrices)
    avg_conf = avg_conf + conf_matrices{i};
end
avg_conf = avg_conf / length(conf_matrices);    
end

