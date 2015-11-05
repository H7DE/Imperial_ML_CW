function target = maxOccuringValue(binary_targets)
pot_values = [0;1];
counts = histc(binary_targets,pot_values);
if counts(1) > counts(2)
    target = pot_values(1);
elseif counts(2) > counts(1)
    target = pot_values(1);
else
    target = pot_values(randi(2));
end
end
