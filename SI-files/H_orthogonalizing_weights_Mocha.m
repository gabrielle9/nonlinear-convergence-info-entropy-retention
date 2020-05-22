clearvars

addpath(genpath('/home/ellag9/matlab_funcs'))

Nstim = 1e6;
sdim = 2;
rdim = 2;
sig_s = 10;
sig_n = 0;
sig_m = 0;

sws = 7; %number of angles

bw = sig_s*(1e-3); %sig_s*(1e-2); %*sqrt(sdim);
edgebound = ceil(5.5*sig_s*sqrt(sdim));
edges = -edgebound:bw:edgebound;

savestr = ['H_binned_subweights_8May20.mat'];

%%
H_lin_linout = zeros(1,sws);
H_nl_linout = zeros(1,sws);
H_lin_nlout = zeros(1,sws);
H_nl_nlout = zeros(1,sws);

sdH_lin_linout = zeros(1,sws);
sdH_nl_linout = zeros(1,sws);
sdH_lin_nlout = zeros(1,sws);
sdH_nl_nlout = zeros(1,sws);

Wsub_on = zeros(sws,rdim);
Wsub_off = zeros(sws,rdim);

for j = 1:sws
    Wsub_on(j,:) = [cos((pi/4)+(j-1)*pi/12),sin((pi/4)+(j-1)*pi/12)];
    Wsub_off(j,:) = [cos((pi/4)-(j-1)*pi/12),sin((pi/4)-(j-1)*pi/12)];
    
    Wsub = [Wsub_on(j,:);Wsub_off(j,:)];
    [H_lin_linout(j),sdH_lin_linout(j)] = binnedHr_subweights(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges,'lin',Wsub);
    [H_lin_nlout(j),sdH_lin_nlout(j)] = binnedHr_subweights(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges,'relu',Wsub);
    [H_nl_linout(j),sdH_nl_linout(j)] = binnedHr_subweights(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges,'lin',Wsub);
    [H_nl_nlout(j),sdH_nl_nlout(j)] = binnedHr_subweights(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges,'relu',Wsub);
end

save(savestr)

