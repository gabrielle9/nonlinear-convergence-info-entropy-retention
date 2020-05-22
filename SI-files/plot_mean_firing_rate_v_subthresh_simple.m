clearvars

sig_s = 10;
threshs = -5*sig_s:sig_s:5*sig_s;

nl = threshs;

figure
set(gcf,'Position',[185 175 860 340])
subplot(1,2,1)
hold on
fon = 16;

for i = 3:9
    nl(nl<threshs(i))=threshs(i);
    plot(threshs,nl,'LineWidth',11-i)
end

plot(threshs,threshs,'--')
grid on
set(gca,'FontSize',fon)
xlabel('subunit threshold')
ylabel('subunit response')
title('threshold functions for non-spiking units')
xlim([-40 40])
ylim([-40 40])

%%
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/May/6')
load('H_binned_thresh_sweep_nlout_6May20.mat')
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/May/16')

%% line plot of mean "firing rate"

mResps = mResps_reluout(:,:,1);
mmResps = mean(mResps'); %mean of mean responses

% figure
subplot(1,2,2)
plot(threshs,mmResps,'o-','LineWidth',5)

set(gca,'FontSize',16)
xlabel('subunit threshold')
ylabel('mean output "firing rate"')
title('effect of subunit threshold on output response')

%% heat map of mean circuit "firing rate" for threshold sweep

mCircResps = mean(mResps_reluout,3);

figure
imagesc(threshs,threshs,mCircResps')

colorbar
set(gca,'FontSize',18)
xlabel('ON threshold')
ylabel('OFF threshold')
title('mean circuit output firing rate')

