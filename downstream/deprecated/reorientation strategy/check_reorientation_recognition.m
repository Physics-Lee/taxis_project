[eset,type_of_C_elegans,type_of_taxis] = upload_eset;
reorientation_times = extract_reorientation_time(eset);
histogram(reorientation_times,20);
xlabel('reorientation time (s)');
ylabel('count');
title(sprintf('%s %s', type_of_C_elegans, type_of_taxis));