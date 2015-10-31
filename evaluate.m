function finalclass = evaluate(tree,row_vector)
% takes a single tree and a row_vectore with n attributes and determines if
% it is classified as 0 or 1 according to tree, row_Vector must have 45
% columns for emotion classification
    if ~isempty(tree.class)
        %return leaf value
        finalclass = tree.class;
    else
        %it's a node
        index = getIndex(tree.op); % 0 or 1
        val = row_vector(index);
        finalclass = evaluate(tree.kids{val+1},row_vector);
    end
end

