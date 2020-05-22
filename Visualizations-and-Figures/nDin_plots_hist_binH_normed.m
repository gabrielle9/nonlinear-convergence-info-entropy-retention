% script for plotting results of H binned for nDin
% normalized entropy for powerpoint
% now including new results from cumulative gaussian sims

clearvars

% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2019/June/5')
% load('H_binned_nDin_sigs10_no_noise_5June19.mat')

cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_29Mar20.mat')

%% figure set up
fon = 16;
lw = 5;
ms = 16;
xend = 40;
% sdimsh = [3,8,15];
xl = [1 20];

%% entropy plot, nDin, 1Dout, scaled subunits
fig1 = figure; 
axesH = axes;
fon = 24;

Hr_nlout_nDin_1Dout_sqsc_norm = Hr_nlout_nDin_1Dout_sqsc./Hr_lin_nDin_1Dout_sqsc;
Hr_nl_nDin_1Dout_sqsc_norm = Hr_nl_nDin_1Dout_sqsc./Hr_lin_nDin_1Dout_sqsc;

hold on
plot(sdims,Hr_nl_nDin_1Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,Hr_nlout_nDin_1Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)

% plot(sdimsh(1), Hr_nl_nDin_1Dout_sqsc(sdimsh(1)),'p','Color',cmap(1,:),'MarkerSize',ms)
% plot(sdimsh(2), Hr_nl_nDin_1Dout_sqsc(sdimsh(2)),'p','Color',cmap(2,:),'MarkerSize',ms)
% plot(sdimsh(3), Hr_nl_nDin_1Dout_sqsc(sdimsh(3)),'p','Color',cmap(3,:),'MarkerSize',ms)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized entropy')
title({['Entropy of convergent circuit 1Dout response']})
legend('nonlinear subunits circuit','linear subunits circuit')
xlim(xl)
% ylim([6 12.5])
ylim([0.5 1])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:20])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%% entropy plot nDin, 2Dout, scaled subunits
fig2 = figure;
axesH = axes;
fon = 24;

Hr_nlout_nDin_2Dout_sqsc_norm = Hr_nlout_nDin_2Dout_sqsc./Hr_lin_nDin_2Dout_sqsc;
Hr_nl_nDin_2Dout_sqsc_norm = Hr_nl_nDin_2Dout_sqsc./Hr_lin_nDin_2Dout_sqsc;

hold on
plot(sdims,Hr_nl_nDin_2Dout_sqsc_norm,'k','LineWidth',7)
plot(sdims,Hr_nlout_nDin_2Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',5)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized entropy')
title({['Entropy of convergent, divergent'],['circuit response']})
legend('nonlinear subunits circuit','linear subunits circuit')
xlim(xl)
ylim([0.5 1.7])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:20])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%% 1Dout together: entropy plot, nDin, scaled subunits
fig3 = figure; 
axesH = axes;
fon = 24;

Hr_nlout_nDin_1Dout_sqsc_norm = Hr_nlout_nDin_1Dout_sqsc./Hr_lin_nDin_1Dout_sqsc;
Hr_nl_nDin_1Dout_sqsc_norm = Hr_nl_nDin_1Dout_sqsc./Hr_lin_nDin_1Dout_sqsc;

hold on
plot(sdims,Hr_nl_nDin_1Dout_sqsc_norm,'--k','LineWidth',lw)
plot(sdims,Hr_nlout_nDin_1Dout_sqsc_norm,'--','Color',[0.5,0.5,0.5],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized entropy')
title({['Entropy of convergent circuit response']})
legend('nonlinear subunits circuit','linear subunits circuit')
xlim(xl)
% ylim([6 12.5])
ylim([0.5 1.05])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:20])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%% 2Dout together: entropy plot nDin, scaled subunits
fig4 = figure;
axesH = axes;
fon = 24;

Hr_nlout_nDin_2Dout_sqsc_norm = Hr_nlout_nDin_2Dout_sqsc./Hr_lin_nDin_2Dout_sqsc;
Hr_nl_nDin_2Dout_sqsc_norm = Hr_nl_nDin_2Dout_sqsc./Hr_lin_nDin_2Dout_sqsc;

hold on
plot(sdims,Hr_nl_nDin_2Dout_sqsc_norm,'--k','LineWidth',7)
plot(sdims,Hr_nlout_nDin_2Dout_sqsc_norm,'--','Color',[0.5,0.5,0.5],'LineWidth',5)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized entropy')
title({['Entropy of convergent, divergent'],['circuit response']})
legend('nonlinear subunits circuit','linear subunits circuit')
xlim(xl)
% ylim([0.5 1.7])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:20])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%% nDin, 1Dout scaled subunits, cumulative gaussian output nl
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_29Mar20.mat')

fig5 = figure; 
axesH = axes;
fon = 24;

Hr_linsubs_cgout_nDin_1Dout_sqsc_norm = Hr_linsubs_cgout_nDin_1Dout_sqsc./Hr_lin_nDin_1Dout_sqsc;
Hr_nlsubs_cgout_nDin_1Dout_sqsc_norm = Hr_nlsubs_cgout_nDin_1Dout_sqsc./Hr_lin_nDin_1Dout_sqsc;

hold on
plot(sdims,Hr_nlsubs_cgout_nDin_1Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,Hr_linsubs_cgout_nDin_1Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized entropy')
title({['Entropy of 1Dout circuit, CG output']})
legend('nonlinear subunits circuit','linear subunits circuit')
xlim(xl)
% ylim([6 12.5])
% ylim([0.5 1])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:20])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%%
figure(fig3)

plot(sdims,Hr_nlsubs_cgout_nDin_1Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,Hr_linsubs_cgout_nDin_1Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)

legend('nonlinear subunits, reLu out','linear subunits, reLu out','nonlinear subunits, cg out','linear subunits, cg out')

%% nDin, 2Dout scaled subunits, cumulative gaussian output nl
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_29Mar20.mat')

fig6 = figure; 
axesH = axes;
fon = 24;

Hr_linsubs_cgout_nDin_2Dout_sqsc_norm = Hr_linsubs_cgout_nDin_2Dout_sqsc./Hr_lin_nDin_2Dout_sqsc;
Hr_nlsubs_cgout_nDin_2Dout_sqsc_norm = Hr_nlsubs_cgout_nDin_2Dout_sqsc./Hr_lin_nDin_2Dout_sqsc;

hold on
plot(sdims,Hr_nlsubs_cgout_nDin_2Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,Hr_linsubs_cgout_nDin_2Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('normalized entropy')
title({['Entropy of 2Dout circuit, CG output']})
legend('nonlinear subunits circuit','linear subunits circuit')
xlim(xl)
% ylim([6 12.5])
% ylim([0.5 1])
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:20])
axesH.XAxis.MinorTickValues = 1:1:20;
axis square

%%
figure(fig4)

plot(sdims,Hr_nlsubs_cgout_nDin_2Dout_sqsc_norm,'k','LineWidth',lw)
plot(sdims,Hr_linsubs_cgout_nDin_2Dout_sqsc_norm,'Color',[0.5,0.5,0.5],'LineWidth',lw)

legend('nonlinear subunits, reLu out','linear subunits, reLu out','nonlinear subunits, cg out','linear subunits, cg out')

%% plot new results to check
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')
load('H_binned_nDin_sigs10_sqsc_cg_relu_out_29Mar20.mat')

fig7 = figure; 
% axesH = axes;
fon = 24;
lw = 3;

subplot(1,2,1)
hold on
errorbar(sdims,Hr_nlsubs_cgout_nDin_1Dout_sqsc,sdHru_nlsubs_cgout_nDin_1Dout_sqsc,'k','LineWidth',lw)
errorbar(sdims,Hr_linsubs_cgout_nDin_1Dout_sqsc,sdHru_linsubs_cgout_nDin_1Dout_sqsc,'Color',[0.5,0.5,0.5],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('binned entropy (bits)')
title({['Entropy of 1Dout circuit, CG output']})
legend('nonlinear subunits circuit','linear subunits circuit')
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:40])
% axesH.XAxis.MinorTickValues = 1:1:20;


subplot(1,2,2)
hold on
errorbar(sdims,Hr_nlsubs_cgout_nDin_2Dout_sqsc,sdHru_nlsubs_cgout_nDin_2Dout_sqsc,'k','LineWidth',lw)
errorbar(sdims,Hr_linsubs_cgout_nDin_2Dout_sqsc,sdHru_linsubs_cgout_nDin_2Dout_sqsc,'Color',[0.5,0.5,0.5],'LineWidth',lw)

grid on
set(gca,'FontSize',fon)
xlabel('# of subunits')
ylabel('binned entropy (bits)')
title({['Entropy of 2Dout circuit, CG output']})
legend('nonlinear subunits circuit','linear subunits circuit')
set(gca,'XMinorTick','on')
set(gca,'XTick',[1,4:4:40])
% axesH.XAxis.MinorTickValues = 1:1:20;

%%
% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/March/29')


