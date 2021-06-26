function [channeloutput,h] = Channel_tv_rayleigh_doppler(input , input_SNR, h_input) %%�����ˮ���ŵ����� Ȼ����ϸ�˹������
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
    output = zeros(Npkt,Nchirp_N_N);%����ź�
    trail = zeros(Npkt+1,Nchirp_N_N);%��β�ź�
    Awgn_output = zeros(Npkt,Nchirp_N_N);%��������������źţ�һ��һ�еļӺ�ȫ��һ���Ч���ǲ�ͬ��
    N1 = Nchirp_N_N + c -1;
   for i = 1:Npkt 
        tmp = conv(s_Dop(i,:),h(i,:));%����
        if (N1 >= length(tmp))
             tmp1 = [tmp zeros(1,N1-length(tmp))]; 
        else
             tmp1 = tmp(1:N1);
        end
        output(i,:) = tmp1(1:Nchirp_N_N)+ trail(i,:);%���ξ����������źż��ϴε���β
        trail(i+1,1:c-1) = tmp1(Nchirp_N_N+1:end);   
        Awgn_output(i,:) = awgn(output(i,:) , input_SNR , 'measured');
   end

%% ��awgn�����������˹������
%Awgn_output =awgn(output , input_SNR , 'measured');

channeloutput = Awgn_output;
end