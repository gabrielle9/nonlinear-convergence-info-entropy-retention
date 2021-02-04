% binned H metrics for nDin circuits, scaled and unscaled subunit weights
% this time, histcount boundaries are computed for each distribution in
% binnedHr and binnedHn
% outnoise comes before the output nonlinearity

clearvars
addpath(genpath('/home/ellag9/matlab_funcs'))

%%
sig_s = 10;
sig_n = 0;
sig_m = 1; %5;
sdims = 1:15; %1:25; %1:40; %[1,2,5,10,25,50];

savestr = ['Hr_Hn_binned_nDin_sigm' num2str(sig_m) '_sqsc_outnoise_pre_cg_relu_out_Hnpart_9Sep20.mat'];

%% discrete numerics set up (binned)
bw = 0.25; %1e-2; %sig_s*(1e-3); %always
runs = 10; %6;

linthrs = [-inf,-inf];
reluthrs = [0,0];

linout = 'linear';
reluout = 'relu';
cgout = 'cg';

%% noise entropy - nDin, 1Dout scaled subunits, nlout
rdim = 1;
Nreps = 1e5; % by default for 1D noise
Ncap = 1e5; % by default for 1D noise

% Hn_linsubs_nlout_nDin_1Dout = zeros(size(sdims));
% sdHnu_linsubs_nlout_nDin_1Dout = zeros(size(sdims));
[Hn_linsubs_nlout_nDin_1Dout,sdHnu_linsubs_nlout_nDin_1Dout] = binnedHn_cond_parti(1,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,reluout,reluthrs); %will be the same for all sdim anyway

Hn_nlsubs_nlout_nDin_1Dout = zeros(size(sdims));
sdHnu_nlsubs_nlout_nDin_1Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
%     [Hn_linsubs_nlout_nDin_1Dout(i),sdHnu_linsubs_nlout_nDin_1Dout(i)] = binnedHn_cond_parti(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,reluout,reluthrs);
    [Hn_nlsubs_nlout_nDin_1Dout(i),sdHnu_nlsubs_nlout_nDin_1Dout(i)] = binnedHn_cond_parti(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,reluout,reluthrs);
end

save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hn 1D nlout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% noise entropy - nDin, 1Dout scaled subunits, cgout
% in theory, should also not depend on sdim for linsubs
rdim = 1;
Nreps = 1e5; %by default for 1D noise
Ncap = 1e5; %by default for 1D noise

% Hn_linsubs_cgout_nDin_1Dout = zeros(size(sdims));
% sdHnu_linsubs_cgout_nDin_1Dout = zeros(size(sdims));
[Hn_linsubs_cgout_nDin_1Dout,sdHnu_linsubs_cgout_nDin_1Dout] = binnedHn_cond_parti(1,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,cgout,linthrs);

Hn_nlsubs_cgout_nDin_1Dout = zeros(size(sdims));
sdHnu_nlsubs_cgout_nDin_1Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    [Hn_nlsubs_cgout_nDin_1Dout(i),sdHnu_nlsubs_cgout_nDin_1Dout(i)] = binnedHn_cond_parti(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,cgout,linthrs);
end

save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hn 1D cgout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% noise entropy - nDin, 2Dout scaled subunits, linsubs, nlout
% in theory, should also not depend on sdim for linsubs
rdim = 2;
% safest thing is to find Nreps needed for full noise distribution
[Nreps] = compute_Nsamp_for_sig_Hn_error(sig_m); %for noise specifically - no 1e6 floor
Ncap = compute_Nsamp_for_sig_Hn_error(sig_s);

% Hn_linsubs_nlout_nDin_2Dout = zeros(size(sdims));
% sdHnu_linsubs_nlout_nDin_2Dout = zeros(size(sdims));
[Hn_linsubs_nlout_nDin_2Dout,sdHnu_linsubs_nlout_nDin_2Dout] = binnedHn_cond_parti(1,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,reluout,reluthrs); %will be the same for all sdim anyway

% for i = 1:length(sdims)
%     sdim = sdims(i);
%     [Hn_linsubs_nlout_nDin_2Dout(i),sdHnu_linsubs_nlout_nDin_2Dout(i)] = binnedHn_cond_parti(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,reluout,reluthrs);
% end

clear testresps teststim
save(savestr)

% %% shuts down the parallel pool so that it can start afresh for the next block
% poolobj = gcp('nocreate');
% delete(poolobj);

%% noise entropy - nDin, 2Dout scaled subunits, nlsubs, nlout
rdim = 2;

[Nreps] = compute_Nsamp_for_sig_Hn_error(sig_m); %for noise specifically - no 1e6 floor
% Ncap does not change with sdim because it's before noise
teststim = sig_s.*randn(sdims(end),1e6);
[testresps] = subunit_circuit_outnoise_pre_nl_cg_fix(teststim,sig_n,0,reluthrs,linout,linthrs); %resp distr before noise and before nlout
sig_x = std(testresps(:,1));
Ncap = compute_Nsamp_for_sig_Hn_error(sig_x);

Hn_nlsubs_nlout_nDin_2Dout = zeros(size(sdims));
sdHnu_nlsubs_nlout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    [Hn_nlsubs_nlout_nDin_2Dout(i),sdHnu_nlsubs_nlout_nDin_2Dout(i)] = binnedHn_cond_parti(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,reluout,reluthrs);
end

clear testresps teststim
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hn 2D nlout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% noise entropy - nDin, 2Dout scaled subunits, linsubs, cgout
% in theory, should also not depend on sdim for linsubs
rdim = 2;
[Nreps] = compute_Nsamp_for_sig_Hn_error(sig_m);
Ncap = compute_Nsamp_for_sig_Hn_error(sig_s);

% Hn_linsubs_cgout_nDin_2Dout = zeros(size(sdims));
% sdHnu_linsubs_cgout_nDin_2Dout = zeros(size(sdims));
[Hn_linsubs_cgout_nDin_2Dout,sdHnu_linsubs_cgout_nDin_2Dout] = binnedHn_cond_parti(1,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,cgout,linthrs); %will be the same for all sdim anyway

% for i = 1:length(sdims)
%     sdim = sdims(i);
%     [Hn_linsubs_cgout_nDin_2Dout(i),sdHnu_linsubs_cgout_nDin_2Dout(i)] = binnedHn_cond_parti(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,cgout,linthrs);
% end

clear testresps teststim
save(savestr)

% %% shuts down the parallel pool so that it can start afresh for the next block
% poolobj = gcp('nocreate');
% delete(poolobj);

%% noise entropy - nDin, 2Dout scaled subunits, nlsubs, cgout
rdim = 2;
[Nreps] = compute_Nsamp_for_sig_Hn_error(sig_m);
teststim = sig_s.*randn(sdims(end),1e6);
[testresps] = subunit_circuit_outnoise_pre_nl_cg_fix(teststim,sig_n,0,reluthrs,linout,linthrs); %resp distr before noise
sig_x = std(testresps(:,1));
Ncap = compute_Nsamp_for_sig_Hn_error(sig_x);

Hn_nlsubs_cgout_nDin_2Dout = zeros(size(sdims));
sdHnu_nlsubs_cgout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    [Hn_nlsubs_cgout_nDin_2Dout(i),sdHnu_nlsubs_cgout_nDin_2Dout(i)] = binnedHn_cond_parti(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nreps,bw,Ncap,cgout,linthrs);
end

clear testresps teststim
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hn 2D cgout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% entropy nDin, 1Dout scaled subunits
rdim = 1;
Nstim = 1e6; % no test to determine because 1e6 is fixed for 1D

Hr_linsubs_linout_nDin_1Dout = zeros(size(sdims)); % totally linear
sdHru_linsubs_linout_nDin_1Dout = zeros(size(sdims));

Hr_linsubs_nlout_nDin_1Dout = zeros(size(sdims));
sdHru_linsubs_nlout_nDin_1Dout = zeros(size(sdims));

Hr_nlsubs_nlout_nDin_1Dout = zeros(size(sdims));
sdHru_nlsubs_nlout_nDin_1Dout = zeros(size(sdims));

Hr_linsubs_cgout_nDin_1Dout = zeros(size(sdims));
sdHru_linsubs_cgout_nDin_1Dout = zeros(size(sdims));

Hr_nlsubs_cgout_nDin_1Dout = zeros(size(sdims));
sdHru_nlsubs_cgout_nDin_1Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);    
    [Hr_linsubs_linout_nDin_1Dout(i),sdHru_linsubs_linout_nDin_1Dout(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,linout,linthrs);
    [Hr_linsubs_nlout_nDin_1Dout(i),sdHru_linsubs_nlout_nDin_1Dout(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
    [Hr_nlsubs_nlout_nDin_1Dout(i),sdHru_nlsubs_nlout_nDin_1Dout(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
    [Hr_linsubs_cgout_nDin_1Dout(i),sdHru_linsubs_cgout_nDin_1Dout(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
    [Hr_nlsubs_cgout_nDin_1Dout(i),sdHru_nlsubs_cgout_nDin_1Dout(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
end

save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hr 1D complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% binned noise entropy for linear/linear circuits
rdim = 1;
Nstim = 1e6;
[Hn_linout_1Dout,sdHnu_linout_1Dout] = binnedH(rdim,sig_m,Nstim,bw,runs);

rdim = 2;
% Nstim = 1e6;
[Nstim] = compute_Nsamp_for_sig_H_error(sig_m); % will return at least 1e6
[Hn_linout_2Dout,sdHnu_linout_2Dout] = binnedH(rdim,sig_m,Nstim,bw,runs);

save(savestr)

% %% shuts down the parallel pool so that it can start afresh for the next block
% poolobj = gcp('nocreate');
% delete(poolobj);

%% entropy, nDin, 2Dout scaled subunits, linsubs, linout
% in theory, doesn't depend on sdim, but I'll run the range since it's
% faster than noise entropy
rdim = 2;

sig_x = sqrt(sig_s*sig_s + sig_m*sig_m);
[Nstim] = compute_Nsamp_for_sig_H_error(sig_x); % will return at least 1e6

Hr_linsubs_linout_nDin_2Dout = zeros(size(sdims));
sdHru_linsubs_linout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);    
    [Hr_linsubs_linout_nDin_2Dout(i),sdHru_linsubs_linout_nDin_2Dout(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,linout,linthrs);
end

save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('H 2D linout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% entropy, nDin, 2Dout scaled subunits, linsubs, nlout
rdim = 2;

sig_x = sqrt(sig_s*sig_s + sig_m*sig_m);
teststim = sig_x.*randn(1,1e6);
teststim(teststim<0) = 0;
sig_x = std(teststim);
[Nstim] = compute_Nsamp_for_sig_H_error(sig_x); % will return at least 1e6

Hr_linsubs_nlout_nDin_2Dout = zeros(size(sdims));
sdHru_linsubs_nlout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    [Hr_linsubs_nlout_nDin_2Dout(i),sdHru_linsubs_nlout_nDin_2Dout(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
end

clear testresps teststim
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hr 2D linsubs nlout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% entropy, nDin, 2Dout scaled subunits, nlsubs, nlout
rdim = 2;

Hr_nlsubs_nlout_nDin_2Dout = zeros(size(sdims));
sdHru_nlsubs_nlout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    teststim = sig_s.*randn(sdim,1e6);
    [testresps] = subunit_circuit_outnoise_pre_nl_cg_fix(teststim,sig_n,sig_m,reluthrs,reluout,reluthrs);
    sig_x = std(testresps(:,1));
    [Nstim] = compute_Nsamp_for_sig_H_error(sig_x); % will return at least 1e6
    
    [Hr_nlsubs_nlout_nDin_2Dout(i),sdHru_nlsubs_nlout_nDin_2Dout(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,reluout,reluthrs);
end

clear testresps teststim
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hr 2D nlsubs nlout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% entropy nDin, 2Dout scaled subunits, linsubs, cg out
rdim = 2;
sig_x = sqrt(sig_s*sig_s + sig_m*sig_m);
[Nstim] = compute_Nsamp_for_sig_H_error(sig_x); % will return at least 1e6

Hr_linsubs_cgout_nDin_2Dout = zeros(size(sdims));
sdHru_linsubs_cgout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    [Hr_linsubs_cgout_nDin_2Dout(i),sdHru_linsubs_cgout_nDin_2Dout(i)] = binnedHr_threshs(sdim,rdim,linthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
end

clear testresps teststim
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hr 2D linsubs cgout complete')
poolobj = gcp('nocreate');
delete(poolobj);

%% entropy nDin, 2Dout scaled subunits, nlsubs, cg out
rdim = 2;

Hr_nlsubs_cgout_nDin_2Dout = zeros(size(sdims));
sdHru_nlsubs_cgout_nDin_2Dout = zeros(size(sdims));

parfor i = 1:length(sdims)
    sdim = sdims(i);
    teststim = sig_s.*randn(sdim,1e6);
    [testresps] = subunit_circuit_outnoise_pre_nl_cg_fix(teststim,sig_n,sig_m,reluthrs,linout,linthrs); %linout to get reasonable std
    sig_x = std(testresps(:,1));
    [Nstim] = compute_Nsamp_for_sig_H_error(sig_x); % will return at least 1e6
    [Hr_nlsubs_cgout_nDin_2Dout(i),sdHru_nlsubs_cgout_nDin_2Dout(i)] = binnedHr_threshs(sdim,rdim,reluthrs,sig_s,sig_n,sig_m,Nstim,bw,runs,cgout,linthrs);
end

clear testresps teststim
save(savestr)

%% shuts down the parallel pool so that it can start afresh for the next block
fprintf('Hr 2D nlsubs cgout complete')
poolobj = gcp('nocreate');
delete(poolobj);



