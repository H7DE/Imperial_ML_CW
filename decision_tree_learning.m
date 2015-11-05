
function dec_tree = decision_tree_learning(examples,attributes,binary_targets)
op = 'op';
kids = 'kids';
class = 'class';
if isAllValuesSame(binary_targets)
    %binary targets is not empty so leaf node with the value in
    %binary targets
    dec_tree = struct(op,[],kids,[],class,binary_targets(1));
elseif isempty(attributes)
    max = maxOccuringValue(binary_targets);
    dec_tree = struct(op,[],kids,[],class,max);
else
    [at_ind,best_at]= chooseBestAttribute(examples,attributes,binary_targets);
    at_name = attributes(at_ind);
    dec_tree = struct(op,at_name,kids,[],class,[]);
    dec_tree.kids = cell(1,2);
    attributes(at_ind) = [];
    for i = 0 : 1
        [e1,b1] = splitbyAttributeValue(examples,best_at,i,binary_targets);
        if isempty(e1)
            maxval = maxOccuringValue(binary_targets);
            leaf = struct(op,[],kids,[],class,maxval);
            dec_tree.kids{i+1} = leaf;
        else
            subtree = decision_tree_learning(e1,attributes,b1);
            dec_tree.kids{i+1} = subtree;
        end
    end
end
end