function [ave_tp,aggregate_tp,t_f,r_f] = quesc_2(user_list)
% [SINR,bit_rate_M 50 by 5000,aggregate_bit_rate,summation]
[~,n] = size(user_list);
ave_tp = zeros(n,3);
aggregate_tp = zeros(1,3);
t_f = zeros(1,3);
r_f = zeros(1,3);
aggregate_bit_rate_total = zeros(n,5000);
summation_total = zeros(n,1);
resources_m = zeros(n,50,5000);
for ii = 1:n
    [~,b,c,d] = test(user_list(ii));
    resources_m(ii,:,:)=b;
    aggregate_bit_rate_total(ii,:)=c;
    summation_total(ii,:) = d;
end
%% round robin 2 users
user_total_prb_ro = zeros(n,5000);
prb_ro_num = zeros(1,n);
for i = 1:5000 % TTI index
    % assign PRBS        
    for j = 1:50 % 50 PRBs
            if mod(j,2) == 1
                user_total_prb_ro(1,i) = user_total_prb_ro(1,i)+resources_m(1,j,i);%8
                prb_ro_num(1) = prb_ro_num(1) +1;
            else
                user_total_prb_ro(2,i) = user_total_prb_ro(2,i)+resources_m(2,j,i);%9
                prb_ro_num(2) = prb_ro_num(2) +1;
            end
    end
end
rate = sum(user_total_prb_ro'*10^-3)/5;
ave_tp(:,1) = rate;
aggregate_tp(1) = sum(rate);
t_f(1) = jain_2(rate);
r_f(1) = jain_2(prb_ro_num);
%% maximum rate 2 users
user_total_prb_max = zeros(n,5000);
prb_max_num = zeros(1,n);
for i = 1:5000
    % assign PRBs
    for j =1:50
        if resources_m(1,j,i)>=resources_m(2,j,i)
            user_total_prb_max(1,i) = user_total_prb_max(1,i)+resources_m(1,j,i);
            prb_max_num(1) = prb_max_num(1) +1;
        else
            user_total_prb_max(2,i) = user_total_prb_max(2,i)+resources_m(2,j,i);
            prb_max_num(2) = prb_max_num(2) +1;
        end
    end
end
rate = sum(user_total_prb_max'*10^-3)/5;
ave_tp(:,2) = rate;
aggregate_tp(2) = sum(rate);
t_f(2) = jain_2(rate);
r_f(2) = jain_2(prb_max_num);
%% proportional fair
user_total_prb_pro = zeros(n,5000);
prb_pro_num = zeros(1,n);
% first calculate the time-average aggregate bit rate
aggregation = zeros(1,n);
for i = 1:n
    aggregate_bit_rate = sum(resources_m(i,:,:));
    aggregation(i) = sum(aggregate_bit_rate*10^-3)/5;
    resources_normalized(i,:,:) = resources_m(i,:,:)/aggregation(i);
end
for i = 1:5000
    % assign PRBs
    for j = 1:50
        if resources_normalized(1,j,i)>=resources_normalized(2,j,i)
            user_total_prb_pro(1,i) = user_total_prb_pro(1,i)+resources_m(1,j,i);
            prb_pro_num(1) = prb_pro_num(1) +1;
        else
            user_total_prb_pro(2,i) = user_total_prb_pro(2,i)+resources_m(2,j,i);
            prb_pro_num(2) = prb_pro_num(2) +1;
        end
    end
end
rate = sum(user_total_prb_pro'*10^-3)/5;
ave_tp(:,3) = rate;
aggregate_tp(3) = sum(rate);
t_f(3) = jain_2(rate);
r_f(3) = jain_2(prb_pro_num);
end