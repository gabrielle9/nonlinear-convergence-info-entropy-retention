% binned H for a 2D sweep of ON and OFF nonlinear thresholds

clearvars
addpath(genpath('/home/ellag9/matlab_funcs'))

sig_s = 10;
sig_n = 0;
sig_m = 0;

sdim = 2;
rdim = 2;

runs = 6;

threshs = -3*sig_s:sig_s:3*sig_s;

% savestr = ['H_binned_thresh_sweep_nlout_6May20.mat'];
savestr = ['H_binned_subs_threshsweep_nlout_8Sep20.mat'];

%% discrete numerics set up (binned)
Nstim = 1e6;
bw = 0.25;

%% thresh sweep 2Din, 2Dout 
Hr_subs_threshsweep_2Din_2Dout_reluout = zeros(length(threshs),length(threshs));
sdHr_subs_threshsweep_2Din_2Dout_reluout = zeros(length(threshs),length(threshs));

for i = 1:length(threshs)
    for j = 1:length(threshs)
    
      [Hr_subs_threshsweep_2Din_2Dout_reluout(i,j),sdHr_subs_threshsweep_2Din_2Dout_reluout(i,j)] = binnedHr_threshs(sdim,rdim,[threshs(i),threshs(j)],sig_s,sig_n,sig_m,Nstim,bw,runs,'relu',[0 0]);
    end
end

%%
save(savestr)


