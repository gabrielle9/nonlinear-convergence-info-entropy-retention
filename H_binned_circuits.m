% binned H metrics for convergent, divergent circuit variations
% For my manuscript, I'll only use the binned H but I'm computing the
% bin-corrected h out of curiosity.

clearvars

sig_s = 10;
sig_n = 0;
sig_m = 0;

savestr = ['H_binned_sigs' num2str(sig_s) '_no_noise_17May19.mat'];

%% discrete numerics set up (binned)
Nstim = 1e6;
bw = sig_s*(1e-3); %*sqrt(sdim);
edgebound = 5.5*sig_s; %*sqrt(sdim);
edges = -edgebound:bw:edgebound;
bin_correct_1D = log2(bw);
bin_correct_2D = 2*log2(bw);

%% 1Din, 1Dout
sdim = 1;
rdim = 1;

[Hr_lin_1Din_1Dout,sdHru_lin_1Din_1Dout] = binnedHr(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges);
hr_lin_1Din_1Dout_bincorrect = Hr_lin_1Din_1Dout + bin_correct_1D;

[Hr_nl_1Din_1Dout,sdHru_nl_1Din_1Dout] = binnedHr(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges);
hr_nl_1Din_1Dout_bincorrect = Hr_nl_1Din_1Dout + bin_correct_1D;

theo_hr_1Din_1Dout = 0.5*log2(2.*pi.*exp(1).*(sdim*(sig_s^2) + sdim*(sig_n^2) + sig_m^2)); %assume independent noise

%% 1Din, 2Dout
sdim = 1;
rdim = 2;

[Hr_lin_1Din_2Dout,sdHru_lin_1Din_2Dout] = binnedHr(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges);
hr_lin_1Din_2Dout_bincorrect = Hr_lin_1Din_2Dout + bin_correct_2D;

[Hr_nl_1Din_2Dout,sdHru_nl_1Din_2Dout] = binnedHr(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges);
hr_nl_1Din_2Dout_bincorrect = Hr_nl_1Din_2Dout + bin_correct_2D;

%% 2Din, 1Dout
sdim = 2;
rdim = 1;

[Hr_lin_2Din_1Dout,sdHru_lin_2Din_1Dout] = binnedHr(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges);
hr_lin_2Din_1Dout_bincorrect = Hr_lin_2Din_1Dout + bin_correct_1D;

[Hr_nl_2Din_1Dout,sdHru_nl_2Din_1Dout] = binnedHr(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges);
hr_nl_2Din_1Dout_bincorrect = Hr_nl_2Din_1Dout + bin_correct_1D;

[Hr_nlout_2Din_1Dout,sdHru_nlout_2Din_1Dout] = binnedHr(sdim,rdim,'relu_out',sig_s,sig_n,sig_m,Nstim,edges);
hr_nlout_2Din_1Dout_bincorrect = Hr_nlout_2Din_1Dout + bin_correct_1D;

theo_hr_2Din_1Dout = 0.5*log2(2.*pi.*exp(1).*(sdim*(sig_s^2) + sdim*(sig_n^2) + sig_m^2)); %assume independent noise

%% 2D stim space
sdim = 2;

runs = 6;
tic
Hru = zeros(1,runs);
parfor rur = 1:runs
    stimstem = sig_s.*randn(Nstim,sdim);
    if sdim == 1
        [counts_resp,~] = histcounts(stimstem,edges);
    else %sdim==2
        [counts_resp,~,~] = histcounts2(stimstem(:,1),stimstem(:,2),edges,edges);
    end
    Pcounts = counts_resp(:)./sum(counts_resp(:));
    Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
end
toc

H_stim_2D = mean(Hru);
sdHru_stim_2D = std(Hru);

tic
Hru = zeros(1,runs);
parfor rur = 1:runs
    stimstem = sig_s.*randn(Nstim,sdim);
    stimstem(stimstem<0) = 0;
    if sdim == 1
        [counts_resp,~] = histcounts(stimstem,edges);
    else %sdim==2
        [counts_resp,~,~] = histcounts2(stimstem(:,1),stimstem(:,2),edges,edges);
    end
    Pcounts = counts_resp(:)./sum(counts_resp(:));
    Hru(rur) = -nansum(Pcounts.*log2(Pcounts));
end
toc

H_nlsubs_2D = mean(Hru);
sdHru_nlsubs_2D = std(Hru);

%% 2Din, 2Dout
sdim = 2;
rdim = 2;

[Hr_lin_2Din_2Dout,sdHru_lin_2Din_2Dout] = binnedHr(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges);
hr_lin_2Din_2Dout_bincorrect = Hr_lin_2Din_2Dout + bin_correct_2D;

[Hr_nl_2Din_2Dout,sdHru_nl_2Din_2Dout] = binnedHr(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges);
hr_nl_2Din_2Dout_bincorrect = Hr_nl_2Din_2Dout + bin_correct_2D;

[Hr_nlout_2Din_2Dout,sdHru_nlout_2Din_2Dout] = binnedHr(sdim,rdim,'relu_out',sig_s,sig_n,sig_m,Nstim,edges);
hr_nlout_2Din_2Dout_bincorrect = Hr_nlout_2Din_2Dout + bin_correct_2D;

%% nDin, 1Dout
rdim = 1;
sdims = [1,2,5,10,25,50];

Hr_lin_nDin_1Dout = zeros(size(sdims));
Hr_nl_nDin_1Dout = zeros(size(sdims));
Hr_nlout_nDin_1Dout = zeros(size(sdims));

sdHru_lin_nDin_1Dout = zeros(size(sdims));
sdHru_nl_nDin_1Dout = zeros(size(sdims));
sdHru_nlout_nDin_1Dout = zeros(size(sdims));

hr_lin_nDin_1Dout_bincorrect = zeros(size(sdims));
hr_nl_nDin_1Dout_bincorrect = zeros(size(sdims));
hr_nlout_nDin_1Dout_bincorrect = zeros(size(sdims));

for i = 1:length(sdims)
    sdim = sdims(i);
    edgebound = ceil(5.5*sig_s*sqrt(sdim));
    edges = -edgebound:bw:edgebound;
    
    [Hr_lin_nDin_1Dout(i),sdHru_lin_nDin_1Dout(i)] = binnedHr(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges);
    hr_lin_nDin_1Dout_bincorrect(i) = Hr_lin_nDin_1Dout(i) + bin_correct_1D;
    
    [Hr_nl_nDin_1Dout(i),sdHru_nl_nDin_1Dout(i)] = binnedHr(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges);
    hr_nl_nDin_1Dout_bincorrect(i) = Hr_nl_nDin_1Dout(i) + bin_correct_1D;

    [Hr_nlout_nDin_1Dout(i),sdHru_nlout_nDin_1Dout(i)] = binnedHr(sdim,rdim,'relu_out',sig_s,sig_n,sig_m,Nstim,edges);
    hr_nlout_nDin_1Dout_bincorrect(i) = Hr_nlout_nDin_1Dout(i) + bin_correct_1D;
end

theo_hr_nDin_1Dout = 0.5.*log2(2.*pi.*exp(1).*(sdims.*(sig_s.^2) + sdims.*(sig_n.^2) + sig_m.^2));

%%
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
poolobj = gcp('nocreate');
delete(poolobj);

%% nDin, 2Dout
if (bw > 1e-2)
    rdim = 2;
    sdims = [1,2,5,10,25,50];
    
    Hr_lin_nDin_2Dout = zeros(size(sdims));
    Hr_nl_nDin_2Dout = zeros(size(sdims));
    
    sdHru_lin_nDin_2Dout = zeros(size(sdims));
    sdHru_nl_nDin_2Dout = zeros(size(sdims));
    
    hr_lin_nDin_2Dout_bincorrect = zeros(size(sdims));
    hr_nl_nDin_2Dout_bincorrect = zeros(size(sdims));
    
    for i = 1:length(sdims)
        sdim = sdims(i);
        edgebound = ceil(5.5*sig_s*sqrt(sdim));
        edges = -edgebound:bw:edgebound;
        
        [Hr_lin_nDin_2Dout(i),sdHru_lin_nDin_2Dout(i)] = binnedHr(sdim,rdim,'linear',sig_s,sig_n,sig_m,Nstim,edges);
        hr_lin_nDin_2Dout_bincorrect(i) = Hr_lin_nDin_2Dout(i) + bin_correct_2D;
        
        [Hr_nl_nDin_2Dout(i),sdHru_nl_nDin_2Dout(i)] = binnedHr(sdim,rdim,'relu',sig_s,sig_n,sig_m,Nstim,edges);
        hr_nl_nDin_2Dout_bincorrect(i) = Hr_nl_nDin_2Dout(i) + bin_correct_2D;
    end
end

%%
save(savestr)



