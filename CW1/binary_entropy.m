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