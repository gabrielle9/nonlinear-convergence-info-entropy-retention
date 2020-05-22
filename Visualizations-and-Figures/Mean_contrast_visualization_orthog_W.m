% series of figures for paper
clearvars

Nstim = 1e5;
sig_s = 10;
sig_n = 0;
sig_m = 0; %0.0001;

sdim = 2;
rdim = 2;

%%
stimstem = sig_s.*randn(sdim,Nstim);

point1 = sig_s.*[0;0.5];
point2 = sig_s.*[2;-1.5];
point3 = sig_s.*[-2.25;-1.75];
% point1 = sig_s.*[-0.5;1.5];
% point2 = sig_s.*[2.5;-1.5];
% point3 = sig_s.*[-2.25;-0.25];

stimstem = [point1,point2,point3,stimstem];
sumstim = sum(stimstem);
diffstim = abs(diff(stimstem));

% Wsub = [1,1;1,-1];
Wsub = [cos(3*pi/12),sin(3*pi/12);cos(9*pi/12),sin(9*pi/12)]; %normed
% [nl_resps] = nlsubsResp_reLu_subn(stimstem,sig_n,sig_m);
% [lin_resps] = linsubResp_subn(stimstem,sig_n,sig_m);
% [nl_resps] = nlsubsResp_reLu_sub36(stimstem,sig_n,sig_m,Wsub);
% [lin_resps] = linsubResp_sub36(stimstem,sig_n,sig_m,Wsub);
[nl_resps] = nlsubsResp_reLu_sub36_new(stimstem,sig_n,sig_m,Wsub);
[lin_resps] = linsubResp_sub36_new(stimstem,sig_n,sig_m,Wsub);

nl_resps0 = lin_resps;
nl_resps0(lin_resps<0) = 0;

%% Figure set up
fig1 = figure;
frows = 2;
fcols = 4;
lw = 5;
fon = 16;
ms = 12;
xlbounds = sig_s*5;
xlboundr = sig_s*7;

% pcolor1 = [255, 64, 129]./255;
pcolor1 = [238, 255, 65]./255;
pcolor2 = [0,1,1];

set(gcf,'Position',[1 55 1275 650])

%%
% cmap = colormap(gray(10));
% cmap = colormap(copper(10));
cmap = colormap(bone(10));

% level = -3:2:3;
level = sig_s.*(-3:2:3);

xl = [-xlbounds xlbounds];
subplot(frows,fcols,1)
hold on
plot(stimstem(1,(sumstim>=level(4))),stimstem(2,(sumstim>=level(4))),'*','Color',cmap(9,:))
plot(stimstem(1,(sumstim>=level(3) & sumstim<level(4))),stimstem(2,(sumstim>=level(3) & sumstim<level(4))),'*','Color',cmap(7,:))
plot(stimstem(1,(sumstim>=level(2) & sumstim<level(3))),stimstem(2,(sumstim>=level(2) & sumstim<level(3))),'*','Color',cmap(5,:))
plot(stimstem(1,(sumstim>=level(1) & sumstim<level(2))),stimstem(2,(sumstim>=level(1) & sumstim<level(2))),'*','Color',cmap(3,:))
plot(stimstem(1,(sumstim<level(1))),stimstem(2,(sumstim<level(1))),'*','Color',cmap(1,:))
grid on
plot(point1(1),point1(2),'s','MarkerSize',ms,'LineWidth',lw,'Color',pcolor1)
plot(point2(1),point2(2),'s','MarkerSize',ms,'LineWidth',lw,'Color',pcolor2)
plot(point3(1),point3(2),'o','MarkerSize',ms,'LineWidth',lw,'Color',pcolor1)
axis square
set(gca,'FontSize',fon)
xlabel('s_1')
ylabel('s_2')
title('stimulus space')
xlim(xl)
ylim(xl)
% set(gca,'XTick',[-5:5:5])
% set(gca,'YTick',[-5:5:5])


xl = [-xlboundr xlboundr];
subplot(frows,fcols,2)
hold on
plot(lin_resps((sumstim>=level(4)),1),lin_resps((sumstim>=level(4)),2),'*','Color',cmap(9,:))
plot(lin_resps((sumstim>=level(3) & sumstim<level(4)),1),lin_resps((sumstim>=level(3) & sumstim<level(4)),2),'*','Color',cmap(7,:))
plot(lin_resps((sumstim>=level(2) & sumstim<level(3)),1),lin_resps((sumstim>=level(2) & sumstim<level(3)),2),'*','Color',cmap(5,:))
plot(lin_resps((sumstim>=level(1) & sumstim<level(2)),1),lin_resps((sumstim>=level(1) & sumstim<level(2)),2),'*','Color',cmap(3,:))
plot(lin_resps((sumstim<level(1)),1),lin_resps((sumstim<level(1)),2),'*','Color',cmap(1,:))
grid on
plot(lin_resps(1,1),lin_resps(1,2),'s','MarkerSize',ms+3,'LineWidth',lw+3,'Color',pcolor1)
plot(lin_resps(2,1),lin_resps(2,2),'s','MarkerSize',ms,'LineWidth',lw,'Color',pcolor2)
plot(lin_resps(3,1),lin_resps(3,2),'o','MarkerSize',ms,'LineWidth',lw,'Color',pcolor1)
axis square
set(gca,'FontSize',14)
xlabel('ON response')
ylabel('OFF response')
title('linear responses')
xlim(xl)
ylim(xl)
% set(gca,'XTick',[-6:2:6])
% set(gca,'YTick',[-6:2:6])

xl = [0 xlboundr];
subplot(frows,fcols,3)
hold on
plot(nl_resps0((sumstim>=level(4)),1),nl_resps0((sumstim>=level(4)),2),'o','Color',cmap(9,:))
plot(nl_resps0((sumstim>=level(3) & sumstim<level(4)),1),nl_resps0((sumstim>=level(3) & sumstim<level(4)),2),'*','Color',cmap(7,:))
plot(nl_resps0((sumstim>=level(2) & sumstim<level(3)),1),nl_resps0((sumstim>=level(2) & sumstim<level(3)),2),'*','Color',cmap(5,:))
plot(nl_resps0((sumstim>=level(1) & sumstim<level(2)),1),nl_resps0((sumstim>=level(1) & sumstim<level(2)),2),'*','Color',cmap(3,:))
plot(nl_resps0((sumstim<level(1)),1),nl_resps0((sumstim<level(1)),2),'*','Color',cmap(1,:))
grid on
plot(nl_resps0(1,1),nl_resps0(1,2),'s','MarkerSize',ms+3,'LineWidth',lw+3,'Color',pcolor1)
plot(nl_resps0(2,1),nl_resps0(2,2),'s','MarkerSize',ms,'LineWidth',lw,'Color',pcolor2)
plot(nl_resps0(3,1),nl_resps0(3,2),'o','MarkerSize',ms,'LineWidth',lw,'Color',pcolor1)
axis square
set(gca,'FontSize',14)
xlabel('ON response')
ylabel('OFF response')
title('nonlinear outputs')
% xlim(xl)
% ylim(xl)
% set(gca,'XTick',[-6:2:6])
% set(gca,'YTick',[-6:2:6])

subplot(frows,fcols,4)
hold on
plot(nl_resps((sumstim>=level(4)),1),nl_resps((sumstim>=level(4)),2),'*','Color',cmap(9,:))
plot(nl_resps((sumstim>=level(3) & sumstim<level(4)),1),nl_resps((sumstim>=level(3) & sumstim<level(4)),2),'*','Color',cmap(7,:))
plot(nl_resps((sumstim>=level(2) & sumstim<level(3)),1),nl_resps((sumstim>=level(2) & sumstim<level(3)),2),'*','Color',cmap(5,:))
plot(nl_resps((sumstim>=level(1) & sumstim<level(2)),1),nl_resps((sumstim>=level(1) & sumstim<level(2)),2),'*','Color',cmap(3,:))
plot(nl_resps((sumstim<level(1)),1),nl_resps((sumstim<level(1)),2),'*','Color',cmap(1,:))
grid on
plot(nl_resps(1,1),nl_resps(1,2),'s','MarkerSize',ms,'LineWidth',lw,'Color',pcolor1)
plot(nl_resps(2,1),nl_resps(2,2),'s','MarkerSize',ms,'LineWidth',lw,'Color',pcolor2)
plot(nl_resps(3,1),nl_resps(3,2),'o','MarkerSize',ms,'LineWidth',lw,'Color',pcolor1)
axis square
set(gca,'FontSize',14)
xlabel('ON response')
ylabel('OFF response')
title('nonlinear subunits')
% xlim(xl)
% ylim(xl)
% set(gca,'XTick',[-6:2:6])
% set(gca,'YTick',[-6:2:6])

%%
cmap = colormap(pink(10));
% set(gcf,'Position',[15 250 1260 290])

% clevel = [1,3];
clevel = sig_s.*[1,3];

xl = [-xlbounds xlbounds];
subplot(frows,fcols,5)
hold on
p1a = plot(stimstem(1,(diffstim>=clevel(2))),stimstem(2,(diffstim>=clevel(2))),'o','Color',cmap(1,:));
p2a = plot(stimstem(1,(diffstim>=clevel(1) & diffstim<clevel(2))),stimstem(2,(diffstim>=clevel(1) & diffstim<clevel(2))),'*','Color',cmap(3,:));
p3a = plot(stimstem(1,(diffstim<clevel(1))),stimstem(2,(diffstim<clevel(1))),'+','Color',cmap(5,:));
grid on
% p4a = plot(stimstem(1,1),stimstem(2,1),'rs','MarkerSize',ms,'LineWidth',lw);
% p5a = plot(stimstem(1,2),stimstem(2,2),'cs','MarkerSize',ms,'LineWidth',lw);
% p6a = plot(stimstem(1,3),stimstem(2,3),'ro','MarkerSize',ms,'LineWidth',lw);
axis square
set(gca,'FontSize',fon)
xlabel('s_1')
ylabel('s_2')
title('stimulus space')
xlim(xl)
ylim(xl)

xl = [-xlboundr xlboundr];
subplot(frows,fcols,6)
hold on
p1b = plot(lin_resps((diffstim>=clevel(2)),1),lin_resps((diffstim>=clevel(2)),2),'o','MarkerSize',9,'Color',cmap(1,:));
p2b = plot(lin_resps((diffstim>=clevel(1) & diffstim<clevel(2)),1),lin_resps((diffstim>=clevel(1) & diffstim<clevel(2)),2),'*','MarkerSize',6,'Color',cmap(3,:));
p3b = plot(lin_resps((diffstim<clevel(1)),1),lin_resps((diffstim<clevel(1)),2),'+','MarkerSize',3,'Color',cmap(5,:));
grid on
% p4b = plot(lin_resps(1,1),lin_resps(1,2),'rs','MarkerSize',ms,'LineWidth',lw+3);
% p5b = plot(lin_resps(2,1),lin_resps(2,2),'cs','MarkerSize',ms,'LineWidth',lw);
% p6b = plot(lin_resps(3,1),lin_resps(3,2),'ro','MarkerSize',ms,'LineWidth',lw);
axis square
set(gca,'FontSize',14)
xlabel('ON response')
ylabel('OFF response')
title('linear responses')
xlim(xl)
ylim(xl)

xl = [0 xlboundr];
subplot(frows,fcols,7)
hold on
p1c = plot(nl_resps0((diffstim>=clevel(2)),1),nl_resps0((diffstim>=clevel(2)),2),'o','MarkerSize',9,'Color',cmap(1,:));
p2c = plot(nl_resps0((diffstim>=clevel(1) & diffstim<clevel(2)),1),nl_resps0((diffstim>=clevel(1) & diffstim<clevel(2)),2),'*','MarkerSize',6,'Color',cmap(3,:));
p3c = plot(nl_resps0((diffstim<clevel(1)),1),nl_resps0((diffstim<clevel(1)),2),'+','MarkerSize',3,'Color',cmap(5,:));
grid on
% p4c = plot(nl_resps0(1,1),nl_resps0(1,2),'rs','MarkerSize',ms,'LineWidth',lw+3);
% p5c = plot(nl_resps0(2,1),nl_resps0(2,2),'cs','MarkerSize',ms,'LineWidth',lw);
% p6c = plot(nl_resps0(3,1),nl_resps0(3,2),'ro','MarkerSize',ms,'LineWidth',lw);
axis square
set(gca,'FontSize',14)
xlabel('ON response')
ylabel('OFF response')
title('nonlinear outputs')
% xlim(xl)
% ylim(xl)

subplot(frows,fcols,8)
hold on
p1d = plot(nl_resps((diffstim>=clevel(2)),1),nl_resps((diffstim>=clevel(2)),2),'o','MarkerSize',9,'Color',cmap(1,:));
p2d = plot(nl_resps((diffstim>=clevel(1) & diffstim<clevel(2)),1),nl_resps((diffstim>=clevel(1) & diffstim<clevel(2)),2),'*','MarkerSize',6,'Color',cmap(3,:));
p3d = plot(nl_resps((diffstim<clevel(1)),1),nl_resps((diffstim<clevel(1)),2),'+','MarkerSize',3,'Color',cmap(5,:));
grid on
% p4d = plot(nl_resps(1,1),nl_resps(1,2),'rs','MarkerSize',ms,'LineWidth',lw);
% p5d = plot(nl_resps(2,1),nl_resps(2,2),'cs','MarkerSize',ms,'LineWidth',lw);
% p6d = plot(nl_resps(3,1),nl_resps(3,2),'ro','MarkerSize',ms,'LineWidth',lw);
axis square
set(gca,'FontSize',14)
xlabel('ON response')
ylabel('OFF response')
title('nonlinear subunits')
% xlim(xl)
% ylim(xl)
legend('high contrast','medium contrast','low contrast')
