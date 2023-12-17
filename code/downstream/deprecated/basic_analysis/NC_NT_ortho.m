function type_of_taxis = NC_NT_ortho

prompt = "Which experiment type do you want to use?" + newline + "1: NC" + newline + "2: NT" + newline + "3: ortho\n";
flag = input(prompt);
switch flag
    case 1
        type_of_taxis = 'NC';
    case 2
        type_of_taxis = 'NT';
    case 3
        type_of_taxis = 'ortho';
end

end