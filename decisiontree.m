classdef decisiontree
    % A class implementing decision tree for emotion recognition
    
    properties
    end
    
    methods
        function dec_tree = decision_tree_learning(examples,attributes,binary_targets)
           op = 'op';
           kids = 'kids';
           class = 'class'; 
           if isAllValuesSame(binary_targets)
                %binary targets is not empty so leaf node with the value in
                %binary targets
               dec_tree = struct(op,[],kids,[],class,binary_targets(1));
           else if isempty(attributes)
               dec_tree = struct(op,[],kids,[],class,
                                   maxOccuringValue(binary_targets));
               end
           end
        end
        function entropy = binary_entropy(p,n)
            if p + n > 0
                entropy = (p/(p+n))*log2(p/(p+n));
                entropy = entropy + (n/(p+n))*log2(n/(p+n));
                entropy = -1 * entropy;
            else
                entropy = 0;
            end
        end
        function att_entr = remainder(p0,n0,p1,n1,p,n)
            if p+n > 0
                att_entr = binary_entropy(p0,n0)*(p0+n0)/(p+n);
                att_entr = att_entr + binary_entropy(p1,n1)*(p1+n1)/(p+n);
            else
                att_entr = 0;
            end
        end
        function best_at = chooseBestAttribute(examples,attribute,binary_targets)
            best_at = 0;
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
    end
    
end

