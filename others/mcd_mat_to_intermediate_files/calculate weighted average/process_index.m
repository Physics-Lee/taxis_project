function process_index(list,indx)
    
    count = 0;

    for i = indx
        count = count + 1;
        if contains(list{i},'Or') || contains(list{i},'Ctl') 
            new_str_1 = strrep(list{i},'.mat','_chemo_index.mat');
            list{i} = new_str_1;
            new_str_2 = strrep(list{i},'.mat','_thermo_index.mat');
            list = insert_an_element(list, new_str_2);
            new_str_3 = strrep(list{i},'.mat','_ortho_index.mat');
            count = count + 2;
        end
    end
end

function myCell = insert_an_element(myCell, newElement)
    myCell = {myCell{1:n}, newElement, myCell{n+1:end}};
end