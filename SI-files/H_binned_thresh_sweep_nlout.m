% binned H for a 2D sweep of ON and OFF nonlinear thresholds

clearvars
addpath(genpath('/home/ellag9/matlab_funcs'))

sig_s = 10;
sig_n = 0;
sig_m = 0;

sdim = 2;
rdim = 2;

threshs = -3*sig_s:sig_s:3*sig_s;

savestr = ['H_binned_thresh_sweep_nlout_6May20.mat'];

%% discrete numerics set up (binned)
Nstim = 1e6;
bw = sig_s*(1e-3); %*sqrt(sdim);
edgebound = ceil(5.5*sig_s*sqrt(sdim));
edges = -edgebound:bw:edgebound;

%% thresh sweep 2Din, 2Dout 
Hr_threshsweep_2Din_2Dout_reluout = zeros(length(threshs),length(threshs));
sdHr_threshsweep_2Din_2Dout_reluout = zeros(length(threshs),length(threshs));
mResps_reluout = zeros(length(threshs),length(threshs),rdim);

Hr_threshsweep_2Din_2Dout_cgout = zeros(length(threshs),length(threshs));
sdHr_threshsweep_2Din_2Dout_cgout = zeros(length(threshs),length(threshs));
mResps_cgout = zeros(length(threshs),length(threshs),rdim);

for i = 1:length(threshs)
    for j = 1:length(threshs)
    
    [Hr_threshsweep_2Din_2Dout_reluout(i,j),sdHr_threshsweep_2Din_2Dout_reluout(i,j),mResps_reluout(i,j,:)] = binnedHr_threshs_nlout(sdim,rdim,[threshs(i),threshs(j)],sig_s,sig_n,sig_m,Nstim,edges,'relu');
    [Hr_threshsweep_2Din_2Dout_cgout(i,j),sdHr_threshsweep_2Din_2Dout_cgout(i,j),mResps_cgout(i,j,:)] = binnedHr_threshs_nlout(sdim,rdim,[threshs(i),threshs(j)],sig_s,sig_n,sig_m,Nstim,edges,'cg');

    end
end

%%
save(savestr)


