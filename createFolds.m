function confs = createFolds(x,y,folds)
    start = 1;
    n = size(x,1);
    rem = mod(n,folds);
    sz = floor(n / folds);
    confs = cell(1,folds);
    for i = 1:folds
        if i <= rem
           xi = x(start:start+sz,:); %test set
           yi = y(start:start+sz,:);
           x_t = x; %training set
           y_t = y;
           x_t(start:start+sz,:) = [];
           y_t(start:start+sz,:)=[];
           start = start + sz + 1;
        else
           xi = x(start:start+sz-1,:); %test set
           yi = y(start:start+sz-1,:);
           x_t = x; %training set
           y_t = y;
           x_t(start:start+sz-1,:) = [];
           y_t(start:start+sz-1,:)=[];
           start = start + sz;
        end
        confs{i} = perform_validation(xi,yi,x_t,y_t);
    end
end

