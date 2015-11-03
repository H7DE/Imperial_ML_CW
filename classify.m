function class = classify(T,potential_classes)
% chooses a suitable class given the potential_classes that the data satisfied
bool = true;
if bool %gives preference to balanced trees
    clone_classes = potential_classes;
    j = 0;
    for i = 1:length(potential_classes)
       if ~isBalanced(T(i-j))
        clone_classes(i-j) = [];
        j = j + 1;
       end
    end
    if isempty(clone_classes)
        clone_classes = potential_classes;
    end
    class = clone_classes(randi(length(clone_classes)));
else  %gives preference to shorter trees
    tree_sizes = treesizes(T);
    class = potential_classes(find(rand <= cumsum(getProb(tree_sizes)),1,'first'));
end
    function treesizes = sizes(T)
        treesizes = zeros(1,size(T,1));
        for i = 1 : size(T,1)
            treesizes(i) = getTreeSize(T(i));
        end
    end
    function treesize = getTreeSize(T)
        if isempty(T.kids)
            treesize = 1;
        else
            treesize = 1 + max(getTreeSize(T.kids(1)),getTreeSize(T.kids(2)));
        end
    end
    function probs = getProb(values)
       total = sum(values);
       probs = zeros(1,length(values));
       for i = 1:length(values)
        probs(i) = values(i)/total+eps;
       end
    end
    function isBalanced = isTreeBal(tree)
       if isempty(tree.kids)
        isBalanced = true;
       else
        left_l = getTreeSize(tree.kids(1));
        left_r = getTreeSize(tree.kids(2));
        isBalanced = isTreeBal(tree.kids(1)) && isTreeBal(tree.kids(2)) && abs(left_l-left_r) <= 2;
       end
    end
end

