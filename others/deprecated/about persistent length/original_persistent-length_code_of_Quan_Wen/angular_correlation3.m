function corr=angular_correlation3(branches)

% branches=run_disp
N = length(branches);
h = 0;
for i=1:N
    l = size(branches{i},2)-2;
    h = h + l*(l-1)/2;
end
corr = zeros(h,3);
idx = 1; 
                                            
for i=1:N
    branch = branches{i};
    pts = branch;
    v_direction=(pts(:,2:end)-pts(:,1:end-1));
    path=sqrt(sum(v_direction.^2,1));
    l=size(v_direction,2);
    v_norm=v_direction./repmat(path,2,1);

    if l>2
        theta = zeros(l,1);
        dtheta = zeros(l-1,1);
        for p=1:l
            theta(p)=angle(complex(v_norm(1,p),v_norm(2,p)));
        end
        dtheta = diff(unwrap(theta)); %l-1 long
        for j=1:l-2
            for k=j+1:l-1
                %if dtheta(j)>0
                    %corr(idx,:)=[theta(j),dtheta(j)*dtheta(k),sum(path(j:k))];
                    corr(idx,:)=[theta(j),dot(v_norm(:,j),v_norm(:,k)),sum(path(j:k))];
                    idx = idx + 1;
                %end
            end
        end
    end
end

if idx<=h
    corr(idx:h,:)=[];
end
