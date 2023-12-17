ii = 7;
[theta_in,theta_out,~,~] = extract_theta(esets{ii,1}.eset);
[ratio_0_1,ratio_1_1,label_0,label_1,label,count_0,count_1,count_all] = label_reorientation_NC_NT(theta_in,theta_out);
p_value = Chi_2_test(count_0*ratio_0_1,count_0*(1-ratio_0_1),count_0);
disp(p_value)
p_value = Chi_2_test(count_1*ratio_1_1,count_1*(1-ratio_1_1),count_1);
disp(p_value)