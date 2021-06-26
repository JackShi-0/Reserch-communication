%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%20210617
%Plot BER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
SNR = 0:2:40;

%test-new
%ocdm
load('0615-ocdm-multipath-sigma-chanknown-1.mat') ; ocdm_mp_sigma = mean(BER_u);
load('0617-ocdm-mp-2sigma-channorm.mat'); ocdm_mp_2sigma = mean(BER_u);
load('0616-ocdm-Doppler-sigma-chanknown-1e-3.mat'); ocdm_doppler_1e3 = mean(BER_u);
load('0617-ocdm-Doppler-sigma-chanknown-5e-4-2.mat'); ocdm_doppler_5e4 = mean(BER_u);
%ofdm
load('0615-ofdm-multipath-sigma-chanknown.mat') ; ofdm_mp_sigma = mean(BER_u);
load('0617-ofdm-mp-2sigma-channorm.mat'); ofdm_mp_2sigma = mean(BER_u);
load('0616-ofdm-Doppler-sigma-chanknown-1e-3.mat'); ofdm_doppler_1e3 = mean(BER_u);
load('0617-ofdm-Doppler-sigma-chanknown-5e-4.mat'); ofdm_doppler_5e4 = mean(BER_u);



figure; 
semilogy(SNR,ofdm_doppler_1e3,'b--+','Linewidth',1);
hold on; 
semilogy(SNR,ofdm_doppler_5e4,'c--d','Linewidth',1);
hold on; 
semilogy(SNR,ofdm_mp_sigma,'r--v','Linewidth',1);
hold on;
semilogy(SNR,ofdm_mp_2sigma,'m--o','Linewidth',1);
hold on; 
semilogy(SNR,ocdm_doppler_1e3,'b+-','Linewidth',1);
hold on; 
semilogy(SNR,ocdm_doppler_5e4,'cd-','Linewidth',1);
hold on; 
semilogy(SNR,ocdm_mp_sigma,'rv-','Linewidth',1);
hold on;
semilogy(SNR,ocdm_mp_2sigma,'mo-','Linewidth',1);
hold on; 

xlim([0,40]);
ylim([10e-7,10e-1]);
xlabel('SNR (dB)');
ylabel('BER');

grid on;
h1 = semilogy(SNR,ofdm_doppler_1e3 + 1,'k-','Linewidth',1);
h2 = semilogy(SNR,ocdm_doppler_1e3 + 1,'k--','Linewidth',1);
h3 = semilogy(SNR(1),ofdm_mp_sigma(1),'rv');
h4 = semilogy(SNR(1),ofdm_mp_2sigma(1),'mo');
h5 = semilogy(SNR(1),ofdm_doppler_1e3(1),'b+');
h6 = semilogy(SNR(1),ofdm_doppler_5e4(1),'cd');
legend([h1,h2,h3,h4,h5,h6],'ZP-OCDM','ZP-OFDM','Multipath: $\sigma$','Multipath: 2$\sigma$',...
    'Multipath+Doppler: $\lambda$=1e-3','Multipath+Doppler: $\lambda$=5e-4',...
    'Interpreter','latex','Location','southwest','FontSize',10);
% set(gcf, 'Color', 'w'); % to set the background color white (gray by default)