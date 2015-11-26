%
% Takes a network net and produces a vector of label predictions in the
% format of the y vector in the data provided.
%
% Note: Network net may either single network with 6 outputs or 6 networks
%       each with a single output.
%
function predictions = testANN(net, x2)

    numberOfNeuralNetworks = length(net);
    numberOfExamples = length(x2);

    % Determine the type of network we're using
    sixOutputNetwork = length(net) == 1;
        
    % A single neural network with 6 outputs for each example
    if(sixOutputNetwork)
        results = sim(net, x2);

    % 6 neural networks with 1 output for each example
    else

        % Initialise an empty matrix
        %results = zeros(numberOfNeuralNetworks, numberOfExamples);

        % Foreach emotion neural network...
        for i = 1:6
            currentNeuralNetwork = net{i};
            %results(i) = sim(currentNeuralNetwork, x2);
            results{i,:} = sim(currentNeuralNetwork, x2);
        end
        results = cell2mat(results);
    end

    % A vector of 1 x numberOfExamples of labels for each example
    predictions = NNout2labels(results);
   
end