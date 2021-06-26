%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2020.12.21 
%信道已知
%比较ocdm和ofdm的检测和通信性能
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
Npacket = 1;%the number of subcarriers without pilot
Nchirp = 512; %information bits of each subcarriers
P_len  = 128;
Ngd = 128;%代码中新增加了保护间隔
V = Nchirp + Ngd;
BER_u = zeros(1,21);
Phi_Nchirp = Phi(Nchirp);
In = eye(Nchirp);
Rzp = [In In(:,1:Ngd)];%R_zp
count = 1;
tic
for SNR = 0:2:40
%     seed=12345;
%     rng(seed);%产生固定的随机数列   
    for repeat=1:10000
%% 发送端
%调制方式选择
mod_order = 2; % 调制阶数 QPSK =2, 16QAM =4;
qamMapper = comm.RectangularQAMModulator('ModulationOrder', 2^mod_order,'BitInput',...
                                         true, 'NormalizationMethod', 'Average power'); %modulation method
% 产生随机数列
subcarrier_allocation = 1:1:Nchirp; %the index for data subcarrier
Nscd = length(subcarrier_allocation); %the num of data subcarrier for one symbol
% totalbit = mod_order *Nscd * Npacket; %the total bits of a packet
totalbit = Nscd * Npacket;
bit_gen = randi([0 1], totalbit,1);
%信道编码
Encoded_bit=Func_convoCode( bit_gen ,'encode');%1/2码率
%调制
modulation = step(qamMapper,Encoded_bit); 
% pilot = zeros(Nscd,1);
% pilot(1,1)=sqrt(Nscd);
% modulation_new=[pilot;modulation;];
% modulation = step(qamMapper,bit_gen); 
%s/p
symbol = reshape(modulation,Nscd,Npacket); %reshape the symbol matrix
%IDFnT
iDFnT_input = symbol;
ocdm_out = Phi_Nchirp'*iDFnT_input;
%template
% temp1_ocdm =  Phi_Nchirp(:, 1:Nchirp) * modulation(1:Nchirp);

data = zeros(Nchirp+Ngd,Npacket);
% temp1_ocdm_new = zeros(Nlength+Ngd,Npacket);
for i = 1:Npacket
    data(:,i) = [ocdm_out(:,i);zeros(Ngd,1)];%ocdm_guard
%     temp1_ocdm_new(:,i)=[temp1_ocdm(:,i);zeros(Ngd,1)];
end

%只加白噪声
% y=awgn(data , SNR , 'measured');
%  EQ_out_u = Phi_Nchirp * y((1:Nchirp),:);

signal = data.';
% temp1_ocdm_new = temp1_ocdm_new.';
%% 过信道
% [y1,h] =  Channel_tv_rayleigh(signal ,SNR);%横进横出
% [y_pilot,h1]=Channel_tv_rayleigh(temp1_ocdm_new,SNR);
% figure();plot(abs(h.'));
[r,h] =  Channel_tv_rayleigh(signal ,SNR);%横进横出

%% 接收端
% y_pilot_1 = conv(temp1_ocdm_new,h);
% y_pilot = y_pilot_1(1:length(y1));
% y = y1-y_pilot;
% % y = y1;
% % y=y1-temp1_ocdm_new;

% 信道估计 

h = h.';
r2 = Rzp * r.';

EQ_out_u = zeros(Nchirp,Npacket);
% 信道均衡 wbyy ZF/MMSE
for i = 1:Npacket
    h_i = [h(1:P_len,i);zeros(Nchirp-P_len,1)];
    H_i = fft(h_i);
 
    Y_i = fft(r2(:,i));

    %ZF
    s_bar_i_est = ifft(Y_i./H_i);%frequency domain->time domain
    EQ_out_u(:,i) = Phi_Nchirp*s_bar_i_est;
    
    %MMSE
%     rate = 1/10^(SNR/10);%是信噪比里面那个系数里面的倒数
%     rate2 = [2*rate*ones(Ngd,1);rate*ones(Nchirp-Ngd,1)];
%     s_bar_i_est = ifft((conj(H_i).*Y_i)./(H_i.*conj(H_i)+rate2));%frequency domain->time domain
%     EQ_out_u(:,i) = Phi_Nchirp * s_bar_i_est(1:Nchirp);
 end
%p/s
% EQ_out = EQ_out_u(1+Nchirp:end);
EQ_out = reshape(EQ_out_u,Nchirp*Npacket,1);
%demodulation
qamDemapper= comm.RectangularQAMDemodulator('ModulationOrder', ...
    2^mod_order, 'BitOutput', true, 'NormalizationMethod', 'Average power');  
recovbit = step(qamDemapper,EQ_out);
%channel decode
receive_data = Func_convoCode(recovbit,'decode');
%BER
BER_u(repeat,count) = sum(receive_data~= bit_gen)./length(receive_data);
% BER_u(repeat,count) = sum(recovbit~= bit_gen)./length(recovbit);
    end
    count = count+1;
end
% snr = 0:2:40;
% figure();
% xlim([0,40]);
% semilogy(snr,BER_u);
a = mean(BER_u,1);
snr = 0:2:40;figure();semilogy(snr,a);
xlim([0,40]);
toc
