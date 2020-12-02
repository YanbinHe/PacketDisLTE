% length is in km
ISD = 1;
unit = 1/sqrt(3);
%% define the coordinates of the basestations
% it can be a matrix, 2 by 37, every column is the coordinates, (x,y)'
% because in the assignment, the start of number is zero, but in Matlab,
% the index starts from 1, thus we move all the indexes in the assignment
% towards right, namely, adding 1.
global distance 
distance = zeros(2,37);
distance(:,1) = [0,0]';% 0
distance(:,2) = [0,1]';% 1
distance(:,3) = [1.5*unit,0.5]';% 2
distance(:,4) = [1.5*unit,-0.5]';% 3
distance(:,5) = [0,-1]';% 4
distance(:,6) = [-1.5*unit,-0.5]';% 5
distance(:,7) = [-1.5*unit,0.5]';% 6
distance(:,8) = [-1.5*unit,-0.5]';% 7
distance(:,9) = [0,2]';% 8
distance(:,10) = [1.5*unit,1.5]';% 9
distance(:,11) = [3*unit,1]';% 10
distance(:,12) = [3*unit,0]';% 11
distance(:,13) = [3*unit,-1]';% 12
distance(:,14) = [1.5*unit,-1.5]';% 13
distance(:,15) = [0,-2]';% 14
distance(:,16) = [-1.5*unit,-1.5]';% 15
distance(:,17) = [-3*unit,-1]';% 16
distance(:,18) = [-3*unit,0]';% 17
distance(:,19) = [-3*unit,1]';% 18
distance(:,20) = [-3*unit,2]';% 19
distance(:,21) = [-1.5*unit,2.5]';% 20
distance(:,22) = [0,3]';% 21
distance(:,23) = [1.5*unit,2.5]';% 22
distance(:,24) = [3*unit,2]';% 23
distance(:,25) = [4.5*unit,1.5]';% 24
distance(:,26) = [4.5*unit,0.5]';% 25
distance(:,27) = [4.5*unit,-0.5]';% 26
distance(:,28) = [4.5*unit,-1.5]';% 27
distance(:,29) = [3*unit,-2]';% 28
distance(:,30) = [1.5*unit,-2.5]';% 29
distance(:,31) = [0,-3]';% 30
distance(:,32) = [-1.5*unit,-2.5]';% 31
distance(:,33) = [-3*unit,-2]';% 32
distance(:,34) = [-4.5*unit,-1.5]';% 33
distance(:,35) = [-4.5*unit,-0.5]';% 34
distance(:,36) = [-4.5*unit,0.5]';% 35
distance(:,37) = [-4.5*unit,1.5]';% 36
global user 
user = zeros(2,10);
user(:,1) = [unit/10,0]'; %0
user(:,2) = [2*unit/10,0]'; %1
user(:,3) = [3*unit/10,0]'; %2
user(:,4) = [4*unit/10,0]'; %3
user(:,5) = [5*unit/10,0]'; %4
user(:,6) = [6*unit/10,0]'; %5
user(:,7) = [7*unit/10,0]'; %6
user(:,8) = [8*unit/10,0]'; %7
user(:,9) = [9*unit/10,0]'; %8
user(:,10) = [10*unit/10,0]'; %9
k = 1.38064852*10^(-23);
T = 290;
global band_prb 
band_prb = 180*10^3;
noise_db = 10*log10(k*T*band_prb/(10^-3));% noise power in dbm
global noise;
noise = k*T*band_prb/(10^-3); %noise power in mW
total_power = 20;% W
power_prb_linear = 20/(50*10^-3); % power transmitted in each prb in mW
global power_prb;
power_prb = 10*log10(total_power/(50*10^-3)); % power transmitted in each prb in dBm
%% test
quesb
%% quesc
% user_list = [8,9];
% [ave_tp1,aggregate_tp1,tf1,rf1]=quesc(user_list);
% user_list = [8,9];
% [ave_tp,aggregate_tp,tf,rf]=quesc_2(user_list)
%% quesd
% user_list = [4,5,6,7,8,9];
% [~,aggregate_tp1,~,~]=quesd(user_list)
% [~,aggregate_tp,~,~]=quesd_2(user_list)
