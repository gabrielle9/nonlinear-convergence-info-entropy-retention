clearvars

% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/7')
% load('H_binned_threshsweep_subs_nlout_finethresh_7Sep20.mat')
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/10')
load('H_MI_binned_threshsweep_subs_nlout_finethresh_10Sep20.mat')

%%
% MI_threshsweep_subs_linout_lownoise = Hr_threshsweep_subs_linout_lownoise - Hn_threshsweep_subs_linout_lownoise;
% MI_threshsweep_subs_linout_highnoise = Hr_threshsweep_subs_linout_highnoise - Hn_threshsweep_subs_linout_highnoise;

MI_lin_lownoise = Hr_linsubs_linout_lownoise - Hn_linsubs_linout_lownoise;
MI_lin_highnoise = Hr_linsubs_linout_highnoise - Hn_linsubs_linout_highnoise;

MI_lin_highnoise_36Din = Hr_linsubs_linout_highnoise_36Din - Hn_linsubs_linout_highnoise;

% MI_threshsweep_subs_linout_lownoise_norm = MI_threshsweep_subs_linout_lownoise./MI_lin_lownoise;
% MI_threshsweep_subs_linout_highnoise_norm = MI_threshsweep_subs_linout_highnoise./MI_lin_highnoise;

%%
MI_threshsweep_subs_nlout_lownoise = Hr_threshsweep_subs_nlout_lownoise - Hn_threshsweep_subs_nlout_lownoise;
MI_threshsweep_subs_nlout_highnoise = Hr_threshsweep_subs_nlout_highnoise - Hn_threshsweep_subs_nlout_highnoise;
MI_threshsweep_subs_nlout_highnoise_36Din = Hr_threshsweep_subs_nlout_highnoise_36Din - Hn_threshsweep_subs_nlout_highnoise_36Din;

MI_threshsweep_subs_nlout_lownoise_norm = MI_threshsweep_subs_nlout_lownoise./MI_lin_lownoise;
MI_threshsweep_subs_nlout_highnoise_norm = MI_threshsweep_subs_nlout_highnoise./MI_lin_highnoise;
MI_threshsweep_subs_nlout_highnoise_36Din_norm = MI_threshsweep_subs_nlout_highnoise_36Din./MI_lin_highnoise_36Din;

Hr_threshsweep_subs_nlout_nonoise_norm = Hr_threshsweep_subs_nlout_nonoise./Hr_linsubs_linout_nonoise;

%%
tempthreshs = threshs;
tempthreshs(1) = -40;
lw = 3;

figure; hold on
plot(tempthreshs,Hr_threshsweep_subs_nlout_nonoise_norm,'o-','LineWidth',lw)
plot(tempthreshs,MI_threshsweep_subs_nlout_lownoise_norm,'o-','LineWidth',lw)
plot(tempthreshs,MI_threshsweep_subs_nlout_highnoise_norm,'o-','LineWidth',lw)
plot(tempthreshs,MI_threshsweep_subs_nlout_highnoise_36Din_norm,'o-','LineWidth',lw)
grid on
set(gca,'FontSize',20)
set(gca,'FontSize',16)
ylabel('normalized MI')
xlabel('subunit threshold')
title(['Subunit threshold sweeps, ReLU outputs, ' num2str(2) 'Din, ' num2str(rdim) 'Dout'])
legend('no output noise',['low output noise, \sigma_m = ' num2str(low_sig)],['high output noise, \sigma_m = ' num2str(high_sig)],['36D in high output noise, \sigma_m = ' num2str(high_sig)])
set(gca,'XTickLabel',threshs([1,2:4:end]))

% figure; hold on
% plot(tempthreshs,MI_threshsweep_subs_linout_lownoise_norm,'o-','LineWidth',lw)
% plot(tempthreshs,MI_threshsweep_subs_linout_highnoise_norm,'o-','LineWidth',lw)
% grid on
% set(gca,'FontSize',20)
% set(gca,'FontSize',16)
% ylabel('normalized MI')
% xlabel('subunit threshold')
% title('Subunit threshold sweeps, linear outputs, 36Din, 2Dout')
% legend(['low output noise, \sigma_m = ' num2str(low_sig)],['high output noise, \sigma_m = ' num2str(high_sig)])
% set(gca,'XTickLabel',threshs)

