clearvars

sig_s = 10;
threshs = -5*sig_s:sig_s:5*sig_s;

nl = threshs;

figure
hold on

for i = 3:9
    nl(nl<threshs(i))=threshs(i);
    plot(threshs,nl,'LineWidth',11-i)
end

plot(threshs,threshs,'--')
grid on
set(gca,'FontSize',16)
xlabel('subunit threshold')
ylabel('subunit response')
title('threshold functions for non-spiking units')
xlim([-40 40])
ylim([-40 40])

