function main () 

load('cleandata_students.mat');
load('cleandata_students_10_fold_indices.mat');

% optimaises parameters using the first fold 
% this code is only run once to get the best parameters for networks
%[trainX, trainY, testX, testY] = get_data_from_fold (x, y, indices, 1);
%[layers, topology, trainingFunction] = ...
%    getOptimalParams(trainX, trainY, testX, testY);

layers = [2, 3, 3];
topology = 3; % Cascade feed forward network
trainingFunction = 'trainlm';
[trainingInstances, trainingLabels] = ANNdata (x, y);

% part VII: 
sixOutputNetwork = createNetwork(layers, trainingInstances, ...
    trainingLabels, topology, trainingFunction);
sixOutputNetwork = ...
    train(sixOutputNetwork, trainingInstances, trainingLabels);
save('six_output_network_clean.mat', 'sixOutputNetwork');

% a six-output neural network
cross_validation_six('cleandata_students.mat', x, y, indices, 10);

%six single-output neural network
cross_validation_single('cleandata_students.mat', x, y, indices, 10);




load('noisydata_students.mat');
load('noisydata_students_10_fold_indices.mat');

% a six-output neural network
cross_validation_six('noisydata_students.mat', x, y, indices, 10);

%six single-output neural network
cross_validation_single('noisydata_students.mat', x, y, indices, 10);

end
