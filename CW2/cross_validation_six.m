% type = 0 -> train 1 netural network, 6 outputs
% type = 1:6 ->  train 1 netural network for emotion "type" and it has 1
% outputs only (1/0)
% Here, just input x,y don't need to use ANNdata
% Output the best network
function cross_validation_single (datafile, instances, labels,...
                                                index, K)
    version = 1;                                 
    
    % Initialise average confusion matrix
    avg_c_matrix = zeros (6, 6);
    
    % Initialise classification rate
    avg_classification_rate = 0;
    
    layers = [2, 3, 3];
    topology = 3; % Cascade feed forward network
    training_function = 'trainlm';
    
    avg_f_measure = zeros (10, 1);
    
    % K-fold
    for i = 1:K   
        [trainX, trainY, testX, testY] ...
            = get_data_from_fold (instances, labels, index, i);
        %normal K-fold
        [testX_,testY_] = ANNdata(testX,testY);
        [train_X,train_Y] = ANNdata(trainX,trainY);
        
        net = createNetwork(layers,train_X,train_Y, ...
                         topology, training_function);
        net = train(net,train_X, train_Y);    
        
        predictions = testANN(net, testX_);

        predictions_title = ...
            strcat(datafile, '_fold_', num2str(i), ...
            '_version_', num2str(version),'_predictions.mat');
        %save(predictions_title, 'predictions');
        
        c_matrix = confusion_matrix(testY, predictions);
        c_matrix_title = ...
            strcat(datafile, '_fold_', num2str(i),...
            '_version_', num2str(version), '_confusion_matrix.mat');
        %save(c_matrix_title, 'c_matrix');
        avg_c_matrix = avg_c_matrix + c_matrix;
        
        class_r_p_rate_fa = calculate_r_p_rate_fa(avg_c_matrix);
        
        for k = 1:6
            avg_f_measure(i) = avg_f_measure(i) + ...
                class_r_p_rate_fa(k).fa_measure;
        end
        
        avg_f_measure(i) = avg_f_measure(i) / 6;
        
        avg_classification_rate = ...
            avg_classification_rate + ...
            sum(predictions == testY)/length(testY);
        
    end
    
    display(datafile);
    display(version);
    
    %save(strcat(datafile, '_version_', num2str(version),...
    %'_avg_f_measure.mat'), 'avg_f_measure');
    
    % calculate the average confusion matrix
    avg_c_matrix = avg_c_matrix/10;
    display(avg_c_matrix); 
    %save(strcat(datafile, '_version_', num2str(version),...
    %    '_average_confusion_matrix.mat'), 'avg_c_matrix');
    
    % calculate the average recall and precision rate per class
    % from the average confusion matrix
    % calculate fa measure with recall and precision rates evenly weighted
    class_r_p_rate_fa = calculate_r_p_rate_fa(avg_c_matrix);
    %save(strcat(datafile, '_version_', num2str(version),...
    %    '_r_p_rate_fa_per_class.mat'), 'class_r_p_rate_fa');
    
    % calculate the average classification rate
    avg_classification_rate = avg_classification_rate/10;
    display(avg_classification_rate);
    %save(strcat(datafile, '_version_', num2str(version),...
    %    '_avg_classification_rate.mat'), 'avg_classification_rate');

    
end

