function predictions = testTrees(T,x2)
%given six trees (one for each emotion) classifies each row of x2 into an
%emotion
    predictions = zeros(1,size(x2,1));
    classes = [1,2,3,4,5,6];
    for i = 1 : size(x2,1)
        sat_class = [];
        for j = 1:6
           if evaluate(T(j),x2(i,:))
            sat_class = [sat_class,j]; %append j to sat_class
           end
        end
        if isempty(sat_class)
            predictions(i) = classify(T,classes);
        else
            predictions(i) = classify(T,sat_class);
        end
    end
end

