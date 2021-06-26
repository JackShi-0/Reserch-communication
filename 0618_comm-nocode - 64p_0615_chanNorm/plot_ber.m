clear all;
%% ofdm-ocdm nocode
% load('ofdm-zf-nocode.mat')
% zf_ofdm = mean(BER_u,1);
% load('ocdm-zf-nocode-2e4.mat')
% zf_ocdm = mean(BER_u,1);
% load('ofdm-mmse.mat')
% mmse_ofdm = mean(BER_u,1);
% load('ocdm-mmse.mat')
% mmse_ocdm = mean(BER_u,1);
% 
% snr = 0:2:40;
% figure();
% % semilogy(snr,zf_ocdm ,'r-v','LineWidth',1);
% % hold on;
% semilogy(snr,mmse_ocdm,'r-o','LineWidth',1);
% hold on;
% % semilogy(snr,zf_ofdm,'b--v','LineWidth',1);
% % hold on;
% semilogy(snr,mmse_ofdm,'b--o','LineWidth',1);
% hold on;
% grid on;
% xlim([0,40]);
% ylim([10e-7,10e-1]);
% set(gcf, 'Color', [1,1,1])%将窗口底色设置为白色
% % legend('ZP-OCDM: ZF','ZP-OCDM: MMSE','ZP-OFDM: ZF','ZP-OFDM: MMSE',...
% %     'Location','southwest','FontSize',12);
% legend('ZP-OCDM: MMSE','ZP-OFDM: MMSE',...
%     'Location','southwest','FontSize',12);
% xlabel('SNR (dB)');
% ylabel('BER');
% % title('OFDM和OCDM两种信号的比较图');

%% ofdm-ocdm multipath+doppler 2\sigma
% load('new-ocdm-mmse-doppler.mat')
% mmse_ocdm_doppler = mean(BER_u,1);
% load('new-ofdm-mmse-doppler.mat')
% mmse_ofdm_doppler = mean(BER_u,1);
% load('ofdm-mmse.mat')
% mmse_ofdm = mean(BER_u,1);
% load('ocdm-mmse.mat')
% mmse_ocdm = mean(BER_u,1);
% 
% snr = 0:2:40;
% figure();
% 
% semilogy(snr,mmse_ocdm,'r-o','LineWidth',1);
% hold on;
% semilogy(snr,mmse_ofdm,'b--o','LineWidth',1);
% hold on;
% semilogy(snr,mmse_ocdm_doppler ,'r-v','LineWidth',1);
% hold on;
% semilogy(snr,mmse_ofdm_doppler,'b--v','LineWidth',1);
% hold on;
% grid on;
% xlim([0,40]);
% ylim([10e-7,10e-1]);
% set(gcf, 'Color', [1,1,1])%将窗口底色设置为白色
% legend('ZP-OCDM: MMSE-Multipath','ZP-OFDM: MMSE-Multipath','ZP-OCDM: MMSE-Doppler','ZP-OFDM: MMSE-Doppler',...
%     'Location','southwest','FontSize',12);
% % legend('ZP-OCDM: MMSE','ZP-OFDM: MMSE',...
% %     'Location','southwest','FontSize',12);
% xlabel('SNR (dB)');
% ylabel('BER');
% % title('OFDM和OCDM两种信号的比较图');

%% ofdm-ocdm multipath+doppler \sigma
load('0615-ocdm-Doppler-sigma-chanknown.mat')
mmse_ocdm_doppler_sigma = mean(BER_u,1);
load('0615-ofdm-Doppler-sigma-chanknown.mat')
mmse_ofdm_doppler_sigma = mean(BER_u,1);
load('0615-ocdm-multipath-sigma-chanknown.mat')
mmse_ocdm_sigma = mean(BER_u,1);
load('0615-ofdm-multipath-sigma-chanknown.mat')
mmse_ofdm_sigma = mean(BER_u,1);

snr = 0:2:40;
figure();

semilogy(snr,mmse_ocdm_sigma,'r-o','LineWidth',1);
hold on;
semilogy(snr,mmse_ofdm_sigma,'b--o','LineWidth',1);
hold on;
semilogy(snr,mmse_ocdm_doppler_sigma ,'r-v','LineWidth',1);
hold on;
semilogy(snr,mmse_ofdm_doppler_sigma,'b--v','LineWidth',1);
hold on;
grid on;
xlim([0,40]);
ylim([10e-7,10e-1]);
set(gcf, 'Color', [1,1,1])%将窗口底色设置为白色
legend('ZP-OCDM: MMSE-Multipath','ZP-OFDM: MMSE-Multipath','ZP-OCDM: MMSE-Doppler','ZP-OFDM: MMSE-Doppler',...
    'Location','southwest','FontSize',12);
% legend('ZP-OCDM: MMSE','ZP-OFDM: MMSE',...
%     'Location','southwest','FontSize',12);
xlabel('SNR (dB)');
ylabel('BER');
% title('OFDM和OCDM两种信号的比较图');



%% ofdm-ocdm multipath+doppler \sigma
%load('0616-ocdm-Doppler-sigma-chanknown-1e-3.mat')
%load 0617-ofdm-Doppler-sigma-chanknown-7e-4 %存错了这个不是doppler
load 0617-ocdm-Doppler-sigma-chanknown-5e-4
mmse_ocdm_doppler_sigma = mean(BER_u,1);
%load('0616-ofdm-Doppler-sigma-chanknown-1e-3.mat')
load('0617-ofdm-Doppler-sigma-chanknown-5e-4.mat')
mmse_ofdm_doppler_sigma = mean(BER_u,1);
load('0615-ocdm-multipath-sigma-chanknown-1.mat')
mmse_ocdm_sigma = mean(BER_u,1);
load('0615-ofdm-multipath-sigma-chanknown.mat')
mmse_ofdm_sigma = mean(BER_u,1);

snr = 0:2:40;
figure();

semilogy(snr,mmse_ocdm_sigma,'r-o','LineWidth',1);
hold on;
semilogy(snr,mmse_ofdm_sigma,'b--o','LineWidth',1);
hold on;
semilogy(snr,mmse_ocdm_doppler_sigma ,'r-v','LineWidth',1);
hold on;
semilogy(snr,mmse_ofdm_doppler_sigma,'b--v','LineWidth',1);
hold on;
grid on;
xlim([0,40]);
ylim([10e-7,10e-1]);
set(gcf, 'Color', [1,1,1])%将窗口底色设置为白色
legend('ZP-OCDM: MMSE-Multipath','ZP-OFDM: MMSE-Multipath','ZP-OCDM: MMSE-Doppler','ZP-OFDM: MMSE-Doppler',...
    'Location','southwest','FontSize',12);
% legend('ZP-OCDM: MMSE','ZP-OFDM: MMSE',...
%     'Location','southwest','FontSize',12);
xlabel('SNR (dB)');
ylabel('BER');
% title('OFDM和OCDM两种信号的比较图');













%% ofdm-ocdm encoding
% load('ber_zf_ocdm_encode.mat')
% zf_ocdm_encode = mean(BER_u,1);
% load('ber_zf_ocdm_encode2.mat')
% zf_ocdm_encode2 = mean(BER_u,1);
% load('ber_mmse_ocdm_encode.mat')
% mmse_ocdm_encode = mean(BER_u,1);
% load('ber_zf_ofdm_encode.mat')
% zf_ofdm_encode = mean(BER_u,1);
%  load('ber_mmse_ofdm_encode.mat')
% mmse_ofdm_encode = mean(BER_u,1);
% figure();
% semilogy(snr,zf_ocdm_encode ,'r--v','MarkerFaceColor','r','LineWidth',2);
% hold on;
% semilogy(snr,mmse_ocdm_encode,'r- .','MarkerSize',20,'LineWidth',2);
% hold on;
% semilogy(snr,zf_ofdm_encode,'b--v','MarkerFaceColor','b','LineWidth',2);
% hold on;
% semilogy(snr,mmse_ofdm_encode,'b- .','MarkerSize',20,'LineWidth',2);
% hold on;
% xlim([0,40]);
% ylim([10e-7,10e-1]);
% set(gcf, 'Color', [1,1,1])%将窗口底色设置为白色
% legend('OCDM-ZF','OCDM-MMSE','OFDM-ZF','OFDM-MMSE')
% xlabel('SNR (dB)');
% ylabel('BER');
% title('OFDM和OCDM两种信号的比较图');
% 
% figure();
% semilogy(snr,zf_ocdm ,'r--v','MarkerFaceColor','r','LineWidth',2);
% hold on;
% semilogy(snr,zf_ocdm_encode2 ,'b--v','MarkerFaceColor','b','LineWidth',2);
% hold on;