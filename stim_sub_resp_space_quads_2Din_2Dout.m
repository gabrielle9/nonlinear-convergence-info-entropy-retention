clearvars

sig_s = 10;
sig_n = 0;
sig_m = 0;

%% Stim set up
Nstim = 1e4;
sdim = 2;
stimstem = sig_s.*randn(sdim,Nstim);

quad1 = ((stimstem(1,:)>0)&(stimstem(2,:)>0));
quad2 = ((stimstem(1,:)<=0)&(stimstem(2,:)>0));
quad3 = ((stimstem(1,:)<=0)&(stimstem(2,:)<=0));
quad4 = ((stimstem(1,:)>0)&(stimstem(2,:)<=0));

%% Subunits explanation: 2D input, 2D output
rdim = 2;

[nl_resps] = nlsubsResp_reLu_subn(stimstem,sig_n,sig_m);

[lin_resps] = linsubResp_subn(stimstem,sig_n,sig_m);

nl_resps0 = lin_resps;
nl_resps0(lin_resps<0) = 0;

nl_subs_on = stimstem;
nl_subs_on(nl_subs_on<0) = 0;

nl_subs_off = -stimstem;
nl_subs_off(nl_subs_off<0) = 0;

%% Figure set up
frows = 2;
fcols = 3;
fon = 16;
xl1 = 45;
xl2 = 60;

% for binned isolines
bhw = 5; % hist bin spacing
xend = 60; % max for binning
s1 = -xend:xend:xend; % vector for isolines
z = -xend:bhw:xend; % length of this is number of bins + 1

%% linear circuit
fig1 = figure;
set(gcf,'Position',[15 390 1260 685])

cmap = colormap(lines(4));

xl = [-xl1 xl1];
subplot(frows,fcols,1)
hold on
plot(stimstem(1,quad3),stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(stimstem(1,quad4),stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(stimstem(1,quad2),stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(stimstem(1,quad1),stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('stim 1')
ylabel('stim 2')
grid on
title('stimulus space')
axis square
% text(1,4,{['H = ' num2str(Hr_stim_2D)]},'FontSize',fon)
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

subplot(frows,fcols,2)
hold on
plot(stimstem(1,quad3),stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(stimstem(1,quad4),stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(stimstem(1,quad2),stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(stimstem(1,quad1),stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('linear ON subunit 1')
ylabel('linear ON subunit 2')
grid on
title('linear ON subunit space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

% % plot binned isolines
% subplot(frows,fcols,1)
% for i = 1:length(z)
%     s2 = z(i) - s1;
%     plot(s1,s2,'k')
% end

subplot(frows,fcols,3)
hold on
plot(-stimstem(1,quad1),-stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
plot(-stimstem(1,quad2),-stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(-stimstem(1,quad4),-stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(-stimstem(1,quad3),-stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('linear OFF subunit 1')
ylabel('linear OFF subunit 2')
grid on
title('linear OFF subunit space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

xl = [-xl2 xl2];
subplot(frows,fcols,4)
hold on
q1b = plot(lin_resps(quad1,1),lin_resps(quad1,2),'o','MarkerSize',8,'Color',cmap(1,:));
q3b = plot(lin_resps(quad3,1),lin_resps(quad3,2),'o','MarkerSize',8,'Color',cmap(3,:));
q4b = plot(lin_resps(quad4,1),lin_resps(quad4,2),'o','MarkerSize',6,'Color',cmap(4,:));
q2b = plot(lin_resps(quad2,1),lin_resps(quad2,2),'o','MarkerSize',4,'Color',cmap(2,:));
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('ON response')
ylabel('OFF response')
grid on
title('linear circuit')
axis square
% text(0.1,4.5,{['H = ' num2str(Hr_lin_2Din_2Dout)]},'FontSize',fon)
set(gca,'XTick',[-xl2:xl2:xl2])
set(gca,'YTick',[-xl2:xl2:xl2])
% legend([q1b q2b q3b q4b],{'Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4'},'Location','best')

% plot quadrant-coded response histogram for linear circuit
% xl = [-6 6];
subplot(frows,fcols,5)
h1 = histogram(lin_resps(:,1),[0:bhw:xend]);
hold on
h2 = histogram(lin_resps(:,1),[-xend:bhw:0]);
h3 = histogram(lin_resps(quad2|quad4,1),[-xend:bhw:xend]);
h4 = histogram(lin_resps(quad4,1),[-xend:bhw:xend]);
h0 = histogram(lin_resps(:,1),[-xend:bhw:xend]);
h1.FaceAlpha = 1;
h2.FaceAlpha = 1;
h3.FaceAlpha = 1;
h4.FaceAlpha = 1;
h1.FaceColor = cmap(1,:);
h2.FaceColor = cmap(3,:);
h3.FaceColor = cmap(2,:);
h4.FaceColor = cmap(4,:);
h0.FaceAlpha = 0; % outline only
h0.LineWidth = 2;
set(gca,'FontSize',fon)
xlabel('On output responses')
axis square
title('linear On responses with 2D input')

%%
% plot quadrant-coded response histogram for linear circuit
% xl = [-6 6];
subplot(frows,fcols,6)
h1 = histogram(lin_resps(:,2),[-xend:bhw:0]);
hold on
h2 = histogram(lin_resps(:,2),[0:bhw:xend]);
h3 = histogram(lin_resps(quad2|quad4,2),[-xend:bhw:xend]);
h4 = histogram(lin_resps(quad4,2),[-xend:bhw:xend]);
h0 = histogram(lin_resps(:,2),[-xend:bhw:xend]);
h1.FaceAlpha = 1;
h2.FaceAlpha = 1;
h3.FaceAlpha = 1;
h4.FaceAlpha = 1;
h1.FaceColor = cmap(1,:);
h2.FaceColor = cmap(3,:);
h3.FaceColor = cmap(2,:);
h4.FaceColor = cmap(4,:);
h0.FaceAlpha = 0; % outline only
h0.LineWidth = 2;
set(gca,'FontSize',fon)
xlabel('Off output responses')
axis square
title('linear Off responses with 2D input')


%% nonlinear subunits circuit
fig2 = figure;
set(gcf,'Position',[15 390 1260 685])
cmap = colormap(lines(4));

xl = [-xl1 xl1];
subplot(frows,fcols,3)
hold on
plot(stimstem(1,quad3),stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(stimstem(1,quad4),stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(stimstem(1,quad2),stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(stimstem(1,quad1),stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('stim 1')
ylabel('stim 2')
grid on
title('stimulus space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

xl = [0 xl1];
subplot(frows,fcols,1)
hold on
plot(nl_subs_on(1,quad1),nl_subs_on(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
plot(nl_subs_on(1,quad4),nl_subs_on(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(nl_subs_on(1,quad2),nl_subs_on(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(nl_subs_on(1,quad3),nl_subs_on(2,quad3),'o','MarkerSize',6,'Color',cmap(3,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('nonlinear ON subunit 1')
ylabel('nonlinear ON subunit 2')
grid on
title('nonlinear ON subunit space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

subplot(frows,fcols,2)
hold on
plot(nl_subs_off(1,quad3),nl_subs_off(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(nl_subs_off(1,quad4),nl_subs_off(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(nl_subs_off(1,quad2),nl_subs_off(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(nl_subs_off(1,quad1),nl_subs_off(2,quad1),'o','MarkerSize',6,'Color',cmap(1,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('nonlinear OFF subunit 1')
ylabel('nonlinear OFF subunit 2')
grid on
title('nonlinear OFF subunit space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

xl = [0 xl2];
subplot(frows,fcols,4)
hold on
plot(nl_resps(quad1,1),nl_resps(quad1,2),'o','MarkerSize',8,'Color',cmap(1,:))
plot(nl_resps(quad3,1),nl_resps(quad3,2),'o','MarkerSize',8,'Color',cmap(3,:))
plot(nl_resps(quad4,1),nl_resps(quad4,2),'o','MarkerSize',6,'Color',cmap(4,:))
plot(nl_resps(quad2,1),nl_resps(quad2,2),'o','MarkerSize',4,'Color',cmap(2,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('ON response')
ylabel('OFF response')
grid on
title('nonlinear subunits circuit')
axis square
% text(3,5.5,{['H = ' num2str(Hr_nl_2Din_2Dout)]},'FontSize',fon)
set(gca,'XTick',[-xl2:xl2:xl2])
set(gca,'YTick',[-xl2:xl2:xl2])

%% nonlinear output circuit
fig3 = figure;
set(gcf,'Position',[15 390 1260 685])
cmap = colormap(lines(4));

xl = [-xl1 xl1];
subplot(frows,fcols,3)
hold on
plot(stimstem(1,quad3),stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(stimstem(1,quad4),stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(stimstem(1,quad2),stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(stimstem(1,quad1),stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('stim 1')
ylabel('stim 2')
grid on
title('stimulus space')
axis square
% text(1,4,{['H = ' num2str(Hr_stim_2D)]},'FontSize',fon)
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

subplot(frows,fcols,1)
hold on
plot(stimstem(1,quad3),stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
plot(stimstem(1,quad4),stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(stimstem(1,quad2),stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(stimstem(1,quad1),stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('linear ON subunit 1')
ylabel('linear ON subunit 2')
grid on
title('linear ON subunit space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

subplot(frows,fcols,2)
hold on
plot(-stimstem(1,quad1),-stimstem(2,quad1),'o','MarkerSize',4,'Color',cmap(1,:))
plot(-stimstem(1,quad2),-stimstem(2,quad2),'o','MarkerSize',4,'Color',cmap(2,:))
plot(-stimstem(1,quad4),-stimstem(2,quad4),'o','MarkerSize',4,'Color',cmap(4,:))
plot(-stimstem(1,quad3),-stimstem(2,quad3),'o','MarkerSize',4,'Color',cmap(3,:))
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('linear OFF subunit 1')
ylabel('linear OFF subunit 2')
grid on
title('linear OFF subunit space')
axis square
set(gca,'XTick',[-xl1:xl1:xl1])
set(gca,'YTick',[-xl1:xl1:xl1])

xl = [0 xl2];
subplot(frows,fcols,4)
hold on
q1c = plot(nl_resps0(quad1,1),nl_resps0(quad1,2),'o','MarkerSize',8,'Color',cmap(1,:));
q3c = plot(nl_resps0(quad3,1),nl_resps0(quad3,2),'o','MarkerSize',8,'Color',cmap(3,:));
q4c = plot(nl_resps0(quad4,1),nl_resps0(quad4,2),'o','MarkerSize',6,'Color',cmap(4,:));
q2c = plot(nl_resps0(quad2,1),nl_resps0(quad2,2),'o','MarkerSize',4,'Color',cmap(2,:));
xlim(xl)
ylim(xl)
set(gca,'FontSize',fon)
xlabel('ON response')
ylabel('OFF response')
grid on
title('nonlinear output circuit')
axis square
% text(3,5.5,{['H = ' num2str(Hr_nl_out_2Din_2Dout)]},'FontSize',fon)
set(gca,'XTick',[-xl2:xl2:xl2])
set(gca,'YTick',[-xl2:xl2:xl2])
legend([q1c q2c q3c q4c],{'Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4'},'Location','east')


