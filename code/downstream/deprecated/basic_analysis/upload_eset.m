function [eset,type_of_C_elegans,type_of_taxis] = upload_eset

data_directory = 'C:\Users\11097\Nutstore\1\Worm-Thermo-Chemotaxis\Data\行为学数据整理';
disp(['Our data is at ' data_directory]);

%% choose the type of C.elegans and the types of experiment
prompt = "Which file do you want to use?" + newline...
    + "1: n2" + newline...
    + "2: smd-ph-minisog" + newline...
    + "3: parallelN2" + newline...
    + "4: ria-chr2(quint)" + newline...
    + "5: ria-twk-18" + newline...
    + "6: aib-ph-minisog" + newline...
    + "7: aiy-twk18" + newline...
    + "8: aser-ph-minisog" + newline...
    + "9: rib-twk-18" + newline...
    + "10: rim-ph-minisog" + newline...
    + "11: smd-ph-minisog-correction" + newline...
    + "12: ria-chr2(quint)-correction" + newline...
    + "13: rmd-ab" + newline...
    ;
flag = input(prompt);
switch flag
    case 1
        type_of_C_elegans = 'n2';
        type_of_taxis = NC_NT_ortho;
    case 2
        type_of_C_elegans = 'smd-ph-minisog';
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);        
    case 3
        type_of_C_elegans = 'parallelN2';
        prompt = "Which experiment type do you want to use?" + newline + "1: NC" + newline + "2: NT" + newline + "3: parallel" + newline + "4: control (no gradient)\n";
        flag = input(prompt);
        switch flag
            case 1
                type_of_taxis = 'NC';
            case 2
                type_of_taxis = 'NT';
            case 3
                type_of_taxis = 'Pa';
            case 4
                type_of_taxis = 'ctl';
        end
    case 4
        type_of_C_elegans = 'ria-chr2(quint)';
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);           
    case 5
        type_of_C_elegans = 'ria-twk-18';
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
        if type_of_taxis == "ortho\control" % This exp use n2 as control
            type_of_taxis = 'ortho\control_n2';
        end
    case 6
        type_of_C_elegans = 'aib-ph-minisog';
        fprintf("This exp only has ortho!\n");
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);        
    case 7
        type_of_C_elegans = 'aiy-twk18';
        fprintf("This exp only has ortho!\n");
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);        
    case 8        
        type_of_C_elegans = 'aser-ph-minisog';
        fprintf("This exp only has ortho!\n");
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
    case 9
        type_of_C_elegans = 'rib-twk-18';
        fprintf("This exp only has ortho!\n");
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
        if type_of_taxis == "ortho\control" % This exp use n2 as control
            type_of_taxis = 'ortho\control_n2';
        end
    case 10
        type_of_C_elegans = 'rim-ph-minisog';
        fprintf("This exp only has ortho!\n");
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
    case 11
        type_of_C_elegans = 'smd-ph-minisog-correction';
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
    case 12
        type_of_C_elegans = 'ria-chr2(quint)-correction';
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
    case 13
        type_of_C_elegans = 'rmd-ab';
        fprintf("This exp only has ortho!\n");
        type_of_taxis = NC_NT_ortho;
        type_of_taxis = control_test(type_of_taxis);
end

%% load eset
eset = load([data_directory '\' type_of_C_elegans '\' type_of_taxis '\eset.mat']);
eset = eset.eset;

end