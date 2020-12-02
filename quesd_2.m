function [ave_tp,aggregate_tp,t_f,r_f] = quesd_2(user_list)
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
flag = 0;
for i = 1:5000 % TTI index
    % assign PRBS
    pos_f = 0;
    for j = 1:n:50 % 50 PRBs
        if flag == 0
            period = [1:n];
        else
            period = [[flag:n],[1:(flag-1)]];
        end
        for k = period
            pos_f = pos_f+1;
            if pos_f>50
                flag = k;% 最后一个拿到prb的user的编号
                break;
            end
            user_total_prb_ro(k,i) = user_total_prb_ro(k,i)+resources_m(k,pos_f,i);
            prb_ro_num(k) = prb_ro_num(k) +1;
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
        tem = zeros(1,n);
        for k = 1:n
            tem(k) = resources_m(k,j,i);
        end
        [~,pos] = max(tem);
        user_total_prb_max(pos,i) = user_total_prb_max(pos,i)+resources_m(pos,j,i);
        prb_max_num(pos) = prb_max_num(pos) + 1;
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
        tem = zeros(1,n);
        for k = 1:n
            tem(k) = resources_normalized(k,j,i);
        end
        [~,pos] = max(tem);
        user_total_prb_pro(pos,i) = user_total_prb_pro(pos,i)+resources_m(pos,j,i);
        prb_pro_num(pos) = prb_pro_num(pos) + 1;
    end
end
rate = sum(user_total_prb_pro'*10^-3)/5;
ave_tp(:,3) = rate;
aggregate_tp(3) = sum(rate);
t_f(3) = jain_2(rate);
r_f(3) = jain_2(prb_pro_num);
end