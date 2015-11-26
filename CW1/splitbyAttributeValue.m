function [e0, b0] = splitbyAttributeValue(examples,attribute,value,binary_targets)
e0 = examples(:,:);
b0 = binary_targets(:);
indexshift = 0;
for i = 1:size(examples,1)
    if examples(i,attribute) ~= value
        e0(i-indexshift,:) = [];
        b0(i-indexshift) = [];
        indexshift = indexshift + 1;
    end
end
end