function [layers, trainingFunction, topology] = ...
    getOptimalParams(trainX, trainY, testX, testY)
    training_functions = {'trainscg', 'traingdm', 'trainlm','trainbfg',...
                          'traincgb','traincgf','traincgp',...
                          'traingda','traingdx', ...
                           'trainoss','trainrp'};
    % training_functions = {'trainscg', 'traingdm', 'trainlm'};
    % We will find the best number of layers, the best number of neurons in
    % each layer, training functions and best topology
    best_n = 3;
    best_err = 1;
    best_topology = 4;
    best_training_function = '';
    
    % type == 0: train one 6-output neural network 
    % type == 1:6  train one single-output neural network for emotion type
    type = 0;
    
    % initialise results structure
    count = 1;
       
    results(count).topology = 1;
    results(count).first_layer_neurons = 1;
    results(count).second_layer_neurons = 0;
    results(count).third_layer_neurons = 0;
    results(count).training_function = '';
    results(count).mse_err = 0;
    
    % Nested K-fold in current fold here where K=3
    ind = crossvalind('Kfold', size(trainX, 1), 3);
    for j = 1:3    
        [trainX_, trainY_, validX, validY] =...
            get_data_from_fold (trainX, trainY, ind, j);
            [tX,tY] = ANNdata(trainX_, trainY_);
            [vX,vY] = ANNdata(validX, validY);
        if(type~=0)
            %make the labels trainnable
            tY = transpose(load_data(trainY_,type));
            validY = transpose(load_data(validY,type));
            vY = validY;
        end
        
        best_n_in_this_subfold = 3;
        best_err_in_this_subfold = 1;
        best_training_function_in_this_subfold = '';
        best_topology_in_this_subfold = 4;
        %Train topology, for 1-3 see createNetwork
        for topology=1:3
            %optimise first hidden layers max 3 neturons in this layer
            for a=1:3   %1
                    % optimise second layers as well 
                for b=0:3 % 0
                    %optimise third layers
                   for c=0:3  %0
                        layers = [a,b,c];
                        current_layers = layers(layers~=0);
                        best_training_function_local = '';
                        best_net_err_local = 1;
                        current_topology = topology;
                        % optimise training funciton
                        for z = 1 : length(training_functions);
                            current_training_function = training_functions{z};
                            %create a network
                            temp_net = createNetwork(current_layers,...
                                  tX, tY, current_topology,...
                                  current_training_function);
                            % configure parameters for the nueral network
                            temp_net.divideFcn = 'divideind';
                            temp_net.trainParam.show = 5;
                            temp_net.trainParam.lr = 0.001;
                            size_t_y = length(trainY);
                            temp_net.divideParam.trainInd = 1:size_t_y;
                            temp_net.divideParam.valInd   = ...
                                size_t_y+1:length(validY)+size_t_y;
                            %caculate error rate from the trained network
                            [ann_trained, ann_para] = ...
                                train(temp_net, horzcat(tX,vX), ...
                                horzcat(tY,vY));
                            %fprintf('Error Rate: %d', error_rate);
                            
                            mse_err = ann_para.best_perf;
                            print_parameters(results, count,...
                                    current_topology, a, b, c,...
                                    current_training_function, mse_err);
                            count = count + 1;
                            if(mse_err < best_net_err_local)
                                best_training_function_local =...
                                    training_functions{z};
                                best_net_err_local = mse_err;
                            end
                        end
                        %save the best error in subfold
                        if( best_net_err_local<best_err_in_this_subfold)
                            best_err_in_this_subfold=best_net_err_local;
                            best_n_in_this_subfold = current_layers;
                            best_topology_in_this_subfold = topology;
                            best_training_function_in_this_subfold =...
                                best_training_function_local;
                        end 
                    end
                end
            end
        end
        display(best_n_in_this_subfold);
        fprintf('\nIn subfold %d, best training function is %s and best topology is %d with error rate %d in validation set\n',j,best_training_function_local,best_topology_in_this_subfold,best_err_in_this_subfold);
        %save the best net
        if(best_err_in_this_subfold<best_err)
                best_err = best_err_in_this_subfold;
                best_n= best_n_in_this_subfold;
                best_topology =  best_topology_in_this_subfold;
                best_training_function = best_training_function_in_this_subfold;
        end
    end
    display(best_n);
    fprintf('\nIn conclude, best training function is %s and best topology is %d with error rate %d in validation set\n',best_training_function,best_topology,best_err);
    save('optimise_parameters_analysis.mat', 'results');
end
 
function print_parameters(results, count, current_topology, a, b, c, ...
        current_training_function, mse_err)
        fprintf('topology = %d\n', current_topology);
        fprintf('1st layer neurons = %d\n', a);
        fprintf('2nd layer neurons = %d\n', b);
        fprintf('3rd layer neurons = %d\n', c);
        fprintf('training function = %s\n', ...
            current_training_function);
        display(mse_err);

        results(count).topology = current_topology;
        results(count).first_layer_neurons = a;
        results(count).second_layer_neurons = b;
        results(count).third_layer_neurons = c;
        results(count).training_function = ...
            current_training_function;
        results(count).mse_err = mse_err;
end