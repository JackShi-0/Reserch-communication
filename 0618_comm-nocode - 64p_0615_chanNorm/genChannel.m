%%生成信道
clear;
P = 128;  %多径数量%记得和P_len一起更改
t = 0:1e-3:1e-3*(P-1);
dB = 20;
beta = (dB/10)*log(10)/(t(P)-t(1));
B = exp(-beta*t);
% [Npkt,Nchirp_N_N]=size(input);
Npkt = 10000; %原本是1条 指的是mc数
% Nchirp_N_N = 128;
h = zeros(Npkt,P);
energy = 0;
for i = 1:Npkt
  %多径的幅值A服从瑞丽分布
    %The amplitudes of paths are Rayleigh distribution with the average power 
    %decreasing exponentially with the delay, where the difference between the 
    %beginning and the end of the guard time is 20dB
    A_real = raylrnd(B);
    A_img = raylrnd(B);
    A = A_real+1i*A_img;
    %A = A/sqrt(sum(A.^2));%归一化
    energy = energy + sum(A.^2);
    h(i,:) = A;
end
avergeEnergy = energy / Npkt;
h_even = h ./ sqrt(avergeEnergy); %%用这个信道

% energy_test = 0;
% for i = 1:Npkt
%     energy_test = energy_test + sum(h_even(i,:).^2);
% end
% avergeEnergy_test = energy_test / Npkt;