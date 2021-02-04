% normalized MI plots for Figures 2 and 3 of manuscript

clearvars

% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/4')
% load('Hr_Hn_binned_nDin_sigs10_sqsc_outnoise_pre_cg_relu_out_6Aug20.mat')
% load('Hr_Hn_binned_nDin_sigs10_sqsc_outnoise_pre_cg_relu_out_Hnpart_4Sep20.mat')

cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/9')
load('Hr_Hn_binned_nDin_sigm1_sqsc_outnoise_pre_cg_relu_out_Hnpart_9Sep20.mat')

% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/15')
% load('Hr_Hn_binned_nDin_sigm1_sqsc_outnoise_pre_cg_relu_out_Hnpart_9Sep20_15Sep20.mat')

%% MI
% MI_linsubs_linout_nDin_1Dout = Hr_linsubs_linout_nDin_1Dout(sdims) - Hn_linsubs_linout_nDin_1Dout(sdims);
% MI_linsubs_linout_nDin_2Dout = Hr_linsubs_linout_nDin_2Dout(sdims) - Hn_linsubs_linout_nDin_2Dout(sdims);
MI_linsubs_linout_nDin_1Dout = Hr_linsubs_linout_nDin_1Dout(sdims) - Hn_linout_1Dout;
MI_linsubs_linout_nDin_2Dout = Hr_linsubs_linout_nDin_2Dout(sdims) - Hn_linout_2Dout;

MI_nlsubs_nlout_nDin_1Dout = Hr_nlsubs_nlout_nDin_1Dout(sdims) - Hn_nlsubs_nlout_nDin_1Dout(sdims);
MI_nlsubs_nlout_nDin_2Dout = Hr_nlsubs_nlout_nDin_2Dout(sdims) - Hn_nlsubs_nlout_nDin_2Dout(sdims);

MI_linsubs_nlout_nDin_1Dout = Hr_linsubs_nlout_nDin_1Dout(sdims) - Hn_linsubs_nlout_nDin_1Dout;
MI_linsubs_nlout_nDin_2Dout = Hr_linsubs_nlout_nDin_2Dout(sdims) - Hn_linsubs_nlout_nDin_2Dout;

MI_nlsubs_cgout_nDin_1Dout = Hr_nlsubs_cgout_nDin_1Dout(sdims) - Hn_nlsubs_cgout_nDin_1Dout(sdims);
MI_nlsubs_cgout_nDin_2Dout = Hr_nlsubs_cgout_nDin_2Dout(sdims) - Hn_nlsubs_cgout_nDin_2Dout(sdims);

MI_linsubs_cgout_nDin_1Dout = Hr_linsubs_cgout_nDin_1Dout(sdims) - Hn_linsubs_cgout_nDin_1Dout;
MI_linsubs_cgout_nDin_2Dout = Hr_linsubs_cgout_nDin_2Dout(sdims) - Hn_linsubs_cgout_nDin_2Dout;

%% figure set up
fon = 20;
lw = 5;
ms = 16;
xend = 40;
% sdimsh = [3,8,15];
% xl = [1 25];
xl = [1 sdims(end)];

%% MI plot, nDin, 1Dout, scaled subunits
fig1 = figure; 
axesH = axes;
% fon = 24;

MI_linsubs_nlout_nDin_1Dout_sqsc_norm = MI_linsubs_nlout_nDin_1Dout./MI_linsubs_linout_nDin_1Dout;
MI_nlsubs_nlout_nDin_1Dout_sqsc_norm = MI_nlsubs_nlout_nDin_1Dout./MI_linsubs_linout_nDin_1Dout;
MI_nlsubs_cgout_nDin_1Dout_sqsc_norm = MI_nlsubs_cgout_nDin_1Dout./MI_linsubs_linout_nDin_1Dout;
MI_linsubs_cgout_nDin_1Dout_sqsc_norm = MI_linsubs_cgout_nDin_1Dout./MI_linsubs_linout_nDin_1Dout;

hold on
plot(sdims,MI_nlsubs_nlout_nDin_1Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,MI_linsubs_nlout_nDin_1Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)
plot(sdims,MI_nlsubs_cgout_nDin_1Dout_sqsc_norm,'Color',[0.5,0.2,0.4],'LineWidth',lw)
plot(sdims,MI_linsubs_cgout_nDin_1Dout_sqsc_norm,'Color',[1,0.4,0.8],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized MI')
title({['MI of convergent circuit 1Dout response']})
% legend('nonlinear subunits circuit','linear subunits circuit')
legend('nlsubs nlout','linsubs nlout','nlsubs cgout','linsubs cgout')
xlim(xl)
% ylim([6 12.5])
% ylim([0.5 1.4])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:40])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%% MI plot, nDin, 2Dout, scaled subunits
fig2 = figure; 
axesH = axes;
% fon = 24;

MI_linsubs_nlout_nDin_2Dout_sqsc_norm = MI_linsubs_nlout_nDin_2Dout./MI_linsubs_linout_nDin_2Dout;
MI_nlsubs_nlout_nDin_2Dout_sqsc_norm = MI_nlsubs_nlout_nDin_2Dout./MI_linsubs_linout_nDin_2Dout;
MI_nlsubs_cgout_nDin_2Dout_sqsc_norm = MI_nlsubs_cgout_nDin_2Dout./MI_linsubs_linout_nDin_2Dout;
MI_linsubs_cgout_nDin_2Dout_sqsc_norm = MI_linsubs_cgout_nDin_2Dout./MI_linsubs_linout_nDin_2Dout;

hold on
plot(sdims,MI_nlsubs_nlout_nDin_2Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,MI_linsubs_nlout_nDin_2Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)
plot(sdims,MI_nlsubs_cgout_nDin_2Dout_sqsc_norm,'Color',[0.5,0.2,0.4],'LineWidth',lw)
plot(sdims,MI_linsubs_cgout_nDin_2Dout_sqsc_norm,'Color',[1,0.4,0.8],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized MI')
title({['MI of convergent circuit 2Dout response']})
% legend('nonlinear subunits circuit','linear subunits circuit')
legend('nlsubs nlout','linsubs nlout','nlsubs cgout','linsubs cgout')
xlim(xl)
% ylim([6 12.5])
% ylim([0.5 1.4])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:40])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%%
% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/3')
