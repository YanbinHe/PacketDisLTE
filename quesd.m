function [ave_tp,aggregate_tp,t_f,r_f] = quesd(user_list)
% [SINR,bit_rate_M,aggregate_bit_rate,summation]
[~,n] = size(user_list);
ave_tp = zeros(n,3);
aggregate_tp = zeros(1,3);
t_f = zeros(1,3);
r_f = zeros(1,3);
aggregate_bit_rate_total = zeros(n,5000);
summation_total = zeros(n,1);

for ii = 1:n
    [~,~,c,d] = test(user_list(ii));
    aggregate_bit_rate_total(ii,:)=c;
    summation_total(ii,:) = d;
end

%% round robin
final_rate_ro = zeros(n,5000);
for i = 1:n:5000
    for j = 1:n
        if i+j-1>5000
            break;
        end
        final_rate_ro(j,i+j-1) = aggregate_bit_rate_total(j,i+j-1);
    end
end
rate = sum(final_rate_ro'*10^-3)/5;
ave_tp(:,1) = rate;
aggregate_tp(1) = sum(rate);
t_f(1) = jain_2(rate);
r_f(1) = jain(final_rate_ro);
%% maximum rate
final_rate_max = zeros(n,5000);
for i = 1 : 5000
    tem = zeros(1,n);
    for j = 1:n
        tem(j) = aggregate_bit_rate_total(j,i);
    end
    [~,pos] = max(tem);
    final_rate_max(pos,i) = tem(pos);
end
rate = sum(final_rate_max'*10^-3)/5;
ave_tp(:,2) = rate;
aggregate_tp(2) = sum(rate);
t_f(2) = jain_2(rate);
r_f(2) = jain(final_rate_max);
%% proportional fair
final_rate_pro = zeros(n,5000);
aggregate_bit_rate_total_pro = zeros(n,5000);
for l = 1:n
    aggregate_bit_rate_total_pro(l,:)=aggregate_bit_rate_total(l,:)/mean(aggregate_bit_rate_total(l,:));
end
for i =1:5000
    tem = zeros(1,n);
    for j = 1:n
        tem(j) = aggregate_bit_rate_total_pro(j,i);
    end
    [~,pos] = max(tem);
    final_rate_pro(pos,i) = aggregate_bit_rate_total(pos,i);
end
rate = sum(final_rate_pro'*10^-3)/5;
ave_tp(:,3) = rate;
aggregate_tp(3) = sum(rate);
t_f(3) = jain_2(rate);
r_f(3) = jain(final_rate_pro);
end
