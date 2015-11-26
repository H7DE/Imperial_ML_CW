function performances = calculatePerformanceForFolds(confs_matrix)
%for each matrix in confs calculates performance
count = size(confs_matrix,2);
performances = cell(1,count);
for i = 1 : count
    performances{i} = calculatePerformance(confs_matrix{i});
end

end

