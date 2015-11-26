function attributes = createAttributeVector(size)
    attributes = cell(1,size);
    for i = 1:size
    attributes{i} = strcat('AU',int2str(i));
    end
end

