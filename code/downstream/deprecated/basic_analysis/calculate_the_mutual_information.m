function I_mutual = calculate_the_mutual_information(f_of_joint_distribution,f_of_theta_in,f_of_theta_out)

number_of_bin = length(f_of_theta_in);
I_mutual = 0;
for i = 1:number_of_bin
    
    if f_of_theta_in(i) == 0
        continue
    end
    
    for j = 1:number_of_bin
        
        if f_of_theta_out(j) == 0
            continue
        end
        
        if f_of_joint_distribution(i,j) == 0
            continue
        end
        
        I_mutual = I_mutual + f_of_joint_distribution(i,j) * log( f_of_joint_distribution(i,j) / (f_of_theta_in(i)*f_of_theta_out(j)) ) / log(2);
               
%         Z(i,j) = f_of_joint_distribution(i,j) / (f_of_theta_in(i)*f_of_theta_out(j));
%         Z_log(i,j) = f_of_joint_distribution(i,j) / (f_of_theta_in(i)*f_of_theta_out(j));
    end
end
end