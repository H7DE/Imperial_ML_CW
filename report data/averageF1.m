function f1 = averageF1(p)
f1 = 0;
for i = 1:length(p)
    f1 = f1 + p{i}(3);
end
f1 = f1 / length(p) + eps;
end

