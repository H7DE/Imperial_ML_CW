function [ trainX, trainY, testX, testY ] =...
    get_data_from_fold( instances, labels, indexs, i )
%GET_DATA_FROM_FOLD Summary of this function goes here
% Gets training and test data from x, and y using indices in fold i
        test = indexs == i;
        train = ~test;
        testX = instances(test, :);
        testY = labels(test, :);
        trainX = instances(train, :);
        trainY = labels(train, :);
end

