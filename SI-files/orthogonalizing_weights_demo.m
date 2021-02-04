% generate Fig. S6

clearvars

Nstim = 1e4;
sdim = 2;
rdim = 2;
sig_s = 10;
sig_n = 0;
sig_m = 0;

sws4 = 4; %7; %number of angles

% bw = sig_s*(1e-3); %sig_s*(1e-2); %*sqrt(sdim);
% edgebound = ceil(5.5*sig_s*sqrt(sdim));
% edges = -edgebound:bw:edgebound;

%%
stimstem = sig_s.*randn(sdim,Nstim);

quad1 = ((stimstem(1,:)>0)&(stimstem(2,:)>0));
quad2 = ((stimstem(1,:)<=0)&(stimstem(2,:)>0));
quad3 = ((stimstem(1,:)<=0)&(stimstem(2,:)<=0));
quad4 = ((stimstem(1,:)>0)&(stimstem(2,:)<=0));

%% fig set up
figure
frows = 2;
fcols = 4;
fon = 14;
cmap = colormap(lines(4));
set(gcf,'Position',[75 60 1650 650])

%%
Wsub1 = [cos(pi/4),sin(pi/4)];
Wsub = [Wsub1;Wsub1];
[resps] = nlsubsResp_reLu_sub36(stimstem,sig_n,sig_m,Wsub,'relu');

subplot(frows,fcols,3)
hold on
plot(resps(quad1,1),resps(quad1,2),'o','MarkerSize',4,'Color',cmap(1,:))
plot(resps(quad3,1),resps(quad3,2),'o','MarkerSize',4,'Color',cmap(3,:))
plot(resps(quad2,1),resps(quad2,2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(resps(quad4,1),resps(quad4,2),'o','MarkerSize',4,'Color',cmap(4,:))
set(gca,'FontSize',fon)
xlabel('ON output response')
ylabel('OFF output response')
title('nonlin subs, nl out, uni weights')
grid on
axis square

subplot(frows,fcols,2)
hold on
plot(stimstem(1,quad3),stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(stimstem(1,quad4),stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(stimstem(1,quad2),stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(stimstem(1,quad1),stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
set(gca,'FontSize',fon)
xlabel('stim 1')
ylabel('stim 2')
title('stims')
grid on
axis square

%%
for j = 1:sws4
    Wsub_on = [cos((pi/4)+(j-1)*pi/12),sin((pi/4)+(j-1)*pi/12)];
    Wsub_off = [cos((pi/4)-(j-1)*pi/12),sin((pi/4)-(j-1)*pi/12)];
    
    Wsub = [Wsub_on;Wsub_off];
    [resps] = linsubResp_sub36(stimstem,sig_n,sig_m,Wsub,'relu');
    
    subplot(frows,fcols,j+fcols); hold on
    
    plot(resps(quad1,1),resps(quad1,2),'o','MarkerSize',4,'Color',cmap(1,:))
    plot(resps(quad3,1),resps(quad3,2),'o','MarkerSize',4,'Color',cmap(3,:))
    plot(resps(quad2,1),resps(quad2,2),'o','MarkerSize',4,'Color',cmap(2,:))
    plot(resps(quad4,1),resps(quad4,2),'o','MarkerSize',4,'Color',cmap(4,:))
    
    set(gca,'FontSize',fon)
    xlabel('ON output response')
    ylabel('OFF output response')
    grid on
    title('lin subs, nl out')
    axis square
end

%%
% load results saved from H_orthogonalizing_weights.m
cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/September/4')
load('H_binned_subweights_4Sep20.mat')
% cd('/Users/gabriellegutierrez/Documents/MATLAB/Retina/2020/May/9')

subplot(frows,fcols,3)
text(20,30,{['H = ' num2str(H_nl_nlout(1))]},'FontSize',fon)

for j = 1:sws4
    subplot(frows,fcols,j+fcols)
    text(20,30,{['H = ' num2str(H_lin_nlout(j))]},'FontSize',fon)
end

% linkaxes
% xlim([0 50])
% ylim([0 50])
