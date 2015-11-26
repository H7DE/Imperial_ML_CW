function fn = falpha(prec,recl,alpha)
%calculates f-alpha
    fn = (1+alpha)*prec*recl/(alpha*prec+recl);
end

