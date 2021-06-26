%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2020.12.21 
%信道已知
%比较ocdm和ofdm的检测和通信性能
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
load('HforCom.mat');
Npacket = 1;%the number of subcarriers without pilot
Nchirp = 512; %information bits of each subcarriers
%P_len 就是多径条数L
P_len  = 64;
Ngd = 128;%代码中新增加了保护间隔
V = Nchirp + Ngd;
BER_u = zeros(1,21);
Phi_Nchirp = Phi(Nchirp);
%R_zp
In = eye(Nchirp);
Rzp = [In In(:,1:Ngd)];

count = 1;
tic
for SNR = 0:2:40
    for repeat=1:10000
%% 发送端
%调制方式选择
mod_order = 2; % 调制阶数 QPSK =2, 16QAM =4;
qamMapper = comm.RectangularQAMModulator('ModulationOrder', 2^mod_order,'BitInput',...
                                         true, 'NormalizationMethod', 'Average power'); %modulation method
% 产生随机数列
totalbit = mod_order * Nchirp * Npacket;
bit_gen = randi([0 1], totalbit,1); 
%信道编码
% Encoded_bit=Func_convoCode( bit_gen ,'encode');%1/2码率
%调制
modulation = step(qamMapper,bit_gen ); 
% modulation = step(qamMapper,bit_gen); 
%s/p
symbol = reshape(modulation,Nchirp,Npacket); %reshape the symbol matrix
%IDFnT
% iDFnT_input = zeros(Nchirp,Npacket); %initiate the OCDM input matrix
iDFnT_input = symbol;
ofdm_out = ifft(iDFnT_input)*sqrt(Nchirp);


data = zeros(Nchirp+Ngd,Npacket);
for i = 1:Npacket
    data(:,i) = [ofdm_out(:,i);zeros(Ngd,1)];%ocdm_guard
end

signal = data.';
%% 过信道
[r,h] =  Channel_tv_rayleigh_doppler(signal ,SNR, h_even(repeat,:));%横进横出
% figure();plot(abs(h.'));

%% 接收端

% 信道估计 
h = h.';
r2 = Rzp * r.';

EQ_out_u = zeros(Nchirp,Npacket);
% 信道均衡 wbyy ZF/MMSE
for i = 1:Npacket
    h_i = [h(1:P_len,i);zeros(Nchirp-P_len,1)];
%     h_i = [h(1:P_len,i);zeros(V-P_len,1)];
    H_i = fft(h_i); %放到频域上
%     H = toeplitz([h;zeros(Nchirp-P_len,1)],[h(1),zeros(1,Nchirp+Ngd-1)]);
%     H = toeplitz(h_i,[h_i(1),zeros(1,Nchirp-1)]);
    Y_i = fft(r2(:,i));%频域

    %ZF
%     Gzf = (Rzp*H)^(-1);
%     x_zf = Gzf * r2;
% %     EQ_out_u(:,i) = x_zf;
%     x_zf = ifft(Y_i./ H_i);%frequency domain->time domain
%     EQ_out_u(:,i) = fft(x_zf(1:Nchirp))/sqrt(Nchirp);%解调数据

    
    %MMSE
    rate = 1/10^(SNR/10);
    %rate2 = [2*rate*ones(Ngd,1);rate*ones(Nchirp-Ngd,1)];
    %s_bar_i_est = ifft((conj(H_i).*Y_i)./(H_i.*conj(H_i) + rate2));%frequency domain->time domain
    s_bar_i_est = ifft((conj(H_i).*Y_i)./(H_i.*conj(H_i) + rate));
    EQ_out_u(:,i) = fft(s_bar_i_est(1:Nchirp))/sqrt(Nchirp);
 end
%p/s
EQ_out = reshape(EQ_out_u,Nchirp*Npacket,1);
%demodulation
qamDemapper= comm.RectangularQAMDemodulator('ModulationOrder', ...
    2^mod_order, 'BitOutput', true, 'NormalizationMethod', 'Average power');  
recovbit = step(qamDemapper,EQ_out);
%channel decode
% receive_data = Func_convoCode(recovbit,'decode');
receive_data = recovbit;
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
% save 0615-ofdm-multipath-sigma-chanknown BER_u
% save 0615-ofdm-Doppler-sigma-chanknown BER_u
% save 0615-ofdm-Doppler-sigma-chanknown-2 BER_u
% save 0616-ofdm-Doppler-sigma-chanknown-1e-3 BER_u
% save 0617-ofdm-mp-2sigma-channorm BER_u
% save 0617-ofdm-Doppler-sigma-chanknown-7e-4 BER_u
%save 0617-ofdm-Doppler-sigma-chanknown-5e-4 BER_u