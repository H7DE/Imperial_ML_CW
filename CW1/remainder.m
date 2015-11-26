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
