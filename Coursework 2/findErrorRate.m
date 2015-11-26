function err = findErrorRate(predictions, real)
if (length(predictions)~=length(real))
    error('Error in find error rate!');
end
err = sum(predictions~=real)/length(real);
end