
function [e,f,g,h] = decisiontree(a,b,c)
[e,f,g,h] = splitbyAttribute(a,b,c);

    function dec_tree = decision_tree_learning(examples,attributes,binary_targets)
        op = 'op';
        kids = 'kids';
        class = 'class';
        if isAllValuesSame(binary_targets)
            %binary targets is not empty so leaf node with the value in
            %binary targets
            dec_tree = struct(op,[],kids,[],class,binary_targets(1));
        else if isempty(attributes)
                dec_tree = struct(op,[],kids,[],class,maxOccuringValue(binary_targets));
            else
                best_at = chooseBestAttribute(examples,binary_targets);
                at_name = attributes(best_at);
                dec_tree = struct(op,at_name,kids,kids,class,[]);
                subsets = splitbyAttributes(example,best_at,binary_targets);
                for i = 1 : 2
                    if isEmpty(subsets(i,1))
                        val = maxOccuringValue(binary_targets);
                        leaf = struct(op,[],kids,[],class,val);
                        dec_tree.kids = [dec_tree.kids leaf];
                    else
                        attributes(best_at) = [];
                        subtree = decision_tree_learning(subsets(i,1),attributes,subsets(i,2));
                        dec_tree.kids = [dec_tree.kids subtree];
                    end
                end
            end
        end
    end

    function entropy = binary_entropy(p,n)
        if p ~= 0
            entropy = (p/(p+n))*log2(p/(p+n));
        else
            entropy = 0;
        end
        if n ~= 0
            entropy = entropy + (n/(p+n))*log2(n/(p+n));
        end
        entropy = -1 * entropy;
    end

    function att_entr = remainder(p0,n0,p1,n1)
        p = p0 + p1;
        n = n0 + n1;
        if p+n > 0
            att_entr = binary_entropy(p0,n0)*(p0+n0)/(p+n);
            att_entr = att_entr + binary_entropy(p1,n1)*(p1+n1)/(p+n);
        else
            att_entr = 0;
        end
    end

%choose best attribute to choose to split on
    function best_at = chooseBestAttribute(examples,binary_targets)
        [p, n] = countTargets(binary_targets);
        en = binary_entropy(p,n);
        best_at = 0;
        best_gain = 0;
        for i = 1 : size(examples,2)
            [p0,p1,n0,n1] = getAttributeCounts(examples(:,i),binary_targets);
            cur_rem = remainder(p0,n0,p1,n1);
            cur_gain = en - cur_rem;
            if cur_gain > best_gain || i == 1
                best_at = i;
                best_gain = cur_gain;
            end
        end
    end

    function [p0 ,p1 ,n0 ,n1] = getAttributeCounts(attrCol,bin_target)
        p0 = 0;
        p1 = 0;
        n0 = 0;
        n1 = 0;
        for i = 1:size(attrCol,1)
            if attrCol(i) == 1 && bin_target(i) == 1
                p1 = p1 + 1;
            end
            if attrCol(i) == 0 && bin_target(i) == 1
                p0 = p0 + 1;
            end
            if attrCol(i) == 1 && bin_target(i) == 0
                n1 = n1 + 1;
            end
            if attrCol(i) == 0 && bin_target(i) == 0
                n0 = n0 + 1;
            end
        end
    end

    function [pos, neg] = countTargets(binary_targets)
        pos = sum(binary_targets == 1);
        neg = length(binary_targets) - pos;
    end

    function target = maxOccuringValue(binary_targets)
        target = mode(binary_targets);
    end

    function isSame = isAllValuesSame(binary_targets)
        row = size(binary_targets,1);
        if row > 0
            isSame = all(binary_targets == binary_targets(1));
        else
            isSame = false;
        end
    end

    function [e0, b0, e1, b1] = splitbyAttribute(examples,attribute,binary_targets)
        e0 = examples(:,:);
        e1 = examples(:,:);
        b0 = binary_targets(:);
        b1 = binary_targets(:);
        index0 = 0;
        index1 = 0;
        for i = 1:size(examples,1)
            if examples(i,attribute) == 0
                e0(i-index0,:) = [];
                b0(i-index0) = [];
                index0 = index0 + 1;
            else
                e1(i-index1,:) = [];
                b1(i-index1) = [];
                index1 = index1 + 1;
            end
        end
    end
end
