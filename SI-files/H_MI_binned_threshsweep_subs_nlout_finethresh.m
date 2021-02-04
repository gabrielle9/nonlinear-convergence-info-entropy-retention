clearvars

load('H_binned_threshsweep_subs_nlout_finethresh_7Sep20.mat')

savestr = ['H_MI_binned_threshsweep_subs_nlout_finethresh_10Sep20.mat'];

sdim = 36;
sig_m = high_sig; %high noise = 10

%% linsubs linout for normalizing
sig_x = sqrt(sig_s*sig_s + sig_m*sig_m);
[Nstim] = compute_Nsamp_for_sig_H_error(sig_s); % will return at least 1e6
[Hr_linsubs_linout_highnoise_36Din,sdHr_linsubs_linout_highnoise_36Din] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,'linear',linthrs);

% no need to compute Hn because it will be the same as for 2Din
save(savestr)

%% thresh sweep initiate nlout
Hr_threshsweep_subs_nlout_highnoise_36Din = zeros(length(threshs),1);
sdHr_threshsweep_subs_nlout_highnoise_36Din = zeros(length(threshs),1);

Hn_threshsweep_subs_nlout_highnoise_36Din = zeros(length(threshs),1);
sdHn_threshsweep_subs_nlout_highnoise_36Din = zeros(length(threshs),1);

%% sweep subunit thresholds, nonlinear outputs
teststim = sig_s.*randn(sdim,1e6);
[testresps] = subunit_circuit_outnoise_pre_nl_cg_fix(teststim,sig_n,0,[-inf,-inf],'relu',reluthrs);
sig_x = std(testresps(:,1));
Ncap = compute_Nsamp_for_sig_Hn_error(sig_x);

parfor i = 1:length(threshs)
    teststim = sig_s.*randn(sdim,1e6);
    [testresps] = subunit_circuit_outnoise_pre_nl_cg_fix(teststim,sig_n,sig_m,[threshs(i),threshs(i)],'relu',reluthrs);
    sig_x = std(testresps(:,1));
    [Nstim] = compute_Nsamp_for_sig_H_error(sig_x); % will return at least 1e6
    [Hr_threshsweep_subs_nlout_highnoise_36Din(i),sdHr_threshsweep_subs_nlout_highnoise_36Din(i)] = binnedHr_threshs(sdim,rdim,[threshs(i),threshs(i)],sig_s,sig_n,sig_m,Nstim,bw,runs,'relu',reluthrs);
    
    [Nreps] = compute_Nsamp_for_sig_Hn_error(sig_x); %for noise specifically - no 1e6 floor
    [Hn_threshsweep_subs_nlout_highnoise_36Din(i),sdHn_threshsweep_subs_nlout_highnoise_36Din(i)] = binnedHn_cond_parti(sdim,rdim,[threshs(i),threshs(i)],sig_s,sig_n,sig_m,Nreps,bw,Ncap,'relu',reluthrs);

end

clear teststim testresps
save(savestr)
