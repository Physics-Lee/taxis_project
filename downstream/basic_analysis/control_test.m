function type_of_taxis_new = control_test(type_of_taxis)

prompt = "control or test?" + newline + "1: control" + newline + "2: test\n";
flag = input(prompt);
switch flag
    case 1
        type_of_taxis_new = [type_of_taxis '\control'];
    case 2
        type_of_taxis_new = [type_of_taxis '\test'];
end

end