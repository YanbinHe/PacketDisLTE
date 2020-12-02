% [SINR,bit_rate_M,aggregate_bit_rate,summation]
aggregate_bit_rate_total = zeros(10,5000);
summation_total = zeros(10,1);
for k = 1:10
    [~,~,c,d] = test(k-1);
    aggregate_bit_rate_total(k,:)=c;
    summation_total(k,:) = d;
end
figure(1)
plot(aggregate_bit_rate_total');
xlabel('Transmission time interval');
ylabel('Bit rate/Mbps');
hold on