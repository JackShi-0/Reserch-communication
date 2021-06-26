function [channeloutput,h] = Channel_tv_rayleigh(input , input_SNR , h_input) %%这个是水声信道仿真 然后加上高斯白噪声
[Npkt,Nchirp_N_N]=size(input); 
h = h_input;
[r,c]=size(h);
 tmp = zeros(1,Nchirp_N_N);
 output = zeros(Npkt,Nchirp_N_N);%输出信号
 trail = zeros(Npkt+1,Nchirp_N_N);%拖尾信号
 Awgn_output = zeros(Npkt,Nchirp_N_N);%添加噪声的输出信号，一行一行的加和全部一起加效果是不同的
 for i = 1:Npkt 
        tmp = conv(input(i,:),h(i,:));%卷积
        output(i,:) = tmp(1:Nchirp_N_N)+ trail(i,:);%本次卷积产生的信号加上次的拖尾
        trail(i+1,1:c-1) = tmp(Nchirp_N_N+1:end);   
        Awgn_output(i,:) = awgn(output(i,:) , input_SNR , 'measured');
 end

%% 用awgn函数来加入高斯白噪声
%Awgn_output =awgn(output , input_SNR , 'measured');

channeloutput = Awgn_output;
end