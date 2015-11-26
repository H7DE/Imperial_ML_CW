function [ y ] = load_data( y, desired_label )

% function for Loading Data

% INPUT
% y is a N*1 vector, containing the labels of the corresponding examples
% desired_y is the desired label of the emotion for which 
% the decision tree is to be trained

% OUTPUT
% a N*1 vector, which is the remapped binary targets [y].
    N = size(y, 1);

    for i=1:N
        y(i) = y(i) == desired_label;
    end

end

