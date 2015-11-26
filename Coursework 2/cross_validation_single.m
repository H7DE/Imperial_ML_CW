% type = 0 -> train 1 netural network, 6 outputs
% type = 1:6 ->  train 1 netural network for emotion "type" and it has 1
% outputs only (1/0)
% Here, just input x,y don't need to use ANNdata
% Output the best network
function cross_validation_single (datafile, instances, labels,...
                                                index, K)
    version = 2;
                                            
    params(1).topology = 3;
    params(1).layers = [2, 3, 3];
    params(1).training_function = 'trainlm';
    
    params(2).topology = 3;
    params(2).layers = [2, 2, 2];
    params(2).training_function = 'trainlm';
    
    params(3).topology = 3;
    params(3).layers = [3, 3, 3];
    params(3).training_function = 'trainlm';
                                            
    params(4).topology = 3;
    params(4).layers = [3, 2, 2];
    params(4).training_function = 'trainlm';
                                            
    params(5).topology = 3;
    params(5).layers = [2, 3, 2];
    params(5).training_function = 'trainlm';    
    
    
    params(6).topology = 3;
    params(6).layers = [2, 2, 2];
    params(6).training_function = 'trainlm';  
    
    % Initialise average confusion matrix
    avg_c_matrix = zeros (6, 6);
    
    % Initialise classification rate
    avg_classification_rate = 0;
    
    avg_f_measure = zeros (10, 1);
    
    % K-fold
    for i = 1:K   
        [trainX, trainY, testX, testY] ...
            = get_data_from_fold (instances, labels, index, i);
        %normal K-fold
        [testX_,testY_] = ANNdata(testX,testY);
        [train_X,train_Y] = ANNdata(trainX,trainY);
        for j = 1:6
            testY_ = transpose(load_data(testY,j));
            train_Y = transpose(load_data(trainY,j));
            net = createNetwork(params(j).layers,train_X,train_Y, ...
                             params(j).topology, params(j).training_function);
            net = train(net,train_X, train_Y);
            nets{j} = net;     
        end    
        
        predictions = testANN(nets, testX_);

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

