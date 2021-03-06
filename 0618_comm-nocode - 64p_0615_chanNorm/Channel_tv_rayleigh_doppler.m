function [channeloutput,h] = Channel_tv_rayleigh_doppler(input , input_SNR, h_input) %%这个是水声信道仿真 然后加上高斯白噪声
[Npkt,Nchirp_N_N]=size(input);
h = h_input;
%Doppler
%Doppler = -0.001 + (0.001 + 0.001).*rand([1 1]);
%Doppler = -0.003 + (0.003 + 0.003).*rand([1 1]);
%Doppler = -0.0003 + (0.0003 + 0.0003).*rand([1 1]);
%Doppler = -0.0007 + (0.0007 + 0.0007).*rand([1 1]);
Doppler = -0.0005 + (0.0005 + 0.0005).*rand([1 1]);
s_Dop = resample(input,round((1-Doppler)*6000),6000);
[r,c]=size(h);
%     tmp1 = zeros(1,Nchirp_N_N);
    output = zeros(Npkt,Nchirp_N_N);%输出信号
    trail = zeros(Npkt+1,Nchirp_N_N);%拖尾信号
    Awgn_output = zeros(Npkt,Nchirp_N_N);%添加噪声的输出信号，一行一行的加和全部一起加效果是不同的
    N1 = Nchirp_N_N + c -1;
   for i = 1:Npkt 
        tmp = conv(s_Dop(i,:),h(i,:));%卷积
        if (N1 >= length(tmp))
             tmp1 = [tmp zeros(1,N1-length(tmp))]; 
        else
             tmp1 = tmp(1:N1);
        end
        output(i,:) = tmp1(1:Nchirp_N_N)+ trail(i,:);%本次卷积产生的信号加上次的拖尾
        trail(i+1,1:c-1) = tmp1(Nchirp_N_N+1:end);   
        Awgn_output(i,:) = awgn(output(i,:) , input_SNR , 'measured');
   end

%% 用awgn函数来加入高斯白噪声
%Awgn_output =awgn(output , input_SNR , 'measured');

channeloutput = Awgn_output;
end