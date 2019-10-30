function [value1, value2] = change_value(value1, value2)
    tmp = value1;
    value1 = value2;
    value2=tmp;
end