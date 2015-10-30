function index = getIndex( attributes_string)
    %takes string of the form AUx where x is a number and returns the value
    %of x
    index = sscanf(char(attributes_string),'%*2c%u');
end

