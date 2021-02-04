% binned H metrics for nDin circuits, scaled and unscaled subunit weights

clearvars
addpath(genpath('/home/ellag9/matlab_funcs'))

sig_s = 10;
sig_n = 0;
sig_m = 0;
sdims = 1:25; %1:40; %[1,2,5,10,25,50];

linthrs = [-inf,-inf];
reluthrs = [0,0];

linout = 'linear';
reluout = 'relu';
cgout = 'cg';

%% discrete numerics set up (binned)
Nstim = 1e6; %no need for tailored Nstim since no noise
bw = 0.25; %sig_s*(1e-3); %*sqrt(sdim);
runs = 10; %6;

savestr = ['H_binned_nDin_sigs' num2str(sig_s) '_sqsc_cg_relu_out_4Sep20.mat'];

%% nDin, 1Dout scaled subunits
rdim = 1;

Hr_linsubs_linout_nDin_1Dout_sqsc = zeros(size(sdims));
Hr_linsubs_nlout_nDin_1Dout_sqsc = zeros(size(sdims));
Hr_nlsubs_nlout_nDin_1Dout_sqsc = zeros(size(sdims));

sdHru_linsubs_linout_nDin_1Dout_sqsc = zeros(size(sdims));
sdHru_linsubs_nlout_nDin_1Dout_sqsc = zeros(size(sdims));
sdHru_nlsubs_nlout_nDin_1Dout_sqsc = zeros(size(sdims));

for i = 1:length(sdims)
    sdim = sdims(i);
    
    [Hr_linsubs_linout_nDin_1Dout_sqsc(i),sdHru_linsubs_linout_nDin_1Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,linout,linthrs);
    [Hr_linsubs_nlout_nDin_1Dout_sqsc(i),sdHru_linsubs_nlout_nDin_1Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
    [Hr_nlsubs_nlout_nDin_1Dout_sqsc(i),sdHru_nlsubs_nlout_nDin_1Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
end

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
    
    [Hr_linsubs_cgout_nDin_1Dout_sqsc(i),sdHru_linsubs_cgout_nDin_1Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
    [Hr_nlsubs_cgout_nDin_1Dout_sqsc(i),sdHru_nlsubs_cgout_nDin_1Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
end

save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
poolobj = gcp('nocreate');
delete(poolobj);

%% nDin, 2Dout scaled subunits
rdim = 2;

Hr_linsubs_linout_nDin_2Dout_sqsc = zeros(size(sdims));
Hr_linsubs_nlout_nDin_2Dout_sqsc = zeros(size(sdims));
Hr_nlsubs_nlout_nDin_2Dout_sqsc = zeros(size(sdims));

sdHru_linsubs_linout_nDin_2Dout_sqsc = zeros(size(sdims));
sdHru_linsubs_nlout_nDin_2Dout_sqsc = zeros(size(sdims));
sdHru_nlsubs_nlout_nDin_2Dout_sqsc = zeros(size(sdims));

for i = 1:length(sdims)
    sdim = sdims(i);
    
    [Hr_linsubs_linout_nDin_2Dout_sqsc(i),sdHru_linsubs_linout_nDin_2Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,linout,linthrs);
    [Hr_linsubs_nlout_nDin_2Dout_sqsc(i),sdHru_linsubs_nlout_nDin_2Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
    [Hr_nlsubs_nlout_nDin_2Dout_sqsc(i),sdHru_nlsubs_nlout_nDin_2Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
end

save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
poolobj = gcp('nocreate');
delete(poolobj);

%% nDin, 2Dout scaled subunits CG out
rdim = 2;

Hr_linsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));
Hr_nlsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));

sdHru_linsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));
sdHru_nlsubs_cgout_nDin_2Dout_sqsc = zeros(size(sdims));

for i = 1:length(sdims)
    sdim = sdims(i);
    
    [Hr_linsubs_cgout_nDin_2Dout_sqsc(i),sdHru_linsubs_cgout_nDin_2Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
    [Hr_nlsubs_cgout_nDin_2Dout_sqsc(i),sdHru_nlsubs_cgout_nDin_2Dout_sqsc(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
end

save(savestr)

