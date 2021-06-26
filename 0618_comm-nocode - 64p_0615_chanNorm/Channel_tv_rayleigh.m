function [channeloutput,h] = Channel_tv_rayleigh(input , input_SNR , h_input) %%�����ˮ���ŵ����� Ȼ����ϸ�˹������
[Npkt,Nchirp_N_N]=size(input); 
h = h_input;
[r,c]=size(h);
 tmp = zeros(1,Nchirp_N_N);
 output = zeros(Npkt,Nchirp_N_N);%����ź�
 trail = zeros(Npkt+1,Nchirp_N_N);%��β�ź�
 Awgn_output = zeros(Npkt,Nchirp_N_N);%�������������źţ�һ��һ�еļӺ�ȫ��һ���Ч���ǲ�ͬ��
 for i = 1:Npkt 
        tmp = conv(input(i,:),h(i,:));%���
        output(i,:) = tmp(1:Nchirp_N_N)+ trail(i,:);%���ξ���������źż��ϴε���β
        trail(i+1,1:c-1) = tmp(Nchirp_N_N+1:end);   
        Awgn_output(i,:) = awgn(output(i,:) , input_SNR , 'measured');
 end

%% ��awgn�����������˹������
%Awgn_output =awgn(output , input_SNR , 'measured');

channeloutput = Awgn_output;
end