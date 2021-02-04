% generate Fig. S7

clearvars

% load results saved from H_orthogonalizing_weights.m
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/4')
load('H_binned_subweights_4Sep20.mat')

%%
figure
frows = 1;
fcols = 2;
fon = 18;

sws4 = 4;
cmap = colormap(lines(10));
cmap2 = colormap(autumn(sws4+1));
set(gcf,'Position',[75 60 1055 405])

for j = 1:sws4
    Wsub_on = [cos((pi/4)+(j-1)*pi/12),sin((pi/4)+(j-1)*pi/12)];
    Wsub_off = [cos((pi/4)-(j-1)*pi/12),sin((pi/4)-(j-1)*pi/12)];
    
    Wsub = [Wsub_on;Wsub_off];

    subplot(frows,fcols,1); hold on
    plot([0,Wsub_on(1)],[0,Wsub_on(2)],'LineWidth',3,'Color',cmap2(j,:))
    plot([0,Wsub_off(1)],[0,Wsub_off(2)],'--','LineWidth',3,'Color',cmap2(j,:))
end

subplot(frows,fcols,2); hold on
% plot(1:sws4,H_lin_nlout(1:sws4),'o-','LineWidth',3,'Color',cmap(4,:))
% plot(1:sws4,H_nl_nlout(1:sws4),'o-','LineWidth',2,'Color',cmap(5,:))
% plot(1:sws4,H_lin_linout(1:sws4),'o-','LineWidth',3,'Color',cmap(6,:))
errorbar(1:sws4,H_lin_nlout(1:sws4),sdH_lin_nlout(1:sws4),'o-','LineWidth',3,'Color',cmap(4,:))
errorbar(1:sws4,H_nl_nlout(1:sws4),sdH_nl_nlout(1:sws4),'o-','LineWidth',2,'Color',cmap(5,:))
errorbar(1:sws4,H_lin_linout(1:sws4),sdH_lin_linout(1:sws4),'o-','LineWidth',3,'Color',cmap(6,:))


set(gca,'FontSize',fon)
xlabel('weights rotation index')
ylabel('H_{resp} (bits)')
title('Entropy (binned)')
grid on
legend('lin subs, nl out','nl subs, nl out','lin subs, lin out')

subplot(frows,fcols,1)
set(gca,'FontSize',fon)
grid on
xlabel('subunit weight 1')
ylabel('subunit weight 2')
xlim([-1 1])
ylim([-1 1])
title('orthogonalizing subunit weights')
axis square
legend('ON weights','OFF weights')


