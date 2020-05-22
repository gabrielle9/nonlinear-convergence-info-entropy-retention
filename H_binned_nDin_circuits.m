% binned H metrics for nDin circuits, scaled and unscaled subunit weights

clearvars
addpath(genpath('/home/ellag9/matlab_funcs'))

sig_s = 10;
sig_n = 0;
sig_m = 0;
sdims = 1:40; %1:40; %[1,2,5,10,25,50];

%% discrete numerics set up (binned)
Nstim = 1e6;
bw = sig_s*(1e-3); %*sqrt(sdim);
edgebound = ceil(5.5*sig_s);
edges = -edgebound:bw:edgebound;
edges_nl = edges + edgebound; %ensures that nonlinear outputs are not cut off at higher end
runs = 10; %6;

savestr = ['H_binned_nDin_sigs' num2str(sig_s) '_sqsc_cg_relu_out_29Mar20.mat'];

%% nDin, 1Dout scaled subunits
rdim = 1;

Hr_lin_nDin_1Dout_sqsc = zeros(size(sdims));
Hr_nl_nDin_1Dout_sqsc = zeros(size(sdims));
Hr_nlout_nDin_1Dout_sqsc = zeros(size(sdims));

sdHru_lin_nDin_1Dout_sqsc = zeros(size(sdims));
sdHru_nl_nDin_1Dout_sqsc = zeros(size(sdims));
sdHru_nlout_nDin_1Dout_sqsc = zeros(size(sdims));

for i = 1:length(sdims)
    sdim = sdims(i);
    
    [Hr_lin_nDin_1Dout_sqsc(i),sdHru_lin_nDin_1Dout_sqsc(i)] = binnedHr(sdim,rdim,'linear_sqsc',sig_s,sig_n,sig_m,Nstim,edges,runs);
    [Hr_nl_nDin_1Dout_sqsc(i),sdHru_nl_nDin_1Dout_sqsc(i)] = binnedHr(sdim,rdim,'relu_sqsc',sig_s,sig_n,sig_m,Nstim,edges_nl,runs);
    [Hr_nlout_nDin_1Dout_sqsc(i),sdHru_nlout_nDin_1Dout_sqsc(i)] = binnedHr(sdim,rdim,'relu_out_sqsc',sig_s,sig_n,sig_m,Nstim,edges,runs);
end

%%
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
poolobj = gcp('nocreate');
delete(poolobj);

%% nDin, 1Dout scaled subunits CG out
rdim = 1;

Hr_linsubs_cgout_nDin_1Dout_sqsc = zeros(size(sdims));
Hr_nlsubs_cgout_nDin_1Dout_sqsc = zeros(size(sdims));

sdHru_linsubs_cgout_nDin_1Dout_sqsc = zeros(size(sdims));
sdHru_nlsubs_cgout_nDin_1Dout_sqsc = zeros(size(sdims));

for i = 1:length(sdims)
    sdim = sdims(i);
    
    [Hr_linsubs_cgout_nDin_1Dout_sqsc(i),sdHru_linsubs_cgout_nDin_1Dout_sqsc(i)] = binnedHr(sdim,rdim,'linsubs_sqsc_cgout',sig_s,sig_n,sig_m,Nstim,edges,runs);
    [Hr_nlsubs_cgout_nDin_1Dout_sqsc(i),sdHru_nlsubs_cgout_nDin_1Dout_sqsc(i)] = binnedHr(sdim,rdim,'nlsubs_sqsc_cgout',sig_s,sig_n,sig_m,Nstim,edges_nl,runs);
end

%%
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
poolobj = gcp('nocreate');
delete(poolobj);

%% nDin, 2Dout scaled subunits
if (bw >= 1e-2)
    rdim = 2;
    
    Hr_lin_nDin_2Dout_sqsc = zeros(size(sdims));
    Hr_nl_nDin_2Dout_sqsc = zeros(size(sdims));
    Hr_nlout_nDin_2Dout_sqsc = zeros(size(sdims));
    
    sdHru_lin_nDin_2Dout_sqsc = zeros(size(sdims));
    sdHru_nl_nDin_2Dout_sqsc = zeros(size(sdims));
    sdHru_nlout_nDin_2Dout_sqsc = zeros(size(sdims));
        
    for i = 1:length(sdims)
        sdim = sdims(i);
        
        [Hr_lin_nDin_2Dout_sqsc(i),sdHru_lin_nDin_2Dout_sqsc(i)] = binnedHr(sdim,rdim,'linear_sqsc',sig_s,sig_n,sig_m,Nstim,edges,runs);
        [Hr_nlout_nDin_2Dout_sqsc(i),sdHru_nlout_nDin_2Dout_sqsc(i)] = binnedHr(sdim,rdim,'relu_out_sqsc',sig_s,sig_n,sig_m,Nstim,edges,runs);
        [Hr_nl_nDin_2Dout_sqsc(i),sdHru_nl_nDin_2Dout_sqsc(i)] = binnedHr(sdim,rdim,'relu_sqsc',sig_s,sig_n,sig_m,Nstim,edges_nl,runs);
    end
end

%%
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
poolobj = gcp('nocreate');
delete(poolobj);

%% nDin, 2Dout scaled subunits CG out
if (bw >= 1e-2)
    rdim = 2;

    Hr_linsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));
    Hr_nlsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));
    
    sdHru_linsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));
    sdHru_nlsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));
    
    for i = 1:length(sdims)
        sdim = sdims(i);
        
        [Hr_linsubs_cgout_nDin_2Dout_sqsc(i),sdHru_linsubs_cgout_nDin_2Dout_sqsc(i)] = binnedHr(sdim,rdim,'linsubs_sqsc_cgout',sig_s,sig_n,sig_m,Nstim,edges,runs);
        [Hr_nlsubs_cgout_nDin_2Dout_sqsc(i),sdHru_nlsubs_cgout_nDin_2Dout_sqsc(i)] = binnedHr(sdim,rdim,'nlsubs_sqsc_cgout',sig_s,sig_n,sig_m,Nstim,edges_nl,runs);
    end
end

%%
save(savestr)

